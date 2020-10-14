import 'package:flutter/material.dart';
import 'package:workout_exercises/pages/CategoriesPage.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Workout Exercises',
      theme: ThemeData(
        // Define the default Brightness and Colors
        brightness: Brightness.dark,
        primaryColor: Colors.blueGrey[900],
        accentColor: Colors.orangeAccent,

        // Define a familia de font default
        fontFamily: 'Quicksand',

        // Define the default TextTheme. Use this to specify the default
        // text styling for headlines, titles, bodies of text, and more.
        textTheme: TextTheme(
          subtitle1: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
          subtitle2: TextStyle(fontSize: 14.0, fontWeight: FontWeight.bold),
          bodyText1: TextStyle(fontSize: 14.0),
          bodyText2: TextStyle(fontSize: 14.0, fontStyle: FontStyle.italic),
        ),
      ),
      home: CategoriesPage(),
    );
  }
}
