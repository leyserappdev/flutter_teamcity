import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import './route_handlers.dart';

class Routes {
  static String root = '/';
  static String login = '/login';
  static String projects = '/projects';
  static String favoriteProjects = '/favoriteProjects';
  static String builds = '/builds/:projectId';
  static String profile = '/profile';


  static void configureRoutes(Router router){
    router.notFoundHandler = new Handler(
      handlerFunc: (BuildContext context,  Map<String, List<String>> params){
        //TODO: 丰满下404 Page
        print('Router was not Found!');
      }
    );

    router.define(root, handler: rootHandler);
    router.define(login, handler: loginHandler);
    router.define(projects, handler: projectsHandler);
    router.define(favoriteProjects, handler: favoriteProjectsHandler);
    router.define(builds, handler: buildsHandler);
    router.define(profile, handler: profileHandler);
    
  }
}