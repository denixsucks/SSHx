import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:dartssh2/dartssh2.dart';

Future<void> main() async {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Home(),
    );
  }
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

//----------------------------- STATES
class _HomeState extends State<Home> {
  StreamSubscription? connection;
  bool isoffline = false;
  String sshIP = '';
  String sshName = '';
  String sshPassword = '';

  @override
  void listenTextBox() {}

  @override
  void initState() {
    connection = Connectivity()
        .onConnectivityChanged
        .listen((ConnectivityResult result) {
      // whenevery connection status is changed.
      if (result == ConnectivityResult.wifi) {
        //there is no any connection
        setState(() {
          isoffline = false;
        });
      } else {
        //connection is from wifi
        setState(() {
          isoffline = true;
        });
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    connection!.cancel();
    super.dispose();
  }

  void sshConnect() async {
    setState(() {});
    final client = SSHClient(
      await SSHSocket.connect('192.168.3.107', 22),
      username: sshName,
      onPasswordRequest: () => sshPassword,
    );
    await client.execute("touch ~/kedi.txt");
    client.close();
  }

//------------------------------- STATELESS WIDGETS
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Flutnix"),
        backgroundColor: Colors.purple,
      ),
      body: Center(
          child: ListView(children: [
        Container(
          width: double.infinity,
          alignment: Alignment.center,
          margin: EdgeInsets.only(bottom: 30),
          color: isoffline ? Colors.red : Colors.lightGreen,
          //red color on offline, green on online
          padding: EdgeInsets.all(10),
          child: Text(
            isoffline ? "Device is Offline" : "Device is Online",
            style: TextStyle(fontSize: 20, color: Colors.white),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 20),
          child: TextField(
            keyboardType: TextInputType.text,
            onChanged: (val) {
              setState(() {
                sshIP = val;
              });
            },
            decoration: InputDecoration(
                labelText: 'SSH Local IP',
                hintText: '192.168.x.x',
                icon: const Icon(Icons.password),
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 25, vertical: 20),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(50.0))),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 10),
          child: TextField(
            keyboardType: TextInputType.emailAddress,
            onChanged: (val) {
              setState(() {
                sshName = val;
              });
            },
            decoration: InputDecoration(
                labelText: 'SSH Name',
                hintText: 'Example: root',
                icon: const Icon(Icons.person),
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 25, vertical: 20),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(50.0))),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 20),
          child: TextField(
            keyboardType: TextInputType.text,
            onChanged: (val) {
              setState(() {
                sshPassword = val;
              });
            },
            obscureText: true,
            decoration: InputDecoration(
                labelText: 'SSH Password',
                hintText: '*************',
                icon: const Icon(Icons.password),
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 25, vertical: 20),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(50.0))),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 5),
          child: ButtonTheme(
            height: 56,
            child: TextButton(
              child: const Text('Login',
                  style: TextStyle(color: Colors.black87, fontSize: 20)),
              onPressed: () => sshConnect(),
            ),
          ),
        )
      ])),
    );
  }
}
