import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import '../views/buildsPage/buildsPage.dart';
import '../views/loginPage/loginPage.dart';
import '../views/buildTypePage/buildTypePage.dart';
import '../views/HomePage.dart';

Handler notFoundHandler = new Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  var text = 'Router ${params.toString()} was not Found!';
  print(text);
  //TODO: rio. 调查初次登录后route为空的问题。 临时性的先把路由导航到Homepage
  return HomePage();
});

Handler rootHandler = new Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  return new HomePage();
});

Handler loginHandler = new Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  return new LoginPage();
});

Handler buildTypeHandler = new Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  String projectId = params["projectId"]?.first;
  String projectName = params["projectName"]?.first;
  return new BuildTypePage(projectId, projectName);
});

Handler buildsHandler = new Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  String buildTypeId = params["buildTypeId"]?.first;
  String buildTypeName = params["buildTypeName"]?.first;
  return new BuildsPage(buildTypeId, buildTypeName);
});
