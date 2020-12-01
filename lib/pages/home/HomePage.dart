import 'package:flutter/material.dart';
import 'package:flutter_app_1/pages/parts/BottomNavigation.dart';
import 'package:flutter_app_1/pages/parts/Button.dart';
import 'package:flutter_app_1/pages/statistic/StatisticPage.dart';

import '../images_page.dart';

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  Color _backGroundColor = Colors.blueAccent;
  Color _buttonColor = Colors.amberAccent;
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    List<Widget> _widgetOptions = <Widget>[
      Container(
        color: _backGroundColor,
        child: Button(
            _buttonColor,
            notifyParent: _changeColor,
        ),
      ),
      Container(child: StatisticPage()),
//      Text("Chart"),
      ImagesFromNetwork()
    ];

    return Scaffold(
        appBar: AppBar(
          title: Text("Oleksandr Roienko TI-72 first lab"),
          centerTitle: true,
        ),
        body: _widgetOptions[_currentIndex],
        bottomNavigationBar: BottomNavigation(notifyParent: getCurrentIndex)
    );
  }

  void _changeColor(Color backgroundColor, Color buttonColor) {
    setState(() {
      _backGroundColor = backgroundColor;
      _buttonColor = buttonColor;
    });
  }

  void getCurrentIndex(int childIndex) {
    setState(() {
      _currentIndex = childIndex;
    });
  }
}
