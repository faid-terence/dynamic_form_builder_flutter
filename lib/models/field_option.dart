class FieldOption {
  final String name;
  final String value;

  FieldOption({required this.name, required this.value});

  factory FieldOption.fromJson(Map<String, dynamic> json) {
    return FieldOption(
      name: json['name'] as String,
      value: json['value'] as String,
    );
  }
}
