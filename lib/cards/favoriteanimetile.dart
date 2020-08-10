import 'package:assignment_4_cst407/widgets/favoritebutton.dart';
import 'package:flutter/material.dart';
import 'package:jikan_api/jikan_api.dart';

class FavoriteAnimeTile extends StatelessWidget {
  const FavoriteAnimeTile({Key key, this.top}) : super(key: key);

  final Top top;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(top.title,
      style: TextStyle(color: Colors.white),
      ),
      trailing: FavoriteButton(),
    );
  }
}
