import 'package:dartssh2/dartssh2.dart';
import 'dart:io';
import 'dart:convert';

void main(List<String> args) async {
  final String? configUsername;
  final socket = await SSHSocket.connect('localhost', 22);

  // GET USERNAME
  stdout.write('Username: ');
  configUsername = stdin.readLineSync()!;

  final client = SSHClient(
    socket,
    username: configUsername,
    onPasswordRequest: () {
      stdout.write('Password: ');
      stdin.echoMode = false;
      return stdin.readLineSync() ?? exit(1);
    },
  );

  final uptime = await client.run('ls');
  print(utf8.decode(uptime));

  client.close();
  await client.done;
}

void getAuth() {}

void successAuth() {}

void unsuccessAuth() {}
