import 'package:date4u/screen/login_screen.dart';
import 'package:date4u/screen/profil_screen.dart';
import 'package:date4u/screen/search_screen.dart';
import 'package:flutter/material.dart';

class MenuDrawer extends StatelessWidget {
  const MenuDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: buildMenuItems(context),
      ),
    );
  }

  List<Widget> buildMenuItems(BuildContext context) {
    final List<String> menuTitles = [
      'Profil',
      'Search',
      'Logout'
    ];
    List<Widget> menuItemes = [];
    menuItemes.add(DrawerHeader(
      decoration: BoxDecoration(color: Colors.blueGrey),
      child: Text('Date4u',
        style: TextStyle(color: Colors.white, fontSize: 28),),
    ));

    menuTitles.forEach((String element) {
      Widget screen = Container();
      menuItemes.add(ListTile(
        title: Text(element,
            style: TextStyle(fontSize: 18)),
        onTap: () {
          switch (element) {
            case 'Profil':
              screen = ProfilScreen(1);//TODO welches Profil bin ich nach login
              break;
            case 'Search':
              screen = SearchScreen();
              break;
            case 'Logout':
              screen = LoginScreen();
              break;
          }
          Navigator.of(context).pop();
          Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => screen)
          );
        },
      ));
    });

    return menuItemes;
  }
}
