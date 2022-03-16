import 'package:flutter/material.dart';
import 'package:denizeryilmazhw/pages/page1_view.dart';

void main() => runApp(const App());

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Lusefull',
      home: const HomePage(),
      darkTheme: ThemeData.dark(),
    );
  }
}
