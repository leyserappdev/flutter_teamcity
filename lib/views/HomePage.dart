import 'package:flutter/material.dart';
import './profilePage/profilePage.dart';
import './projectsPage/projectsPage.dart';

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _HomePageStateful();
}

class _HomePageStateful extends State<HomePage> {
  int _currentPageIndex = 0;

  PageController _controller = PageController();

  static const _pageTitles = ['Projects', 'Favorite Projects', 'Profile'];

  void _onItemTapped(int index) {
    _controller.animateToPage(index,
        duration: new Duration(milliseconds: 200), curve: Curves.ease);
    setState(() {
      _currentPageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(_pageTitles[_currentPageIndex])),
      body: PageView(
        controller: _controller,
        children: [
          ProjectsPage(false),
          ProjectsPage(true),
          ProfilePage(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
              icon: Icon(Icons.list),
              title: Text('Projects'),
              activeIcon: Icon(Icons.list)),
          BottomNavigationBarItem(
              icon: Icon(Icons.favorite_border),
              title: Text('Favorite'),
              activeIcon: Icon(Icons.favorite)),
          BottomNavigationBarItem(
              icon: Icon(Icons.people_outline),
              title: Text('Profile'),
              activeIcon: Icon(Icons.people)),
        ],
        currentIndex: _currentPageIndex,
        fixedColor: Colors.deepPurple,
        type: BottomNavigationBarType.fixed,
        onTap: _onItemTapped,
      ),
    );
  }
}
