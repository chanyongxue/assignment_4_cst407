import 'package:assignment_4_cst407/state/auth_state.dart';
import 'package:assignment_4_cst407/state/database_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jikan_api/jikan_api.dart';

final buttonStateProvider = StateProvider((ref) => false);

class FavoriteButton extends StatelessWidget {
  FavoriteButton({Key key, this.top}) : super(key: key);

  final Top top;
  @override
  Widget build(BuildContext context) {
    Future<bool> isLiked(Top top) async {
      var uid = await authProvider
          .readOwner(ProviderStateOwner())
          .state
          .currentFirebaseUser
          .then((user) => user.uid);
      return await databaseProvider
          .readOwner(ProviderStateOwner())
          .state
          .animeExistsInUserLikes(uid, top.malId);
    }

    return IconButton(
        icon: FutureBuilder(
          future: isLiked(top),
          builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) =>
              snapshot.connectionState == ConnectionState.done
                  ? Icon(
                      Icons.favorite,
                      color: snapshot.data ? Colors.redAccent : Colors.grey,
                      size: 30,
                    )
                  : CircularProgressIndicator(),
        ),
        onPressed: () async {
          buttonStateProvider.read(context).state = await isLiked(top);
          databaseProvider.read(context).state.updateUserLikes(
              await authProvider
                  .read(context)
                  .state
                  .currentFirebaseUser
                  .then((user) => user.uid),
              top.malId);
        });
  }
}
