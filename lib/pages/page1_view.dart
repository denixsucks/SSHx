import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Lusefull',
          style: TextStyle(
            fontFamily: 'Nunito',
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      backgroundColor: Colors.grey[200],
      body: ListView(
        children: [
          InkWell(
            onTap: () {
              print("tapped");
            },
            child: const Card(
              margin: EdgeInsets.all(6),
              child: ListTile(
                leading: CircleAvatar(
                  child: Icon(Icons.person),
                  radius: 15,
                ),
                title: Text("Execute Linux Command"),
                subtitle: Text("Description about method"),
                trailing: Icon(Icons.backpack_outlined),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
