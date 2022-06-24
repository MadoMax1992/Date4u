import 'package:date4u/data/Profile.dart';
import 'package:date4u/screen/edit_profile_screen.dart';
import 'package:date4u/screen/login_screen.dart';
import 'package:date4u/shared/menu_drawer.dart';
import 'package:date4u/util/global.dart';
import 'package:flutter/material.dart';
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
  late Future<Profile> futureProfile;

  bool _ownProfile = false;

  final HttpHelper httpHelper = HttpHelper();
  final ProfileHelper profileHelper = ProfileHelper();

  void initState() {
    super.initState();
    futureProfile = httpHelper.getProfile(widget.id.toString());
    if (widget.id == loggedInProfile.id){
      _ownProfile = true;
    }

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
          Container(
            alignment: Alignment.center,
              child: Column(
                children: [
                  if (_ownProfile)
                    ElevatedButton(
                      child: Text('Edit Profile'),
                      onPressed: ((){
                        Navigator.of(context).pop();
                        Navigator.of(context).push(
                            MaterialPageRoute(builder: (context) => EditProfile())
                        );
                      }),
                    )
                 ],
              ),
          ),


          Padding(padding: EdgeInsets.all(5),
            child: FutureBuilder<Profile>(
              future: futureProfile,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                   return  Column(
                    children: [
                      Padding(padding: EdgeInsets.all(5),
                        child:
                        Text(loggedInProfile.nickname, style: TextStyle(fontSize: fontSize)),
                      ),
                      profileInfoRow('Horn Length: ',  snapshot.data!.hornLength.toString()),
                      profileInfoRow('Age: ', profileHelper.calculateAge(DateTime.parse(snapshot.data!.birthdate)).toString()),
                      profileInfoRow('Gender: ', snapshot.data!.gender.toString()),
                      profileInfoRow('Attracted To: ', snapshot.data!.attractedToGender.toString()),
                      profileInfoRow('Description: ', snapshot.data!.description),
                      profileInfoRow('last Seen: ', snapshot.data!.lastSeen),
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



