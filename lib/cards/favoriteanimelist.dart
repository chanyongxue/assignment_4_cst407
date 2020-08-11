import 'package:assignment_4_cst407/cards/favoriteanimetile.dart';
import 'package:assignment_4_cst407/state/auth_state.dart';
import 'package:assignment_4_cst407/state/database_state.dart';
import 'package:flutter/material.dart';
import 'package:jikan_api/jikan_api.dart';
import 'package:flutter_pagewise/flutter_pagewise.dart';
import '../state/animeliststate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FavoriteAnimeList extends StatelessWidget {
  const FavoriteAnimeList({Key key, this.subtype}) : super(key: key);

  final TopSubtype subtype;

  @override
  Widget build(BuildContext context) {
    final _pageController = PagewiseLoadController(
        pageSize: 10,
        //TODO: load favorite from userlikes on database
        pageFuture: (pageIndex) async {
          var uid = await authProvider
              .read(context)
              .state
              .currentFirebaseUser
              .then((user) => user.uid);
          var userLikes =
              await databaseProvider.read(context).state.getUserLikes(uid);
          var pageOfLikes = userLikes.skip(pageIndex * 10).take(10).toList();
          var animeList = List<Anime>();
          pageOfLikes.forEach((animeID) async =>
              animeList.add(await jikan.read(context).getAnimeInfo(animeID)));
          return Future.value(animeList);
        });
    return PagewiseListView(
      itemBuilder: (context, anime, index) => FavoriteAnimeTile(
        anime: anime,
      ),
      scrollDirection: Axis.vertical,
      pageLoadController: _pageController,
      noItemsFoundBuilder: (context) => Text("You haven't liked anything yet..."),
    );
  }
}
