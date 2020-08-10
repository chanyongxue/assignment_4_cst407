import 'package:assignment_4_cst407/cards/favoriteanimetile.dart';
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
        pageFuture: (pageIndex) => jikan
            .read(context)
            .getTop(TopType.anime, subtype: subtype ?? null, page: pageIndex + 1)
            .then((list) => list.take(10).toList()));
    return PagewiseListView(
      itemBuilder: (context, anime, index) => FavoriteAnimeTile(
        top: anime,
      ),
      scrollDirection: Axis.vertical,
      pageLoadController: _pageController,
    );
  }
}
