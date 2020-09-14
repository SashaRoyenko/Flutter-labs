import 'package:flutter/material.dart';
import 'package:flutter_app_1/entity/ClickStatistic.dart';
import 'package:flutter_app_1/service/ClickStatisticService.dart';
import 'package:flutter_app_1/service/ColorService.dart';

class Button extends StatefulWidget {

  Function(Color, Color) notifyParent;
  Color _buttonColor;
  Button(this._buttonColor, {this.notifyParent});

  @override
  State<StatefulWidget> createState() => _ButtonState();
}

class _ButtonState extends State<Button> {
  ColorService _randomColorService = ColorService();
  ClickStatisticService _clickStatisticService = ClickStatisticService();

  void _updateStateAndSaveData() {
    setState(() {
      widget._buttonColor = _randomColorService.createRandomColor();
      var parentBackGroundColor = _randomColorService.createRandomColor();
      widget.notifyParent(parentBackGroundColor, widget._buttonColor);
      ClickStatistic clickStatistic =
          ClickStatistic(parentBackGroundColor, widget._buttonColor, DateTime.now());
      _clickStatisticService.save(clickStatistic);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
        child: MaterialButton(
          onPressed: () => _updateStateAndSaveData(),
          color: widget._buttonColor,
          padding: EdgeInsets.all(100),
          shape: CircleBorder(side: BorderSide.none),
          child: Text(
            "Push me",
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 54,
                color: Colors.white,
                fontFamily: "Ranchers",
                letterSpacing: 5),
          ),
    ));
  }
}
