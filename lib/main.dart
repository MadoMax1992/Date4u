import 'package:date4u/screen/profil_screen.dart';
import 'package:date4u/screen/search_screen.dart';
import 'package:flutter/material.dart';
import 'package:date4u/screen/login_screen.dart';

void main() {
  runApp(
    MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: 'search',
        routes: {
          'login': (context) => const LoginScreen(),
          'search': (context) => const SearchScreen(),
          'profil': (context) => const ProfilScreen(1), //TODO Profil reingeben oder alles hier löschen ? geht galub ich ohne Routen
        }),
  );
}