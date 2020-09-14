import 'dart:ui';

import 'package:mongo_dart/mongo_dart.dart';

class ClickStatistic {

  ObjectId _id;
  Color _backgroundColor;
  Color _buttonColor;
  DateTime _dateTime;

  ClickStatistic(this._backgroundColor, this._buttonColor, this._dateTime);

  DateTime get dateTime => _dateTime;

  Color get buttonColor => _buttonColor;

  Color get backgroundColor => _backgroundColor;

  ObjectId get id => _id;

  set id(ObjectId value) {
    _id = value;
  }

  @override
  String toString() {
    return 'ClickStatistic{_backgroundColor: $_backgroundColor, _buttonColor: $_buttonColor, _dateTime: $_dateTime}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ClickStatistic &&
          runtimeType == other.runtimeType &&
          _backgroundColor == other._backgroundColor &&
          _buttonColor == other._buttonColor &&
          _dateTime == other._dateTime;

  @override
  int get hashCode =>
      _backgroundColor.hashCode ^ _buttonColor.hashCode ^ _dateTime.hashCode;

}