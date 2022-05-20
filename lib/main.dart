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
      title: 'Flutnix',
      theme: ThemeData(
        primarySwatch: Colors.purple,
      ),
      home: const MyHomePage(title: 'Flutnix'),
    );
  }
}

final inputSSHName = Padding(
  padding: const EdgeInsets.only(bottom: 10),
  child: TextField(
    keyboardType: TextInputType.emailAddress,
    decoration: InputDecoration(
        labelText: 'SSH Name',
        hintText: 'Example: root',
        icon: const Icon(Icons.person),
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 25, vertical: 20),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(50.0))),
  ),
);

final inputSSHPassword = Padding(
  padding: const EdgeInsets.only(bottom: 20),
  child: TextField(
    keyboardType: TextInputType.text,
    obscureText: true,
    decoration: InputDecoration(
        labelText: 'SSH Password',
        hintText: '*************',
        icon: const Icon(Icons.password),
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 25, vertical: 20),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(50.0))),
  ),
);
final buttonLogin = Padding(
  padding: const EdgeInsets.only(bottom: 5),
  child: ButtonTheme(
    height: 56,
    child: TextButton(
      child: const Text('Login',
          style: TextStyle(color: Colors.black87, fontSize: 20)),
      onPressed: () => {},
    ),
  ),
);

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
        child: ListView(
          shrinkWrap: true,
          padding: const EdgeInsets.symmetric(horizontal: 20),
          children: <Widget>[inputSSHName, inputSSHPassword, buttonLogin],
        ),
      ),
    );
  }
}
