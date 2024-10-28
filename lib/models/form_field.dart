import 'package:dynamic_form_generator/models/template_options.dart';

class FormFieldConfig {
  final String key;
  final String type;
  final String? hideExpression;
  final TemplateOptions templateOptions;

  FormFieldConfig({
    required this.key,
    required this.type,
    required this.templateOptions,
    this.hideExpression,
  });

  factory FormFieldConfig.fromJson(Map<String, dynamic> json) {
    return FormFieldConfig(
      key: json['key'] as String,
      type: json['type'] as String,
      hideExpression: json['hideExpression'] as String?,
      templateOptions: TemplateOptions.fromJson(
          json['templateOptions'] as Map<String, dynamic>),
    );
  }
}
