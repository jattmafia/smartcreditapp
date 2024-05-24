class Field {
  final String name;
  final String type;
  final List<String>? options;

  Field({
    required this.name,
    required this.type,
    this.options,
  });
}
