import 'dart:math';

import 'package:date4u/data/Profile.dart';
import 'package:flutter/material.dart';

import '../data/Photo.dart';
import '../shared/menu_drawer.dart';
import '../util/http_helper.dart';


class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}


//TODO
class _SearchScreenState extends State<SearchScreen> {


  RangeValues _ageRange = const RangeValues (18.0, 100.0);
  RangeValues _hornLengthRange = const RangeValues (0.0, 100.0);

  final double fontSize = 16;
  


  List<Profile> profile = <Profile>[];

  @override
  void initState() {
    super.initState();
    getProfiles(0,100, 0,100,0);
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
            )

          ],),
        )
    );
  }

  Future getProfiles(int minAge, int maxAge, int minHornLength, int maxHornLength, int gender) async {
    HttpHelper helper = HttpHelper();
    profile = await helper.getProfiles(minAge,maxAge,minHornLength,maxHornLength,gender);
  }
}
