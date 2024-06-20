import 'package:flutter/material.dart';
class listedesNotifications extends StatefulWidget {
  const listedesNotifications({super.key});

  @override
  State<listedesNotifications> createState() => _listedesNotificationsState();
}

class _listedesNotificationsState extends State<listedesNotifications> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Color.fromARGB(255, 84, 132, 196),
        title: Row(children: [
          SizedBox(width: 100),
          Text(
            "Notifications",
            style: TextStyle(color: Colors.white, fontSize: 25),
          ),
        ]),
      ),
    );
  }
}