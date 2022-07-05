import 'package:date4u/data/Profile.dart';
import 'package:date4u/screen/profil_screen.dart';
import 'package:date4u/util/global.dart';
import 'package:flutter/material.dart';

import '../util/http_helper.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({Key? key}) : super(key: key);

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  final HttpHelper httpHelper = HttpHelper();

  TextEditingController txtNickname = TextEditingController();
  TextEditingController txtBirthdate = TextEditingController();
  TextEditingController txtHornLength = TextEditingController();
  TextEditingController txtGender = TextEditingController();
  TextEditingController txtAttractedToGender = TextEditingController();
  TextEditingController txtDescription = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profil bearbeiten'),
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => ProfilScreen(loggedInProfile.id)));
          }, // Handle your on tap here.
          icon: Icon(Icons.arrow_back_ios),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            profileRow('Nickname', txtNickname, loggedInProfile.nickname, 1),
            //TODO Auf Nickname bereits vergeben prüfen
            profileRow('Birthdate', txtBirthdate, loggedInProfile.birthdate, 1),
            profileRow('Hornlength', txtHornLength,
                loggedInProfile.hornLength.toString(), 1),
            profileRow(
                'Gender', txtGender, loggedInProfile.gender.toString(), 1),
            profileRow('AttractedTo', txtAttractedToGender,
                loggedInProfile.attractedToGender.toString(), 1),
            profileRow(
                'Description', txtDescription, loggedInProfile.description, 5),
            ElevatedButton(onPressed: save, child: Text('Save'))
          ],
        ),
      ),
    );
  }

  void save() {
    Profile updatedProfile = Profile(
        loggedInProfile.id,
        txtNickname.text,
        txtBirthdate.text,
        int.parse(txtHornLength.text),
        int.parse(txtGender.text),
        int.parse(txtAttractedToGender.text),
        txtDescription.text,
        loggedInProfile.lastSeen,
        loggedInProfile.photos);

    try {
      httpHelper.updateProfile(updatedProfile);
    } on Exception {
      //TODO Alert Dialog
    }

    loggedInProfile = updatedProfile;
  }

  Widget profileRow(String label, TextEditingController editingController,
      String profileData, int lines) {
    editingController.text = profileData;
    return Container(
        child: Padding(
      padding: EdgeInsets.all(8.0),
      child: Column(children: [
        Text(label),
        TextField(
          maxLines: lines,
          controller: editingController,
          decoration: InputDecoration(
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
              hintText: label),
        ),
      ]),
    ));
  }
}
