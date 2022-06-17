import 'package:date4u/data/Profile.dart';
import 'package:date4u/shared/menu_drawer.dart';
import 'package:flutter/material.dart';
import 'package:date4u/data/Photo.dart';

import '../util/http_helper.dart';


class ProfilScreen extends StatefulWidget {
  final int id;


  const ProfilScreen(this.id, {Key? key}) : super(key: key);

  @override
  State<ProfilScreen> createState() => _ProfilScreenState();
}

class _ProfilScreenState extends State<ProfilScreen> {
  final double fontSize = 20;
  Profile profile = Profile(0, '', '', 0, 0, 0, '', '', <Photo>[]);

  late Future<Profile> futureProfile;

  final HttpHelper httpHelper = HttpHelper();

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
                   return  Column(
                    children: [
                      Padding(padding: EdgeInsets.all(5),
                        child:
                        Text(snapshot.data!.nickname, style: TextStyle(fontSize: fontSize)),
                      ),
                      profileInfoRow('Horn Length: ',  snapshot.data!.hornLength.toString()),
                      profileInfoRow('Age: ', calculateAge(DateTime.parse(snapshot.data!.birthdate)).toString()),
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
      padding: EdgeInsets.all(20),
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


  calculateAge(DateTime birthDate) {
    DateTime currentDate = DateTime.now();
    int age = currentDate.year - birthDate.year;
    int month1 = currentDate.month;
    int month2 = birthDate.month;
    if (month2 > month1) {
      age--;
    } else if (month1 == month2) {
      int day1 = currentDate.day;
      int day2 = birthDate.day;
      if (day2 > day1) {
        age--;
      }
    }
    return age;
  }
}



