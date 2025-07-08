class CustomSymbolEntry {
  final int? id;
  final String name;
  final String expression;

  CustomSymbolEntry({this.id, required this.name, required this.expression});

  factory CustomSymbolEntry.fromMap(Map<String, dynamic> json) =>
      CustomSymbolEntry(id: json['id'], name: json['name'], expression: json['expression']);

  Map<String, dynamic> toMap() => {'id': id, 'name': name, 'expression': expression};

  Map<String, dynamic> toMapForInsert() => {'name': name, 'expression': expression};

  @override
  String toString() => "{ id: $id, name: $name, expression: $expression }";
}
