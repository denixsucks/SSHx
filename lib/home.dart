import 'dart:convert';
import 'package:dartssh2/dartssh2.dart';
import 'package:flutter/material.dart';

class UsefulPage extends StatefulWidget {
  final String sshIP;
  final String sshUsername;
  final String sshPassword;

  // ignore: use_key_in_widget_constructors
  const UsefulPage(
      {required this.sshIP,
      required this.sshPassword,
      required this.sshUsername});

  @override
  _UsefulState createState() => _UsefulState();
}

class _UsefulState extends State<UsefulPage> {
  late SSHClient client;
  late String commandSSH;
  late String outCommand;
  @override
  initState() {
    connectSSH();
    super.initState();
  }

  connectSSH() async {
    client = SSHClient(
      await SSHSocket.connect(widget.sshIP, 22),
      username: widget.sshUsername,
      onPasswordRequest: () => widget.sshPassword,
    );
  }

  testLmao(String commandSSH) async {
    final uptime = await client.run('uptime', stderr: false);
    debugPrint(utf8.decode(uptime));
    final command = await client.run(commandSSH);
    debugPrint(utf8.decode(command));
    //final shutdown = await client.run('shutdown now');
    //debugPrint(utf8.decode(shutdown));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text("SSHx")),
        backgroundColor: Colors.purple,
      ),
      body: Center(
          child: ListView(children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 10),
          child: TextField(
            keyboardType: TextInputType.emailAddress,
            onChanged: (val) {
              setState(() => commandSSH = val.toString());
            },
            decoration: const InputDecoration(hintText: 'Enter command.'),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 5),
          child: ButtonTheme(
              height: 56,
              child: TextButton(
                  child: const Text('Shutdown Computer',
                      style: TextStyle(color: Colors.black87, fontSize: 20)),
                  onPressed: () => {testLmao(commandSSH)})),
        ),
      ])),
    );
  }
}
