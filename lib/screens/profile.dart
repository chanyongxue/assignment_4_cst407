import 'package:assignment_4_cst407/auth/auth_methods.dart';
import 'package:flutter/material.dart';

class Profile extends StatelessWidget {

final AuthMethods _auth = AuthMethods();

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.black,
        alignment: Alignment.center,
                child: FlatButton.icon(
                  icon: Icon(Icons.person_outline), 
                  color: Colors.white,
                  label: Text('log out',
                  style: TextStyle(color: Colors.black)),
                   onPressed: () async {
                    await _auth.signOut();
                    Navigator.pushReplacementNamed(context, '/wrapper');
                },
      ),
    );
  }
}
