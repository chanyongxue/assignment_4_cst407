import 'package:flutter/material.dart';
import 'package:jikan_api/jikan_api.dart';

class FavoriteButton extends StatefulWidget {
  FavoriteButton({Key key, this.top}) : super(key: key);

  final Top top;

  @override
  _FavoriteButtonState createState() => _FavoriteButtonState();
}

class _FavoriteButtonState extends State<FavoriteButton> {
  //TODO: set isLiked to database
  var isLiked = false;
  @override
  Widget build(BuildContext context) {
    return IconButton(
        icon: Icon(
          Icons.favorite,
          color: isLiked ? Colors.redAccent : Colors.grey,
          size: 30,
        ),
        onPressed: () => setState(() => isLiked = !isLiked));
  }
}
