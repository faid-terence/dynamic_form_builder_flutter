import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:dynamic_form_generator/models/form_field.dart';

class JsonFormBuilder extends StatefulWidget {
  final List<dynamic> jsonFields;
  final Function(Map<String, dynamic>) onSubmit;

  JsonFormBuilder({
    super.key,
    required this.jsonFields,
    required this.onSubmit,
  });

  @override
  _JsonFormBuilderState createState() => _JsonFormBuilderState();
}

class _JsonFormBuilderState extends State<JsonFormBuilder> {
  final _formKey = GlobalKey<FormState>();
  final Map<String, dynamic> _formData = {};

  String? lastName;
  String? firstName;

  bool _evaluateHideExpression(String? hideExpression) {
    if (hideExpression == null || hideExpression.isEmpty) return false;
    hideExpression = hideExpression.replaceAll('model.', '');

    if (hideExpression.startsWith('!')) {
      String fieldKey = hideExpression.substring(1);
      final fieldValue = _formData[fieldKey];
      return _evaluateNegation(fieldValue);
    }

    if (hideExpression.contains('==='))
      return _evaluateEquality(hideExpression);
    if (hideExpression.contains('!=='))
      return _evaluateInequality(hideExpression);
    if (hideExpression.contains('>'))
      return _evaluateGreaterThan(hideExpression);
    if (hideExpression.contains('<')) return _evaluateLessThan(hideExpression);

    final fieldValue = _formData[hideExpression];
    return _evaluateSimpleValue(fieldValue);
  }

  bool _evaluateNegation(dynamic fieldValue) {
    if (fieldValue == null) return true;
    if (fieldValue is bool) return !fieldValue;
    if (fieldValue is String) return fieldValue.isEmpty;
    if (fieldValue is num) return fieldValue == 0;
    return true;
  }

  bool _evaluateEquality(String expression) {
    final parts = expression.split('===').map((e) => e.trim()).toList();
    if (parts.length != 2) return false;

    final leftSide = _getExpressionValue(parts[0]);
    final rightSide = _getExpressionValue(parts[1]);
    return leftSide == rightSide;
  }

  bool _evaluateInequality(String expression) {
    final parts = expression.split('!==').map((e) => e.trim()).toList();
    if (parts.length != 2) return false;

    final leftSide = _getExpressionValue(parts[0]);
    final rightSide = _getExpressionValue(parts[1]);
    return leftSide != rightSide;
  }

  bool _evaluateGreaterThan(String expression) {
    final parts = expression.split('>').map((e) => e.trim()).toList();
    if (parts.length != 2) return false;

    final leftSide = _getExpressionValue(parts[0]);
    final rightSide = _getExpressionValue(parts[1]);
    return leftSide is num && rightSide is num && leftSide > rightSide;
  }

  bool _evaluateLessThan(String expression) {
    final parts = expression.split('<').map((e) => e.trim()).toList();
    if (parts.length != 2) return false;

    final leftSide = _getExpressionValue(parts[0]);
    final rightSide = _getExpressionValue(parts[1]);
    return leftSide is num && rightSide is num && leftSide < rightSide;
  }

  dynamic _getExpressionValue(String expression) {
    if (expression.startsWith("'") && expression.endsWith("'"))
      return expression.substring(1, expression.length - 1);
    if (expression.startsWith('"') && expression.endsWith('"'))
      return expression.substring(1, expression.length - 1);
    if (double.tryParse(expression) != null) return double.parse(expression);
    if (expression == 'true') return true;
    if (expression == 'false') return false;
    return _formData[expression];
  }

  bool _evaluateSimpleValue(dynamic fieldValue) {
    if (fieldValue == null) return false;
    if (fieldValue is bool) return fieldValue;
    if (fieldValue is String) return fieldValue.isNotEmpty;
    if (fieldValue is num) return fieldValue != 0;
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          ...widget.jsonFields.map((field) {
            final config =
                FormFieldConfig.fromJson(field as Map<String, dynamic>);

            if (_evaluateHideExpression(config.hideExpression)) {
              return const SizedBox.shrink();
            }

            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: _buildFormField(config),
            );
          }).toList(),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: _submitForm,
            child: const Text('Submit'),
          ),
        ],
      ),
    );
  }

  Widget _buildFormField(FormFieldConfig config) {
    return ValueListenableBuilder<Map<String, dynamic>>(
      valueListenable: _getFormDataNotifier(),
      builder: (context, _, __) {
        if (_evaluateHideExpression(config.hideExpression)) {
          return const SizedBox.shrink();
        }

        switch (config.type) {
          case 'custom-input':
            return _buildTextFormField(config);
          case 'custom-select':
            return _buildDropdownField(config);
          case 'custom-date':
            return _buildDateField(config);
          case 'custom-radio':
            return _buildRadioField(config);
          case 'NID':
            return _buildNIDField(config);
          default:
            return const SizedBox.shrink();
        }
      },
    );
  }

  ValueNotifier<Map<String, dynamic>> _getFormDataNotifier() {
    return ValueNotifier(_formData);
  }

  void _updateFormData(String key, dynamic value) {
    setState(() {
      _formData[key] = value;
      _getFormDataNotifier().value = Map.from(_formData);
    });
  }

  Widget _buildTextFormField(FormFieldConfig config) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(config.templateOptions.label,
            style: const TextStyle(
                fontSize: 14,
                color: Colors.black,
                fontWeight: FontWeight.bold)),
        const SizedBox(height: 12),
        TextFormField(
          decoration: InputDecoration(
            hintText: config.templateOptions.placeholder,
            border: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(12))),
          ),
          maxLines: config.templateOptions.rows ?? 1,
          keyboardType: _getKeyboardType(config.templateOptions.type),
          validator: (value) => config.templateOptions.required &&
                  (value == null || value.isEmpty)
              ? 'This field is required'
              : null,
          onChanged: (value) => _updateFormData(config.key, value),
          onSaved: (value) => _formData[config.key] = value,
        ),
      ],
    );
  }

  Widget _buildDropdownField(FormFieldConfig config) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(config.templateOptions.label,
            style: Theme.of(context).textTheme.bodyMedium),
        const SizedBox(height: 4),
        DropdownButtonFormField<String>(
          decoration: InputDecoration(
            hintText: config.templateOptions.placeholder,
            border: const OutlineInputBorder(),
          ),
          value: _formData[config.key] as String?,
          items: config.templateOptions.options?.map((option) {
            return DropdownMenuItem(
                value: option.value, child: Text(option.name));
          }).toList(),
          validator: (value) => config.templateOptions.required && value == null
              ? 'This field is required'
              : null,
          onChanged: (value) => _updateFormData(config.key, value),
        ),
      ],
    );
  }

  Widget _buildDateField(FormFieldConfig config) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(config.templateOptions.label,
            style: Theme.of(context).textTheme.bodyMedium),
        const SizedBox(height: 4),
        TextFormField(
          decoration: InputDecoration(
            hintText: config.templateOptions.placeholder,
            border: const OutlineInputBorder(),
            suffixIcon: const Icon(Icons.calendar_today),
          ),
          readOnly: true,
          controller:
              TextEditingController(text: _formData[config.key] as String?),
          onTap: () async {
            final date = await showDatePicker(
              context: context,
              initialDate: DateTime.now(),
              firstDate: DateTime.now(),
              lastDate: DateTime.now().add(const Duration(days: 365)),
            );
            if (date != null) {
              final format = config.templateOptions
                      .summaryFormatting?['dateFormat'] as String? ??
                  'MM/dd/yyyy';
              _updateFormData(config.key, DateFormat(format).format(date));
            }
          },
          validator: (value) => config.templateOptions.required &&
                  (value == null || value.isEmpty)
              ? 'This field is required'
              : null,
        ),
      ],
    );
  }

  Widget _buildRadioField(FormFieldConfig config) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(config.templateOptions.label,
            style: Theme.of(context).textTheme.bodyMedium),
        const SizedBox(height: 4),
        FormField<String>(
          initialValue: _formData[config.key] as String?,
          validator: (value) => config.templateOptions.required && value == null
              ? 'This field is required'
              : null,
          builder: (FormFieldState<String> state) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ...config.templateOptions.options!.map((option) {
                  return RadioListTile<String>(
                    title: Text(option.name),
                    value: option.value,
                    groupValue: _formData[config.key] as String?,
                    onChanged: (value) {
                      _updateFormData(config.key, value);
                      state.didChange(value);
                    },
                  );
                }).toList(),
                if (state.hasError)
                  Padding(
                    padding: const EdgeInsets.only(left: 12, top: 8),
                    child: Text(state.errorText!,
                        style:
                            const TextStyle(color: Colors.red, fontSize: 12)),
                  ),
              ],
            );
          },
        ),
      ],
    );
  }

  Widget _buildNIDField(FormFieldConfig config) {
    String? _validateNID(String? value) {
      if (value == null || value.isEmpty)
        return config.templateOptions.required
            ? 'This field is required'
            : null;
      if (value.length != 16) return 'NID must be 16 digits';
      if (value != '1200280054610074') return 'NID not valid';

      setState(() {
        lastName = "Faid";
        firstName = "JABO";
      });

      return null;
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(config.templateOptions.label,
            style: Theme.of(context).textTheme.bodyMedium),
        const SizedBox(height: 4),
        TextFormField(
          decoration: InputDecoration(
            hintText: config.templateOptions.placeholder,
            border: const OutlineInputBorder(),
          ),
          keyboardType: TextInputType.number,
          maxLength: 16,
          validator: _validateNID,
          onChanged: (value) {
            setState(() {
              lastName = null;
              firstName = null;
            });
            _updateFormData(config.key, value);
            _validateNID(value);
          },
        ),
        if (lastName != null && firstName != null)
          Padding(
            padding: const EdgeInsets.only(top: 8),
            child: Text(
              'Last Name: $lastName, First Name: $firstName',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ),
      ],
    );
  }

  TextInputType _getKeyboardType(String? type) {
    switch (type) {
      case 'number':
        return TextInputType.number;
      case 'url':
        return TextInputType.url;
      case 'email':
        return TextInputType.emailAddress;
      case 'tel':
        return TextInputType.phone;
      default:
        return TextInputType.text;
    }
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      widget.onSubmit(_formData);
    }
  }
}
