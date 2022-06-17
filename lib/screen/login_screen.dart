import 'package:date4u/screen/profil_screen.dart';
import 'package:flutter/material.dart';
import 'package:date4u/data/Unicorn.dart';
import 'dart:developer';


import '../util/http_helper.dart';


class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  Unicorn unicorn = Unicorn(-1,'', '', <String, dynamic>{});

  //TODO https://docs.flutter.dev/cookbook/networking/fetch-data
  // so gehts richtig ohne blöde -1 startwert

  final TextEditingController txtMail = TextEditingController();
  final TextEditingController txtPassword = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Date4u'),
        automaticallyImplyLeading: false,
      ), //TODO Back Button bei Login ausbauen
      body: Column(
        children: [
          Padding(padding: const EdgeInsets.all(20),
            child: TextField(
              controller: txtMail,
              decoration: InputDecoration(hintText: 'mail'))),
          Padding(padding: const EdgeInsets.all(20),
            child: TextField(
              controller: txtPassword,
              decoration: InputDecoration(hintText: 'password'))),
          Padding(padding: const EdgeInsets.all(20),
            child: ElevatedButton(
              child: Text('Login with ID 4'),
              onPressed: (() {
                Navigator.of(context).pop();
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => ProfilScreen(4))
                );
              }),
            ),)
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.arrow_forward),
        onPressed: () { //TODO LOGIN creds prüfen
          checkLogin(txtMail.text, txtPassword.text);
        },
      ),

    );
  }

  Future checkLogin(mail, password) async {
    HttpHelper helper = HttpHelper();
    unicorn = await helper.fetchUnicorn(mail, password);

    if(unicorn.id == 0) { // schlecht Bedingung
      txtMail.text = 'Wrong creds or Unicorn not Found';
      setState(() {
      });

    } else {
      Navigator.of(context).pop();
      Navigator.of(context).push(
          MaterialPageRoute(builder: (context) => ProfilScreen(unicorn.id))
      );
    }
  }
}
