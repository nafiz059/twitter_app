import 'package:flutter/material.dart';

import 'Pages/home_page.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Twiteer Clone App',
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Twiteer Clone App'),
        ),
        body: HomePage(),
      ),
    );
  }
}
