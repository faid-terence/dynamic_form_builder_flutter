import 'package:dynamic_form_generator/models/field_option.dart';

class TemplateOptions {
  final String? type;
  final bool required;
  final String label;
  final String? placeholder;
  final String summarySection;
  final List<FieldOption>? options;
  final int? rows;
  final Map<String, dynamic>? summaryFormatting;

  TemplateOptions({
    this.type,
    this.required = false,
    required this.label,
    this.placeholder,
    required this.summarySection,
    this.options,
    this.rows,
    this.summaryFormatting,
  });

  factory TemplateOptions.fromJson(Map<String, dynamic> json) {
    List<FieldOption>? options;
    if (json['options'] != null) {
      options = (json['options'] as List)
          .map((option) => FieldOption.fromJson(option as Map<String, dynamic>))
          .toList();
    }

    return TemplateOptions(
      type: json['type'] as String?,
      required: json['required'] as bool? ?? false,
      label: json['label'] as String,
      placeholder: json['placeholder'] as String?,
      summarySection: json['summarySection'] as String,
      options: options,
      rows: json['rows'] as int?,
      summaryFormatting: json['summaryFormatting'] as Map<String, dynamic>?,
    );
  }
}
