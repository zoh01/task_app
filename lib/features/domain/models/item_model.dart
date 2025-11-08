class ItemModel {
  final String id;
  final String title;
  final String? notes;
  final DateTime createdAt;

  ItemModel({
    required this.id,
    required this.title,
    this.notes,
    required this.createdAt,
  });

  Map<String, dynamic> toMap() => {
    'id': id,
    'title': title,
    'notes': notes,
    'createdAt': createdAt.toIso8601String(),
  };

  factory ItemModel.fromMap(Map<dynamic, dynamic> map) => ItemModel(
    id: map['id'] as String,
    title: map['title'] as String,
    notes: map['notes'] as String?,
    createdAt: DateTime.parse(map['createdAt'] as String),
  );
}