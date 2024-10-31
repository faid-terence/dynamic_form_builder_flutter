import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:dynamic_form_generator/models/form_field.dart';
import 'package:provider/provider.dart';
import 'package:dynamic_form_generator/provider/form_state_provider.dart';

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

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: widget.jsonFields.map((field) {
          final config =
              FormFieldConfig.fromJson(field as Map<String, dynamic>);

          if (_evaluateHideExpression(config.hideExpression, context)) {
            return const SizedBox.shrink();
          }

          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: _buildFormField(config),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildFormField(FormFieldConfig config) {
    return Consumer<FormStateProvider>(
      builder: (context, formState, _) {
        if (_evaluateHideExpression(config.hideExpression, context)) {
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
    return Consumer<FormStateProvider>(
      builder: (context, formState, _) {
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
              onChanged: (value) {
                formState.updateFormData(config.key, value);
              },
              initialValue: formState.getFieldValue(config.key)?.toString(),
            ),
          ],
        );
      },
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
    return Consumer<FormStateProvider>(
      builder: (context, formState, _) {
        void validateAndSubmitNID(String value) {
          formState.updateFormData(config.key, value);

          if (value.length != 16) {
            formState.setNIDValidationError('NID must be 16 digits');
            return;
          }

          if (value != '1200280054610074') {
            formState.setNIDValidationError('NID not valid');
            return;
          }

          formState.setNIDData(value);
          widget.onSubmit(formState.formData);
        }

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
                hintText: config.templateOptions.placeholder,
                border: const OutlineInputBorder(),
                errorText: formState.nidValidationMessage,
              ),
              keyboardType: TextInputType.number,
              maxLength: 16,
              onChanged: (value) {
                formState.updateFormData(config.key, value);

                if (value.length == 16) {
                  validateAndSubmitNID(value);
                } else {
                  formState.clearNIDData();
                }
              },
            ),
            if (formState.lastName != null &&
                formState.firstName != null &&
                formState.ammountToPay != null)
              Padding(
                padding: const EdgeInsets.only(top: 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Last Name: ${formState.lastName}',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'First Name: ${formState.firstName}',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    const SizedBox(height: 4),
                    Text.rich(
                      TextSpan(
                        text: 'Outstanding Amount: ',
                        style: Theme.of(context).textTheme.bodyMedium,
                        children: <TextSpan>[
                          TextSpan(
                            text: '${formState.ammountToPay}',
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium
                                ?.copyWith(fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
          ],
        );
      },
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

  bool _evaluateHideExpression(String? hideExpression, BuildContext context) {
    if (hideExpression == null || hideExpression.isEmpty) return false;
    hideExpression = hideExpression.replaceAll('model.', '');

    final formState = context.read<FormStateProvider>();
    
    // Special case for AMOUNT_TO_PAY field
    if (hideExpression == '!ID_NUMBER') {
      // Hide if NID is not validated successfully
      return formState.nidValidationMessage != null || formState.nidData == null;
    }

    final formData = formState.formData;

    if (hideExpression.startsWith('!')) {
      String fieldKey = hideExpression.substring(1);
      final fieldValue = formData[fieldKey];
      return _evaluateNegation(fieldValue);
    }

    if (hideExpression.contains('==='))
      return _evaluateEquality(hideExpression);
    if (hideExpression.contains('!=='))
      return _evaluateInequality(hideExpression);
    if (hideExpression.contains('>'))
      return _evaluateGreaterThan(hideExpression);
    if (hideExpression.contains('<')) return _evaluateLessThan(hideExpression);

    final fieldValue = formData[hideExpression];
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

    final formData = context.read<FormStateProvider>().formData;
    return formData[expression];
  }

  bool _evaluateSimpleValue(dynamic fieldValue) {
    if (fieldValue == null) return false;
    if (fieldValue is bool) return fieldValue;
    if (fieldValue is String) return fieldValue.isNotEmpty;
    if (fieldValue is num) return fieldValue != 0;
    return false;
  }
}
