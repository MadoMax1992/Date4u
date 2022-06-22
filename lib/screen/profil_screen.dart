import 'package:date4u/data/Profile.dart';
import 'package:date4u/shared/menu_drawer.dart';
import 'package:date4u/util/global.dart';
import 'package:flutter/material.dart';
import 'package:date4u/data/Photo.dart';
import 'package:date4u/util/profile_helper.dart';

import '../util/http_helper.dart';


class ProfilScreen extends StatefulWidget {
  final int id;


  const ProfilScreen(this.id, {Key? key}) : super(key: key);

  @override
  State<ProfilScreen> createState() => _ProfilScreenState();
}

class _ProfilScreenState extends State<ProfilScreen> {
  final double fontSize = 20;
  // Profile profile = Profile(0, '', '', 0, 0, 0, '', '', <Photo>[]);

  late Future<Profile> futureProfile;

  final HttpHelper httpHelper = HttpHelper();
  final ProfileHelper profileHelper = ProfileHelper();

  @override
  void initState() {
    super.initState();
    futureProfile = httpHelper.getProfile(widget.id.toString());

  }



  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(title: Text('Profil')),
      drawer: const MenuDrawer(),
      body: SingleChildScrollView(
        child: Column(children: [
          Center(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(40.0),
                child: Image.network(
                  'http://10.0.2.2:8080/img/'+widget.id.toString(),
                  fit: BoxFit.cover,
                  width: 200,
                  height: 200,
                ),
              ),
            ),
          ),
          Padding(padding: EdgeInsets.all(5),
            child: FutureBuilder<Profile>(
              future: futureProfile,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  loggedInProfile = snapshot.data!;
                   return  Column(
                    children: [
                      Padding(padding: EdgeInsets.all(5),
                        child:
                        Text(loggedInProfile.nickname, style: TextStyle(fontSize: fontSize)),
                      ),
                      profileInfoRow('Horn Length: ',  loggedInProfile.hornLength.toString()),
                      profileInfoRow('Age: ', profileHelper.calculateAge(DateTime.parse(loggedInProfile.birthdate)).toString()),
                      profileInfoRow('Gender: ', loggedInProfile.gender.toString()),
                      profileInfoRow('Attracted To: ', loggedInProfile.attractedToGender.toString()),
                      profileInfoRow('Description: ', loggedInProfile.description),
                      profileInfoRow('last Seen: ', loggedInProfile.lastSeen),
                      profileInfoRow('fotos: ', 'not implmented'),
                    ],
                  );
                } else if(snapshot.hasError) {
                  return Text('${snapshot.error}');
                }
                return const CircularProgressIndicator();
              },
            )
          ),


          // Image(image: image)
        ],
        ),
      )
    );
  }

  Widget profileInfoRow(String label, String value) {
    Widget row =Padding(
      padding: EdgeInsets.all(10),
      child: Row(
        children: [
          Expanded(
            flex: 3,
            child: Text(label, style: TextStyle(
                fontSize: fontSize,
                color: Theme.of(context).hintColor
            ),),
          ),
          Expanded(
            flex: 4,
            child: Text(value, style: TextStyle(
                fontSize: fontSize,
                color: Theme.of(context).primaryColor
            ),),
          )
        ],
      ),
    );
    return row;
  }

  // Future getCurrentProfile(id) async {
  //   HttpHelper helper = HttpHelper();
  //   profile = await helper.getProfile(id);
  //   setState(() {});
  // }



}



