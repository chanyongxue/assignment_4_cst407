import 'package:assignment_4_cst407/state/auth_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class Profile extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black,
      alignment: Alignment.center,
        child: ListView(
          children: <Widget>[
            Divider(color: Colors.transparent),
            CircleAvatar(
              radius: 60,
              backgroundColor: Colors.white,
              child: Icon(
                Icons.person, 
                size: 80,
                color: Colors.black
                ),
            ),
            Divider(color: Colors.transparent),
          FlatButton.icon(
                      icon: Icon(Icons.person_outline), 
                      color: Colors.white,
                      label: Text('log out',
                      style: TextStyle(color: Colors.black)),
                       onPressed: () async {
                        await authProvider.readOwner(ProviderStateOwner()).state.signOut();
                        Navigator.pushReplacementNamed(context, '/wrapper');
                    },
          ),
          ],
        ),
    );
  }
}
