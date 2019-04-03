import 'package:flutter/material.dart';
import '../utils/eventBus.dart';
import './profilePage/profilePage.dart';
import './projectsPage/projectsPage.dart';

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _HomePageStateful();
}

class _HomePageStateful extends State<HomePage> {
  int _currentPageIndex = 0;
  bool _inSearch = false;
  final searchController = TextEditingController();

  PageController _controller = PageController();

  static const _pageTitles = ['Projects', 'Favorite Projects', 'Profile'];

  void _onItemTapped(int index) {
    _controller.animateToPage(index,
        duration: new Duration(milliseconds: 200), curve: Curves.ease);
  }

  AppBar getAppbar() {
    var needSearch = _currentPageIndex == 0;

    var pageTitle = Text(
      _pageTitles[_currentPageIndex],
      style: TextStyle(color: Colors.white),
    );

    if (!needSearch) {
      return AppBar(title: pageTitle);
    }

    if (_inSearch) {
      return AppBar(
        leading: Padding(
          child: IconButton(
            color: Colors.grey,
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              _exitSearchMode();
            },
          ),
          padding: EdgeInsets.only(right: 10),
        ),
        title: TextField(
          key: Key('SearchText'),
          controller: searchController,
          keyboardType: TextInputType.text,
          autofocus: true,
          maxLength: 30,
          buildCounter: (BuildContext context,
                  {int currentLength, int maxLength, bool isFocused}) =>
              null,
          maxLengthEnforced: true,
          onSubmitted: (String value) {
            eventBus.fire(new Event(EventType.projectFilter, value));
          },
        ),
        backgroundColor: Colors.white,
        actions: <Widget>[
          Padding(
            child: IconButton(
              color: Colors.grey,
              icon: Icon(Icons.close),
              onPressed: () {
                searchController.clear();
              },
              tooltip: 'Clear Input',
            ),
            padding: EdgeInsets.only(right: 10),
          )
        ],
      );
    }

    return AppBar(
      actions: <Widget>[
        Padding(
          child: IconButton(
            color: Colors.white,
            icon: Icon(Icons.search),
            onPressed: () {
              setState(() {
                _inSearch = true;
              });
            },
          ),
          padding: EdgeInsets.only(right: 10),
        )
      ],
      title: pageTitle,
    );
  }

  _exitSearchMode() {
    setState(() {
      _inSearch = false;
      eventBus.fire(new Event(EventType.projectFilter, ''));
    });
  }

  Future<bool> _onBackPressed() async {
    if (_inSearch) {
      _exitSearchMode();
      return false;
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: _onBackPressed,
        child: Scaffold(
          appBar: getAppbar(),
          body: PageView(
            onPageChanged: (index) {
              setState(() {
                _currentPageIndex = index;
              });

              _exitSearchMode();
            },
            physics: _inSearch ? NeverScrollableScrollPhysics() : null,
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
        ));
  }
}
