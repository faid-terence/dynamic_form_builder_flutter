import 'package:dynamic_form_generator/components/my_custom_button.dart';
import 'package:dynamic_form_generator/models/form_field.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class JsonFormBuilder extends StatefulWidget {
  final List<dynamic> jsonFields;
  final Function(Map<String, dynamic>) onSubmit;

  const JsonFormBuilder({
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

  bool _evaluateHideExpression(String? hideExpression) {
    if (hideExpression == null || hideExpression.isEmpty) return false;

    // Remove 'model.' prefix if present
    hideExpression = hideExpression.replaceAll('model.', '');

    // Handle simple negation
    if (hideExpression.startsWith('!')) {
      String fieldKey = hideExpression.substring(1);
      final fieldValue = _formData[fieldKey];
      return _evaluateNegation(fieldValue);
    }

    // Handle equality comparison
    if (hideExpression.contains('===')) {
      return _evaluateEquality(hideExpression);
    }

    // Handle inequality comparison
    if (hideExpression.contains('!==')) {
      return _evaluateInequality(hideExpression);
    }

    // Handle greater than
    if (hideExpression.contains('>')) {
      return _evaluateGreaterThan(hideExpression);
    }

    // Handle less than
    if (hideExpression.contains('<')) {
      return _evaluateLessThan(hideExpression);
    }

    // Handle simple field reference
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

    if (leftSide is num && rightSide is num) {
      return leftSide > rightSide;
    }
    return false;
  }

  bool _evaluateLessThan(String expression) {
    final parts = expression.split('<').map((e) => e.trim()).toList();
    if (parts.length != 2) return false;

    final leftSide = _getExpressionValue(parts[0]);
    final rightSide = _getExpressionValue(parts[1]);

    if (leftSide is num && rightSide is num) {
      return leftSide < rightSide;
    }
    return false;
  }

  dynamic _getExpressionValue(String expression) {
    // Remove quotes from string literals
    if (expression.startsWith("'") && expression.endsWith("'")) {
      return expression.substring(1, expression.length - 1);
    }
    if (expression.startsWith('"') && expression.endsWith('"')) {
      return expression.substring(1, expression.length - 1);
    }

    // Handle numeric literals
    if (double.tryParse(expression) != null) {
      return double.parse(expression);
    }

    // Handle boolean literals
    if (expression == 'true') return true;
    if (expression == 'false') return false;

    // Handle field references
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

            // Evaluate hide expression
            if (_evaluateHideExpression(config.hideExpression)) {
              return const SizedBox.shrink();
            }

            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: _buildFormField(config),
            );
          }),
          const SizedBox(height: 20),
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
              fontWeight: FontWeight.bold,
            )),
        const SizedBox(height: 12),
        TextFormField(
          decoration: InputDecoration(
            hintText: config.templateOptions.placeholder,
            border: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(12))),
          ),
          maxLines: config.templateOptions.rows ?? 1,
          keyboardType: _getKeyboardType(config.templateOptions.type),
          validator: (value) {
            if (config.templateOptions.required &&
                (value == null || value.isEmpty)) {
              return 'This field is required';
            }
            return null;
          },
          onChanged: (value) {
            _updateFormData(config.key, value);
          },
          onSaved: (value) {
            _formData[config.key] = value;
          },
        ),
      ],
    );
  }

  Widget _buildDropdownField(FormFieldConfig config) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          config.templateOptions.label,
          style: Theme.of(context).textTheme.bodyMedium,
        ),
        const SizedBox(height: 4),
        DropdownButtonFormField<String>(
          decoration: InputDecoration(
            hintText:
                config.templateOptions.placeholder, // Placeholder as hint text
            border: const OutlineInputBorder(),
          ),
          value: _formData[config.key] as String?,
          items: config.templateOptions.options?.map((option) {
            return DropdownMenuItem(
              value: option.value,
              child: Text(option.name),
            );
          }).toList(),
          validator: (value) {
            if (config.templateOptions.required && value == null) {
              return 'This field is required';
            }
            return null;
          },
          onChanged: (value) {
            _updateFormData(config.key, value);
          },
        ),
      ],
    );
  }

  Widget _buildDateField(FormFieldConfig config) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          config.templateOptions.label,
          style: Theme.of(context).textTheme.bodyMedium,
        ),
        const SizedBox(height: 4),
        TextFormField(
          decoration: InputDecoration(
            hintText:
                config.templateOptions.placeholder, // Placeholder as hint text
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
          validator: (value) {
            if (config.templateOptions.required &&
                (value == null || value.isEmpty)) {
              return 'This field is required';
            }
            return null;
          },
        ),
      ],
    );
  }

  Widget _buildRadioField(FormFieldConfig config) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          config.templateOptions.label,
          style: Theme.of(context).textTheme.bodyMedium,
        ),
        const SizedBox(height: 4),
        FormField<String>(
          initialValue: _formData[config.key] as String?,
          validator: (value) {
            if (config.templateOptions.required && value == null) {
              return 'This field is required';
            }
            return null;
          },
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
                    child: Text(
                      state.errorText!,
                      style: const TextStyle(color: Colors.red, fontSize: 12),
                    ),
                  ),
              ],
            );
          },
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
