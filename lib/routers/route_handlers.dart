import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import '../views/buildsPage/buildsPage.dart';
import '../views/loginPage/loginPage.dart';
import '../views/HomePage.dart';

Handler rootHandler = new Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  return new HomePage();
});

Handler loginHandler = new Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  return new LoginPage();
});

Handler buildsHandler = new Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  int projectId = int.tryParse(params["projectId"]?.first);
  return new BuildsPage(projectId);
});
