import 'dart:math';

import 'package:date4u/data/Profile.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../data/Unicorn.dart';

class HttpHelper {
  final String _domain = '10.0.2.2:8080';
  final String _profilePath = 'profile/';
  final String _profilesPath = 'profiles/';
  final String _loginPath = 'unicorn/';
  final String _updatePath = 'profileUpdate';

  Future<Profile> getProfile(String id) async {
    Uri uri = Uri.http(_domain, _profilePath + id);
    http.Response result = await http.get(uri);

    Map<String, dynamic> data = json.decode(result.body);

    return Profile.fromJson(data);
  }

  Future<Profile> updateProfile(Profile updatedProfile) async {
    Uri uri = Uri.http(_domain, _updatePath);

    final response = await http.post(
      uri,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        'id': updatedProfile.id.toString(),
        'nickname': updatedProfile.nickname,
        'birthdate': updatedProfile.birthdate,
        'hornlength': updatedProfile.hornLength,
        'gender': updatedProfile.gender,
        'attractedToGender': updatedProfile.attractedToGender,
        'description': updatedProfile.description
      }),
    );

    if (response.statusCode == 201) {
      // If the server did return a 201 CREATED response,
      // then parse the JSON.
      return Profile.fromJson(jsonDecode(response.body));
    } else {
      // If the server did not return a 201 CREATED response,
      // then throw an exception.
      throw Exception('Failed to update Profile.');
    }
  }

  Future<Unicorn> fetchUnicorn(String mail, String password) async {
    Map<String, dynamic> parameters = {'mail': mail, 'password': password};

    Uri uri = Uri.http(_domain, _loginPath, parameters);
    http.Response result = await http.get(uri);

    Map<String, dynamic> data = json.decode(result.body);

    return Unicorn.fromJson(data);
  }

  Future<List<Profile>> getProfiles(int minAge, int maxAge, int minHornLength,
      int maxHornLength, int gender) async {
    Map<String, dynamic> parameters = {
      'minAge': minAge,
      'maxAge': maxAge,
      'minHornLength': minHornLength,
      'maxHornLength': maxHornLength,
      'gender': gender
    }.map((key, value) => MapEntry(key, value.toString()));
    Uri uri = Uri.http(_domain, _profilesPath, parameters);
    http.Response result = await http.get(uri);

    Iterable iterable = json.decode(result.body);

    List<Profile> profiles =
        List<Profile>.from(iterable.map((model) => Profile.fromJson(model)));

    return profiles;
  }
}
