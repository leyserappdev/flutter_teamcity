import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import './route_handlers.dart';

class Routes {
  static String root = '/';
  static String login = '/login';
  static String buildType = '/buildType/:projectId/:projectName';
  static String builds = '/builds/:buildTypeId/:buildTypeName';

  static void configureRoutes(Router router) {
    router.notFoundHandler = notFoundHandler;

    router.define(root, handler: rootHandler);
    router.define(login, handler: loginHandler);
    router.define(buildType, handler: buildTypeHandler);
    router.define(builds, handler: buildsHandler);
  }
}
