import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import './route_handlers.dart';

class Routes {
  static String root = '/';
  static String login = '/login';
  static String buildType = '/buildType/:projectId';
  static String builds = '/builds/:buildTypeId';


  static void configureRoutes(Router router) {
    router.notFoundHandler = new Handler(
        handlerFunc: (BuildContext context, Map<String, List<String>> params) {
      //TODO: 丰满下404 Page
      print('Router was not Found!');
    });

    router.define(root, handler: rootHandler);
    router.define(login, handler: loginHandler);
    router.define(buildType, handler: buildTypeHandler);
    router.define(builds, handler: buildsHandler);
  }
}
