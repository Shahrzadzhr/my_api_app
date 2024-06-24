import 'package:flutter/material.dart';
import 'package:my_api_app/src/presentation/homepage.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Movie API App',
      home: HomePage(),
    );
  }
}
