
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BottomNavigation extends StatefulWidget {

  Function(int) notifyParent;

  BottomNavigation({this.notifyParent});

  @override
  State<StatefulWidget> createState() => _BottomNavigationState();

}

class _BottomNavigationState extends State<BottomNavigation>{

  int _currentIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _currentIndex = index;
      widget.notifyParent(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      items: [
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.filter_drama),
          label: 'Data from db',
        ),
//        BottomNavigationBarItem(
//          icon: Icon(Icons.bar_chart),
//          label: 'Charts',
//        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.image_search),
          label: 'Images',
        ),
      ],
      selectedItemColor: Colors.blue[800],
      onTap: _onItemTapped,
      currentIndex: _currentIndex,
    );
  }
}