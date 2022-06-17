import 'package:flutter/foundation.dart';

import 'Profile.dart';

class Unicorn {
  late int id;
  late String mail;
  late String password;
  late Map<String, dynamic> profile;


  Unicorn(this.id, this.mail, this.password, this.profile);

  Unicorn.fromJson(Map<String, dynamic> unicornMap) {
    id = unicornMap['id'];
    mail = unicornMap['email'];
    password = unicornMap['password'];
    profile = unicornMap['profile'];
  }
}
