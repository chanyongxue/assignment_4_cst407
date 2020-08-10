import 'package:assignment_4_cst407/auth/authenticate.dart';
import 'package:assignment_4_cst407/state/user_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:assignment_4_cst407/screens/home.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer((context, watch) {
      final user = watch(userProvider).state;
      return user.uid == null ? Authenticate() : Home();
    });
  }
}
