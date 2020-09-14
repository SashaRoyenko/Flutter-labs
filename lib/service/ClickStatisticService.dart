import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_app_1/entity/ClickStatistic.dart';
import 'package:flutter_app_1/service/ColorService.dart';
import 'package:flutter_app_1/util/DbConnection.dart';
import 'package:mongo_dart/mongo_dart.dart';

class ClickStatisticService {
  DBConnection _dbConnection = DBConnection.getInstance();
  ColorService _colorService = ColorService();

  static final String _COLLECTION_NAME = "button_statistic";

  void save(ClickStatistic clickStatistic) async {
    Db _db = await _dbConnection.getConnection();
    DbCollection collection = _db.collection(_COLLECTION_NAME);
    var parameterMap = _getParameterMap(clickStatistic);
    collection.save(parameterMap);
  }

  Future<List<ClickStatistic>> getAll()  async {
    Db _db = await _dbConnection.getConnection();
    var collection = _db.collection(_COLLECTION_NAME);
    return collection.find(where.sortBy('dateTime', descending: true)).map((element) {
      Color backgroundColor =
          _colorService.getColorFromHex(element["backgroundColor"]);
      Color buttonColor = _colorService.getColorFromHex(element["buttonColor"]);
      var clickStatistic = ClickStatistic(backgroundColor, buttonColor, element["dateTime"]);
      clickStatistic.id = element["_id"];
      return clickStatistic;
    }).toList();

  }

  void delete(ObjectId id) async {
    Db _db = await _dbConnection.getConnection();
    var collection = _db.collection(_COLLECTION_NAME);
    collection.remove(where.id(id));
  }

  Map<String, dynamic> _getParameterMap(ClickStatistic clickStatistic) {
    return {
      "buttonColor": clickStatistic.buttonColor.toString(),
      "backgroundColor": clickStatistic.backgroundColor.toString(),
      "dateTime": clickStatistic.dateTime
    };
  }
}
