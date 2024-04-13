// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class MetalThickness {
  final String id;
  final String name;
  MetalThickness({
    required this.id,
    required this.name,
  });

  MetalThickness copyWith({
    String? id,
    String? name,
  }) {
    return MetalThickness(
      id: id ?? this.id,
      name: name ?? this.name,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
    };
  }

  factory MetalThickness.fromMap(Map<String, dynamic> map) {
    return MetalThickness(
      id: map['id'] as String,
      name: map['name'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory MetalThickness.fromJson(String source) =>
      MetalThickness.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'MetalThickness(id: $id, name: $name)';

  @override
  bool operator ==(covariant MetalThickness other) {
    if (identical(this, other)) return true;

    return other.id == id && other.name == name;
  }

  @override
  int get hashCode => id.hashCode ^ name.hashCode;
}
