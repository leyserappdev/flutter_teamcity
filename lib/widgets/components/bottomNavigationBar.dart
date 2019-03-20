import 'package:flutter/material.dart';
import 'package:flutter_teamcity/routers/application.dart';
import 'package:fluro/fluro.dart';


class BottomNavigatorBar extends StatefulWidget {
  @override
  _BottomNavigatorBarState createState() => _BottomNavigatorBarState();
}

class _BottomNavigatorBarState extends State<BottomNavigatorBar>{
  int _currentIndex = 0;

  final _navigatorRoutes = ['/projects', '/favoriteProjects', '/profile'];

  void _onItemTapped(int index){
    setState(() {
      _currentIndex = index;
    });
    Application.router.navigateTo(context, _navigatorRoutes[index], transition: TransitionType.inFromLeft);
  }

  @override build(BuildContext context){
    return BottomNavigationBar(
      items: <BottomNavigationBarItem>[
        BottomNavigationBarItem(icon: Icon(Icons.list), title: Text('Projects'), activeIcon: Icon(Icons.list)),
        BottomNavigationBarItem(icon: Icon(Icons.favorite_border), title: Text('Favorite'), activeIcon: Icon(Icons.favorite)),
        BottomNavigationBarItem(icon: Icon(Icons.people_outline), title: Text('Profile'), activeIcon: Icon(Icons.people)),
      ],
      currentIndex: _currentIndex,
      fixedColor: Colors.deepPurple,
      onTap: _onItemTapped,
    );
  }
}