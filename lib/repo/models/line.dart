import 'package:equatable/equatable.dart';

class Line extends Equatable {
  int _len;
  int get len => _len;
  set len(int value) {
    _len = value;
  }

  double _angle;
  double get angle => _angle;
  set angle(double value) {
    _angle = value;
  }

  Line(this._len, this._angle);

  @override
  List<Object?> get props => [_len, _angle];
}
