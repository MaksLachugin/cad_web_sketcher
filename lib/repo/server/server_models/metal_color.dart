// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:equatable/equatable.dart';

class MetalColor extends Equatable {
  final String id;
  final String name;
  final String ral;
  const MetalColor({
    required this.id,
    required this.name,
    required this.ral,
  });

  MetalColor copyWith({
    String? id,
    String? name,
    String? ral,
  }) {
    return MetalColor(
      id: id ?? this.id,
      name: name ?? this.name,
      ral: ral ?? this.ral,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'ral': ral,
    };
  }

  factory MetalColor.fromMap(Map<String, dynamic> map) {
    return MetalColor(
      id: map['id'] as String,
      name: map['name'] as String,
      ral: map['ral'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory MetalColor.fromJson(String source) =>
      MetalColor.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'MetalColor(id: $id, name: $name, ral: $ral)';

  @override
  bool operator ==(covariant MetalColor other) {
    if (identical(this, other)) return true;

    return other.id == id && other.name == name && other.ral == ral;
  }

  @override
  int get hashCode => id.hashCode ^ name.hashCode ^ ral.hashCode;

  @override
  List<Object?> get props => [id, name, ral];
}
