import 'package:flutter/material.dart';
import 'package:jikan_api/jikan_api.dart';
import '../screens/detailscreen.dart';

class AnimeListCard extends StatelessWidget {
  const AnimeListCard({Key key, this.top}) : super(key: key);

  final Top top;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Padding(padding: EdgeInsets.fromLTRB(30, 0, 0, 0),),
        Divider(
          color: Colors.transparent,
        ),
            InkWell(
              splashColor: Colors.blue.withAlpha(30),
            onTap: () {
                        Navigator.push(context, MaterialPageRoute(
                          builder: (context) => AnimeDetails(),
                          settings: RouteSettings(arguments: top),
                          ),
                        );
                      },
                child: Row(
                  children: <Widget>[
                    Container(
                      width: 150.0,
                      child: Hero(
                        tag: top.malId.toString() + key.toString(),
                      child: Image.network(top.imageUrl,fit: BoxFit.contain, width: 100),
                      ),
                    ),
                  ],
                ),
              ),
      ],
    );
  }
}

