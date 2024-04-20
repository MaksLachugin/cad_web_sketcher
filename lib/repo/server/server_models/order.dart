// ignore_for_file: public_member_api_docs, sort_constructors_first, non_constant_identifier_names
import 'dart:convert';

class Order {
  String customer = '';
  String number = '';
  String email = '';
  String comment = '';

  String figure_json;
  String figure_len;
  String width = '';
  String count = '';

  String status;
  String color;
  String thickness;
  Order({
    required this.customer,
    required this.number,
    required this.email,
    required this.comment,
    required this.figure_json,
    required this.figure_len,
    required this.width,
    required this.count,
    required this.status,
    required this.color,
    required this.thickness,
  });

  Order copyWith({
    String? customer,
    String? number,
    String? email,
    String? comment,
    String? figure_json,
    String? figure_len,
    String? width,
    String? count,
    String? status,
    String? color,
    String? thickness,
  }) {
    return Order(
      customer: customer ?? this.customer,
      number: number ?? this.number,
      email: email ?? this.email,
      comment: comment ?? this.comment,
      figure_json: figure_json ?? this.figure_json,
      figure_len: figure_len ?? this.figure_len,
      width: width ?? this.width,
      count: count ?? this.count,
      status: status ?? this.status,
      color: color ?? this.color,
      thickness: thickness ?? this.thickness,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'customer': customer,
      'number': number,
      'email': email,
      'comment': comment,
      'figure_json': figure_json,
      'figure_len': figure_len,
      'width': width,
      'count': count,
      'status': status,
      'color': color,
      'thickness': thickness,
    };
  }

  factory Order.fromMap(Map<String, dynamic> map) {
    return Order(
      customer: map['customer'] as String,
      number: map['number'] as String,
      email: map['email'] as String,
      comment: map['comment'] as String,
      figure_json: map['figure_json'] as String,
      figure_len: map['figure_len'] as String,
      width: map['width'] as String,
      count: map['count'] as String,
      status: map['status'] as String,
      color: map['color'] as String,
      thickness: map['thickness'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Order.fromJson(String source) =>
      Order.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Order(customer: $customer, number: $number, email: $email, comment: $comment, figure_json: $figure_json, figure_len: $figure_len, width: $width, count: $count, status: $status, color: $color, thickness: $thickness)';
  }

  @override
  bool operator ==(covariant Order other) {
    if (identical(this, other)) return true;

    return other.customer == customer &&
        other.number == number &&
        other.email == email &&
        other.comment == comment &&
        other.figure_json == figure_json &&
        other.figure_len == figure_len &&
        other.width == width &&
        other.count == count &&
        other.status == status &&
        other.color == color &&
        other.thickness == thickness;
  }

  @override
  int get hashCode {
    return customer.hashCode ^
        number.hashCode ^
        email.hashCode ^
        comment.hashCode ^
        figure_json.hashCode ^
        figure_len.hashCode ^
        width.hashCode ^
        count.hashCode ^
        status.hashCode ^
        color.hashCode ^
        thickness.hashCode;
  }
}
