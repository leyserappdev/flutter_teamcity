import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import '../views/buildsPage/buildsPage.dart';
import '../views/loginPage/loginPage.dart';
import '../views/profilePage/profilePage.dart';
import '../views/projectsPage/projectsPage.dart';

Handler rootHandler = new Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
      var hasLogin = false;
      if (hasLogin){
        return new ProjectsPage(false);
      } else {
        return new LoginPage();
      }
});

Handler projectsHandler = new Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  return new ProjectsPage(false);
});

Handler favoriteProjectsHandler = new Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  return new ProjectsPage(true);
});

Handler loginHandler = new Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  return new LoginPage();
});

Handler profileHandler = new Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  return new ProfilePage();
});

Handler buildsHandler = new Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  int projectId = int.tryParse(params["projectId"]?.first);
  return new BuildsPage(projectId);
});
