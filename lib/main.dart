import 'package:flutter/material.dart';
import 'routers/application.dart';
import 'package:dio/dio.dart';
import 'package:fluro/fluro.dart';
import './routers/routers.dart';
import './utils/sharedPreferences.dart';
import './views/loginPage/loginPage.dart';
import './views/HomePage.dart';
import './utils/http.dart';

SpUtil spUtil;

class MyApp extends StatelessWidget {
  MyApp() {
    final router = new Router();
    Routes.configureRoutes(router);
    Application.router = router;
  }

  Widget showHomePage() {
    bool hasLogin = spUtil.getBool(SharedPreferencesKeys.hasLogin);
    if (hasLogin == null || !hasLogin) {
      return LoginPage();
    } else {
      return HomePage();
    }
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
        debugShowCheckedModeBanner: false,
        initialRoute: '/',
        home: showHomePage());
    print('......initial route = ${app.initialRoute}');
    return app;
  }
}

//Global Entry
void main() async {
  dio.interceptors..add(LogInterceptor());
  dio.options.receiveTimeout = 10000;
  spUtil = await SpUtil.getInstance();
  runApp(MyApp());
}
