import 'package:flutter/material.dart';
import 'package:dartssh2/dartssh2.dart';

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
  late final String sshName, sshPassword;

  Future<void> _makeSSHConnection() async {
    print(sshName + " " + sshPassword);
    final client = SSHClient(
      await SSHSocket.connect('localhost', 22),
      username: sshName,
      onPasswordRequest: () => sshPassword,
    );
    print(client);
    await client.execute("touch ~/kedi.txt");
    client.close();
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
                hintText: 'Example: root',
              ),
              onSaved: (String? value) {
                sshName = value!;
              },
            ),
            const UselessMargin(),
            TextFormField(
              obscureText: true,
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
              onSaved: (String? value) {
                sshPassword = value!;
              },
            ),
            const UselessMargin(),
            OutlinedButton(
                onPressed: _makeSSHConnection, child: const Text("Login")),
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
