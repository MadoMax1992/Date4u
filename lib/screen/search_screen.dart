import 'dart:math';

import 'package:date4u/data/Profile.dart';
import 'package:date4u/screen/profil_screen.dart';
import 'package:date4u/util/global.dart';
import 'package:flutter/material.dart';

import '../data/Photo.dart';
import '../shared/menu_drawer.dart';
import '../util/http_helper.dart';
import '../util/profile_helper.dart';


class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {

  bool toggle = false;


  final ProfileHelper profileHelper = ProfileHelper();
  final HttpHelper httpHelper = HttpHelper();

  RangeValues _ageRange = const RangeValues (18.0, 100.0);
  RangeValues _hornLengthRange = const RangeValues (0.0, 100.0);
  String _genderValue = '0';

  final double fontSize = 16;

  late Future<List<Profile>> futterProfiles;

  @override
  void initState() {
    super.initState();
    futterProfiles = httpHelper.getProfiles(_ageRange.start.toInt(), _ageRange.end.toInt(), _hornLengthRange.start.toInt(),
        _hornLengthRange.end.toInt() , int.parse(_genderValue));
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('Search')),
        drawer: const MenuDrawer(),
        body: SingleChildScrollView(
            // https://www.youtube.com/watch?v=bxNUmqMvbB4&ab_channel=FlutterMentor
          child: Column(
            children: [
            SizedBox(height: 20.0),
            Padding(
              padding: const EdgeInsets.symmetric(),
              child: Center(
                child: Row(
                  children: [
                    Text('Min Age: ${_ageRange.start.round()}',
                      style: TextStyle(
                          fontSize: fontSize,
                          fontWeight:
                          FontWeight.bold),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Text('Max Age: ${_ageRange.end.round()}',
                      style: TextStyle(
                          fontSize: fontSize,
                          fontWeight:
                          FontWeight.bold),
                    )
                  ],
                  mainAxisAlignment: MainAxisAlignment.center,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: RangeSlider(
                values: _ageRange,
                min: 0,
                max: 100,
                divisions: 100,
                onChanged: (RangeValues values) {
                  setState(() {
                      _ageRange = values;
                  });
                },
              ),
            ),
              Padding(
                padding: const EdgeInsets.symmetric(),
                child: Center(
                  child: Row(
                    children: [
                      Text('Min HornLength: ${_hornLengthRange.start.round()}',
                        style: TextStyle(
                            fontSize: fontSize,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      Text('Max HornLength: ${_hornLengthRange.end.round()}',
                        style: TextStyle(
                            fontSize: fontSize,
                            fontWeight: FontWeight.bold),
                      )
                    ],
                    mainAxisAlignment: MainAxisAlignment.center,
                  ),
                ),
              ),

            Padding(
              padding: const EdgeInsets.all(8.0),
              child: RangeSlider(
                values: _hornLengthRange,
                min: 0,
                max: 100,
                divisions: 100,
                onChanged: (RangeValues values) {
                  setState(() {
                      _hornLengthRange = values;
                  });
                },
              ),
            ),
              Padding(padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Column(
                      children: [
                        Text('Gender', style: TextStyle(fontSize: fontSize),),                    DropdownButton(items: const [
                          DropdownMenuItem(child: Text('0'), value: '0'),
                         DropdownMenuItem(child: Text('1'), value: '1'),
                         DropdownMenuItem(child: Text('2'), value: '2'),]
                          ,value: _genderValue
                          ,onChanged: dropDownCallback)
                      ],
                    ),
                    // ElevatedButton(onPressed: search,
                    //     child: Icon(Icons.search))
                  ],
                ),
              ),


              Padding(padding: const EdgeInsets.all(8.0),
                child: FutureBuilder<List<Profile >>(
                  future: httpHelper.getProfiles(_ageRange.start.toInt(), _ageRange.end.toInt(), _hornLengthRange.start.toInt(),
                      _hornLengthRange.end.toInt() , int.parse(_genderValue)),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {

                      for (var i = 0; i < snapshot.data!.length; ++i) {
                        if(loggedInProfile.id == snapshot.data![i].id) {
                          snapshot.data!.removeAt(i);
                        }
                      }
                      if (snapshot.data!.isEmpty) {
                        return Text('No Unicorns Found :(');
                      }
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,

                        children: [
                          for (Profile profile in snapshot.data!)


                            GestureDetector(
                              onTap: () {
                                Navigator.of(context).pop();
                                Navigator.of(context).push(
                                    MaterialPageRoute(
                                        builder: (context) => ProfilScreen(profile.id)));
                              }
                              ,
                              child: Card(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(40.0),
                                      child: Image.network(
                                        'http://10.0.2.2:8080/img/'+profile.id.toString(),
                                        fit: BoxFit.cover,
                                          width: 80,
                                        height: 80,
                                      ),
                                    ),

                                    Padding(padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            Text(profile.nickname, style: TextStyle(fontSize: fontSize, fontWeight: FontWeight.bold),),
                                            Text('HornLength: ${profile.hornLength}'),
                                            Text('Age: ${profileHelper.calculateAge(DateTime.parse(profile.birthdate))}'),
                                          ],
                                      ),
                                    ),
                                    Padding(padding: const EdgeInsets.all(8.0),

                                      child: Container(
                                        child:
                                        IconButton(
                                              icon: toggle
                                                ? Icon(Icons.favorite_border, color: Colors.red,)
                                                : Icon(
                                              Icons.favorite,color: Colors.red
                                            ),
                                            onPressed: () {
                                              setState(() {
                                                toggle = !toggle;
                                              });
                                            }),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            )

                        ],
                      );
                     }else if(snapshot.hasError) {
                      return Text('${snapshot.error}');
                    }
                    return const CircularProgressIndicator();
                }
                ),
              )

          ],),
        )
    );
  }

  void search () {


  }


  void dropDownCallback (String? selectedValue) {
    if(selectedValue is String) {
      setState(() {
        _genderValue = selectedValue;
      });
    }
  }

}
