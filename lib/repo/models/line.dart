// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:equatable/equatable.dart';

class Line extends Equatable {
  final double len;

  final double angle;

  Line(
    this.len,
    angle,
  ) : angle = convert(angle);

  @override
  List<Object> get props => [len, angle];

  Line copyWith({
    double? len,
    double? angle,
  }) {
    return Line(
      len ?? this.len,
      angle ?? convert(this.angle),
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'len': len,
      'angle': angle,
    };
  }

  factory Line.fromMap(Map<String, dynamic> map) {
    return Line(
      map['len'] as double,
      map['angle'] as double,
    );
  }

  String toJson() => json.encode(toMap());

  factory Line.fromJson(String source) =>
      Line.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;
}

double convert(angle) {
  if (angle >= 181) {
    return -179;
  } else if (angle <= -181) {
    return 179;
  }
  return angle;
}
