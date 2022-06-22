
import 'package:date4u/data/Profile.dart';
import 'package:date4u/screen/edit_profile_screen.dart';
import 'package:date4u/screen/profil_screen.dart';
import 'package:date4u/screen/search_screen.dart';
import 'package:date4u/util/global.dart';
import 'package:flutter/material.dart';
import 'package:date4u/screen/login_screen.dart';

import 'data/Photo.dart';

void main() {

  runApp(
    MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: 'login',
        routes: {
          'login': (context) => const LoginScreen(),
          'search': (context) => const SearchScreen(),
          // 'edit' : (context) => const EditProfile(),
          'profil': (context) => ProfilScreen(loggedInProfile.id), //TODO Profil reingeben oder alles hier löschen ? geht galub ich ohne Routen
        }),
  );
}