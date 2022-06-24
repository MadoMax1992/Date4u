import 'Photo.dart';

class Profile {
  int id = 0;
  String nickname = '';
  String birthdate = '';
  int hornLength = 0;
  int gender = 1;
  int attractedToGender = 0;
  String description = '';
  String lastSeen= '';
  List<dynamic> photos = <Photo>[];

  Profile(this.id, this.nickname, this.birthdate, this.hornLength, this.gender,
      this.attractedToGender, this.description, this.lastSeen, this.photos);

  Profile.fromJson(Map<String, dynamic> profileMap) {
    id = profileMap['id'];
    nickname = profileMap['nickname'];
    birthdate = profileMap['birthdate'];
    hornLength = profileMap['hornlength'];
    gender = profileMap['gender'];
    attractedToGender = profileMap['attractedToGender']?? 0;
    //TODO Klassen so wie in Flutter anlegen und dann wiehier auf null safty prüfen
    description = profileMap['description'];
    lastSeen = profileMap['lastseen'];
    photos = profileMap['photos'];

  }

  @override
  String toString() {
    return 'Profile{id: $id, nickname: $nickname, birthdate: $birthdate, hornLength: $hornLength, gender: $gender, attractedToGender: $attractedToGender, description: $description, lastSeen: $lastSeen, photos: $photos}';
  }
}