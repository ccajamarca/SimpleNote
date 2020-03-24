import 'package:flutter/material.dart';
import 'package:flutter_basics/src/pages/add_note.dart';
import 'package:flutter_basics/src/pages/home_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Basics',
      initialRoute: '/',
      routes: {
        '/': (BuildContext context) => HomePage(),
        'addnote': (BuildContext context) => AddNote() 
      },
    );
  }
}