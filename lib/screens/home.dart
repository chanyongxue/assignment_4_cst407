import 'package:assignment_4_cst407/cards/favoriteanimelist.dart';
import 'package:assignment_4_cst407/screens/profile.dart';
import 'package:assignment_4_cst407/state/homestate.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../cards/topanimelist.dart';
import 'package:jikan_api/jikan_api.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:line_icons/line_icons.dart';
import '../state/homestate.dart';
import 'package:assignment_4_cst407/auth/auth_methods.dart';

class Home extends StatelessWidget {
  final AuthMethods _auth = AuthMethods();
  
  Widget _homeBuild() {
    return ListView(
      children: <Widget>[
        Divider(
          height: 20,
          color: Colors.transparent,
        ),
        Padding(
          padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
          child: Text(
            "popular anime",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w500,
              color: Colors.white,
            ),
          ),
        ),
        Container(
          height: 270,
          padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
          child: TopAnimeList(),
        ),
        Padding(
          padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
          child: Text(
            "top anime movies",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w500,
              color: Colors.white,
            ),
          ),
        ),
        Container(
          height: 270,
          padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
          child: TopAnimeList(
            subtype: TopSubtype.movie,
          ),
        ),
        Padding(
          padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
          child: Text(
            "specials",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w500,
              color: Colors.white,
            ),
          ),
        ),
        Container(
          height: 270,
          padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
          child: TopAnimeList(
            subtype: TopSubtype.special,
          ),
        ),
         Padding(
          padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
          child: Text(
            "airing",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w500,
              color: Colors.white,
            ),
          ),
        ),
        Container(
          height: 270,
          padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
          child: TopAnimeList(
            subtype: TopSubtype.airing,
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    var _homeWidgets = <Widget>[
    _homeBuild(),
    FavoriteAnimeList(),
    Profile(),
  ];
    return Consumer((context, watch) {
      final index = watch(selectedIndex).state;
      return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
          centerTitle: true,
          title: Text("my anime list",
          style: TextStyle(
            fontSize: 25,),
            ),
          automaticallyImplyLeading: false,
          actions: <Widget>[
            FlatButton.icon(
              icon: Icon(Icons.person_outline, 
              color: Colors.white),
              label: Text('log out',
              style: TextStyle(color: Colors.white)),
              onPressed: () async {
                await _auth.signOut();
                Navigator.pushReplacementNamed(context, '/wrapper');
              },
            ),
          ],
        ),
        bottomNavigationBar: Container(
          decoration: BoxDecoration(color: Colors.grey[850], boxShadow: [
            BoxShadow(blurRadius: 20, color: Colors.black.withOpacity(.1))
          ]),
          child: SafeArea(
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 15.0, vertical: 8),
              child: GNav(
                  gap: 8,
                  activeColor: Colors.white,
                  iconSize: 24,
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                  duration: Duration(milliseconds: 200),
                  tabBackgroundColor: Colors.black,
                  tabs: [
                    GButton(
                      icon: LineIcons.home,
                      iconColor: Colors.white,
                      text: 'home',
                    ),
                    GButton(
                      icon: LineIcons.heart_o,
                      iconColor: Colors.white,
                      text: 'likes',
                    ),
                    GButton(
                        icon: LineIcons.user,
                        text: 'profile',
                        iconColor: Colors.white,
                      ), 
                  ],
                  selectedIndex: index,
                  onTabChange: (index) {
                    selectedIndex.read(context).state = index;
                  }),
            ),
          ),
        ),
        body: _homeWidgets[index],
        backgroundColor: Colors.black,
      );
    });
  }
}
