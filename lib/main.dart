import 'package:flutter/material.dart';
import 'routers/application.dart';



class MyApp extends StatelessWidget {
  MyApp(){

  }

  @override
  Widget build(BuildContext context){
    return new MaterialApp(
      title: 'Leyser TeamCity APP Downloader',
      theme: new ThemeData(
        primaryColor: Colors.lightBlue
        //TODO: complete theme data and font
      ),
      onGenerateRoute: Application.router.generator,
    );
  }
}

//Global Entry
void main(){
  runApp(MyApp());
}
