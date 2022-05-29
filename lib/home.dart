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
  String commandSSH = '';
  String outCommand = '';
  bool isConnected = false;
  late SSHClient client;

  @override
  initState() {
    connectSSH();
    super.initState();
  }

  Future<void> connectSSH() async {
    client = SSHClient(
      await SSHSocket.connect(widget.sshIP, 22),
      username: widget.sshUsername,
      onPasswordRequest: () => widget.sshPassword,
    );
  }

  executeCommand(String commandSSH) async {
    if (commandSSH.isEmpty) {
      // no code
    } else {
      final command = await client.run(commandSSH);
      outCommand = utf8.decode(command);
      debugPrint(outCommand);
    }
  }

  appendText(String text) {
    outCommand += outCommand + "\n";
  }

  final _commandController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Center(child: Text("SSHx")),
          backgroundColor: Colors.purple,
        ),
        body: Container(
          decoration: const BoxDecoration(color: Colors.white),
          child: Column(
            children: <Widget>[
              Expanded(
                  child: Container(
                width: double.infinity,
                child: Text(
                  outCommand,
                  style: const TextStyle(color: Colors.white),
                ),
                decoration: BoxDecoration(
                    color: Colors.black87, //remove color to make it transpatent
                    border: Border.all(
                        style: BorderStyle.solid, color: Colors.black)),
              )),
              Padding(
                padding: const EdgeInsets.all(15),
                child: TextField(
                  keyboardType: TextInputType.text,
                  controller: _commandController,
                  onChanged: (val) {
                    commandSSH = val;
                  },
                  decoration: InputDecoration(
                      suffixIcon: InkWell(
                        onTap: () {
                          executeCommand(commandSSH);
                          appendText(outCommand);
                          _commandController.clear();
                        },
                        child: const Icon(Icons.send),
                      ),
                      labelText: 'Command',
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 25, vertical: 20),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(50.0))),
                ),
              ),
            ],
          ),
        ));

    // TEXT BOX FOR COMMANDS
  }
}
