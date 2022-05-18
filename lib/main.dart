import 'package:flutter/material.dart';
import 'package:wifi_configuration_2/wifi_configuration_2.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.purple,
      ),
      home: const MyHomePage(title: 'Flutnix'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const UselessMargin(),
            TextFormField(
              // ignore: prefer_const_constructors
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.all(10),
                icon: const Icon(Icons.person),
                labelText: 'Enter your ssh username',
                border: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(26)),
                ),
                hintText: 'Example: root@128.0.0.1',
              ),
              onSaved: (String? value) {},
            ),
            const UselessMargin(),
            TextFormField(
              // ignore: prefer_const_constructors
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.all(10),
                labelText: 'Enter your ssh password',
                icon: const Icon(Icons.password),
                border: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(26)),
                ),
                hintText: '*************',
              ),
              onSaved: (String? value) {},
            ),
            const UselessMargin(),
            OutlinedButton(
                onPressed: _incrementCounter, child: const Text("Login")),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headline4,
            ),
          ],
        ),
      ),
    );
  }
}

class UselessMargin extends StatelessWidget {
  const UselessMargin({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(
          left: 10.0, top: 10.0, right: 10.0, bottom: 10.0),
    );
  }
}
