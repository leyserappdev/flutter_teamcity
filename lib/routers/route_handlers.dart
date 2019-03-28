import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import '../views/buildsPage/buildsPage.dart';
import '../views/loginPage/loginPage.dart';
import '../views/buildTypePage/buildTypePage.dart';
import '../views/HomePage.dart';

Handler rootHandler = new Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  return new HomePage();
});

Handler loginHandler = new Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  return new LoginPage();
});

Handler buildTypeHandler = new Handler(
  handlerFunc: (BuildContext context, Map<String, List<String>> params){
    String projectId = params["projectId"]?.first;
    String projectName = params["projectName"]?.first;
    return new BuildTypePage(projectId, projectName);
  }
);

Handler buildsHandler = new Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  String buildTypeId = params["buildTypeId"]?.first;
  String buildTypeName = params["buildTypeName"]?.first;
  return new BuildsPage(buildTypeId, buildTypeName);
});
