import 'package:flutter/material.dart';
import '../../utils/util.dart';
import '../../utils/sharedPreferences.dart';
import '../../routers/application.dart';
import 'package:fluro/fluro.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => new _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  String _userName;
  String _serverUrl;

  void initState() {
    super.initState();

    SpUtil.getInstance().then((SpUtil spUtil) {
      setState(() {
        _userName = spUtil.getString(SharedPreferencesKeys.loginUserName);
        _serverUrl = spUtil.getString(SharedPreferencesKeys.teamCityServerUrl);
      });
    });
  }

  _logout() async {
    await logout();
    Application.router.navigateTo(context, '/login',
        transition: TransitionType.inFromBottom, clearStack: true);
  }

  @override
  Widget build(BuildContext context) {
    return new Container(
        child: Column(
      children: <Widget>[
        ListTile(
          leading: Icon(Icons.person),
          title: Text('Login User'),
          subtitle: Text('$_userName'),
        ),
        ListTile(
          leading: Icon(Icons.link),
          title: Text('Login server url'),
          subtitle: Text('$_serverUrl'),
        ),
        AboutListTile(
          icon: Icon(Icons.info),
          applicationName: "Leyser Teamcity Build Downloader",
          applicationVersion: "0.0.1",
        ),
        Divider(),
        RaisedButton(
          child: Text('Log out'),
          onPressed: () {
            _logout();
          },
        ),
      ],
    ));
  }
}
