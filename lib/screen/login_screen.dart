import 'package:date4u/screen/profil_screen.dart';
import 'package:date4u/util/global.dart';
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

  final HttpHelper httpHelper = HttpHelper();
  final TextEditingController txtMail = TextEditingController();
  final TextEditingController txtPassword = TextEditingController();
  HttpHelper helper = HttpHelper();


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
                byPassLogin();
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

  Future byPassLogin() async {
  loggedInProfile = await helper.getProfile(4.toString());
  Navigator.of(context).pop();
  Navigator.of(context).push(
  MaterialPageRoute(builder: (context) => ProfilScreen(loggedInProfile.id))
  );
}

  Future checkLogin(mail, password) async {
    unicorn = await helper.fetchUnicorn(mail, password);

    if (unicorn.id == 0) { //TODO Meldung dafür dsa Login nicht korrekt ist
      txtMail.text = 'Wrong creds or Unicorn not Found';
      setState(() {
      });

    } else {
      loggedInProfile = await helper.getProfile(unicorn.id.toString());
      Navigator.of(context).pop();
      Navigator.of(context).push(
          MaterialPageRoute(builder: (context) => ProfilScreen(loggedInProfile.id))
      );
    }
  }
}
