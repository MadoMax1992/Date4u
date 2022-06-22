import 'dart:math';

import 'package:date4u/data/Profile.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../data/Unicorn.dart';

class HttpHelper {

  // https://api.openweathermap.org/data/2.5/weather?q=Bremen&appid=fc46e9ef462b6947a63364eb1db382b5

  final String domain = '10.0.2.2:8080';
  final String profilePath = 'profile/';
  final String profilesPath = 'profiles/';
  final String loginPath = 'unicorn/';

  Future<Profile> getProfile (String id) async {
    Uri uri = Uri.http(domain, profilePath+id);
    http.Response result = await http.get(uri);

    Map<String, dynamic> data = json.decode(result.body);


    return Profile.fromJson(data);
  }


  Future<Unicorn> fetchUnicorn (String mail, String password) async {
    Map<String, dynamic> parameters = {'mail': mail, 'password': password};

    Uri uri = Uri.http(domain, loginPath, parameters);
    http.Response result = await http.get(uri);

    Map<String, dynamic> data = json.decode(result.body);

    return Unicorn.fromJson(data);
  }



  Future<List<Profile>> getProfiles (int minAge, int maxAge,
      int minHornLength, int maxHornLength, int gender) async {

    Map<String, dynamic> parameters = {'minAge': minAge, 'maxAge': maxAge,
      'minHornLength': minHornLength, 'maxHornLength': maxHornLength, 'gender': gender}.map((key, value) => MapEntry(key, value.toString()));
    Uri uri = Uri.http(domain, profilesPath, parameters);
    http.Response result = await http.get(uri);


    Iterable iterable = json.decode(result.body);

    List<Profile> profiles = List<Profile>.from(iterable.map((model)=> Profile.fromJson(model)));

    return profiles;

  }

}