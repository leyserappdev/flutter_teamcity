import 'package:flutter/material.dart';
import 'routers/application.dart';
import 'package:fluro/fluro.dart';
import './routers/routers.dart';

class MyApp extends StatelessWidget {
  MyApp() {
    final router = new Router();
    Routes.configureRoutes(router);
    Application.router = router;
  }

  @override
  Widget build(BuildContext context) {
    final app = new MaterialApp(
      title: 'Leyser TeamCity APP Downloader',
      theme: new ThemeData(
        buttonTheme: ButtonThemeData(textTheme: ButtonTextTheme.primary),
        accentColor: Colors.green,
        primaryColor: Colors.lightBlue,
        //TODO: complete theme data and font
      ),
      onGenerateRoute: Application.router.generator,
    );
    print('initial route = ${app.initialRoute}');
    return app;
  }
}

//Global Entry
void main() {
  runApp(MyApp());
}
