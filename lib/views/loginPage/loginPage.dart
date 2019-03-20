import 'package:flutter/material.dart';
import 'package:flutter_teamcity/utils/util.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => new _LoginPageState();
}

final String teamCityServerUrl = 'http://xa-tools-tcity';

class _LoginPageState extends State<LoginPage> {
  InputDecoration _inputDecoration(IconData icon) {
    return InputDecoration(
      fillColor: Colors.white,
      filled: true,
      prefixIcon: Icon(icon),
      contentPadding: EdgeInsets.fromLTRB(15, 10, 15, 10),
      enabledBorder: UnderlineInputBorder(
        borderSide: BorderSide(
          color: Colors.transparent,
          width: 0,
        ),
      ),
      focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.orangeAccent, width: 2.5)),
    );
  }

  var _titleTextStyle = TextStyle(fontSize: 45, color: Colors.white);

  var _subTitleTextStyle = TextStyle(fontSize: 25, color: Colors.white54);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
                colors: [
              HexColor('#8674fd'),
              HexColor('#55a9fe'),
              HexColor('#40c0ff'),
              HexColor('#2cd4ff'),
              HexColor('#22f09c'),
            ])),
        padding: EdgeInsets.all(15),
        child: Form(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              FractionallySizedBox(
                widthFactor: 1,
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    Padding(
                      child: Text(
                        'Leyser',
                        style: _titleTextStyle,
                      ),
                      padding: EdgeInsets.symmetric(vertical: 18),
                    ),
                    Text(
                      'Teamcity Build Download',
                      style: _subTitleTextStyle,
                    )
                  ],
                ),
              ),
              FractionallySizedBox(
                widthFactor: 0.8,
                alignment: Alignment.center,
                child: Column(
                  children: <Widget>[
                    Container(
                      child: TextFormField(
                        key: Key('userName'),
                        autofocus: true,
                        keyboardType: TextInputType.text,
                        decoration: _inputDecoration(Icons.person),
                        buildCounter: (BuildContext context,
                                {int currentLength,
                                int maxLength,
                                bool isFocused}) =>
                            null,
                        maxLength: 20,
                        maxLengthEnforced: true,
                      ),
                      margin: EdgeInsets.only(bottom: 15),
                    ),
                    Container(
                      margin: EdgeInsets.only(bottom: 15),
                      child: TextFormField(
                        key: Key('password'),
                        obscureText: true,
                        keyboardType: TextInputType.number,
                        maxLength: 30,
                        decoration: _inputDecoration(Icons.lock),
                        buildCounter: (BuildContext context,
                                {int currentLength,
                                int maxLength,
                                bool isFocused}) =>
                            null,
                      ),
                    ),
                    TextFormField(
                      key: Key('serverUrl'),
                      keyboardType: TextInputType.url,
                      maxLength: 100,
                      initialValue: teamCityServerUrl,
                      decoration: _inputDecoration(Icons.link),
                      style: TextStyle(color: Colors.black),
                      buildCounter: (BuildContext context,
                              {int currentLength,
                              int maxLength,
                              bool isFocused}) =>
                          null,
                    )
                  ],
                ),
              ),
              ButtonTheme(
                minWidth: 150,
                height: 50,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(50))),
                child: RaisedButton(
                  onPressed: () {},
                  textColor: Colors.white,
                  child: Text(
                    'Login',
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                  padding: EdgeInsets.all(10.0),
                ),
              )
            ],
          ),
        ),
      ),
    ));
  }
}
