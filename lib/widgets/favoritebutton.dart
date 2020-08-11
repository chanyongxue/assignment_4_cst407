import 'package:assignment_4_cst407/state/auth_state.dart';
import 'package:assignment_4_cst407/state/database_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jikan_api/jikan_api.dart';

class FavoriteButton extends StatefulWidget {
  FavoriteButton({Key key, this.top, this.isLiked}) : super(key: key);

  final Top top;
  final bool isLiked;

  @override
  _FavoriteButtonState createState() => _FavoriteButtonState();
}

class _FavoriteButtonState extends State<FavoriteButton> {
  //TODO: set isLiked to database
  var isLiked = false;
  @override
  void initState() async {
    super.initState();
    isLiked = widget.isLiked;
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
        icon: Icon(
          Icons.favorite,
          color: isLiked ? Colors.redAccent : Colors.grey,
          size: 30,
        ),
        onPressed: () async {
          databaseProvider.read(context).state.updateUserLikes(
              await authProvider
                  .read(context)
                  .state
                  .currentFirebaseUser
                  .then((user) => user.uid),
              widget.top.malId);
          setState(() => isLiked = !isLiked);
        });
  }
}
