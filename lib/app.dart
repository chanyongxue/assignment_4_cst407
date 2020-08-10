import 'package:assignment_4_cst407/auth/wrapper.dart';
import 'package:flutter/material.dart';
import 'screens/detailscreen.dart';
import 'screens/favoriteanime.dart';
import 'screens/home.dart';
import 'package:assignment_4_cst407/screens/profile.dart';

class App extends StatelessWidget {
  const App({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Wrapper(),     
       routes: {
        '/wrapper': (context) => Wrapper(),
        '/detail': (context) => AnimeDetails(),
        '/favorites': (context) => FavoriteAnime(),
        '/home': (context) => Home(),
        '/profile': (context) => Profile(),
      },
    );
  }
}