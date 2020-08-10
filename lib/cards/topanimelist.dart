import 'package:assignment_4_cst407/cards/animelistcard.dart';
import 'package:flutter/material.dart';
import 'package:jikan_api/jikan_api.dart';
import 'package:flutter_pagewise/flutter_pagewise.dart';
import '../state/animeliststate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TopAnimeList extends StatelessWidget {
  const TopAnimeList({Key key, this.subtype}) : super(key: key);

  final TopSubtype subtype;

  @override
  Widget build(BuildContext context) {
    final _pageController = PagewiseLoadController(
        pageSize: 10,
        pageFuture: (pageIndex) => jikan
            .read(context)
            .getTop(TopType.anime, subtype: subtype ?? null, page: pageIndex + 1)
            .then((list) => list.take(10).toList()));
    return PagewiseListView(
      itemBuilder: (context, anime, index) => Row(
        children: <Widget>[
          AnimeListCard(
            top: anime,
          ),
          SizedBox(
            width: 15,
          ),
        ],
      ),
      scrollDirection: Axis.horizontal,
      pageLoadController: _pageController,
    );
  }
}
