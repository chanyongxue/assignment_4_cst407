import 'package:assignment_4_cst407/models/user.dart';
import 'package:assignment_4_cst407/state/database_state.dart';
import 'package:assignment_4_cst407/state/user_state.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AuthMethods {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<FirebaseUser> get currentFirebaseUser async =>
      await _auth.currentUser();

  Future signOut() async {
    try {
      userProvider.readOwner(ProviderStateOwner()).state = User(uid: null);
      return await _auth.signOut();
    } catch (e) {
      return (e).toString();
    }
  }

  Future<String> registerWithEmailAndPassword(
      String email, String password) async {
    try {
      await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      var result = await signIn(email, password);
      var currentUser = await currentFirebaseUser;

      databaseProvider.readOwner(ProviderStateOwner()).state.addUser(
          currentUser.uid,
          {'uid': currentUser.uid, 'email': currentUser.email});
      return result == null ? result : throw result;
    } catch (e) {
      return (e).toString();
    }
  }

  Future<String> signIn(String email, String password) async {
    try {
      await _auth.signInWithEmailAndPassword(
          email: email, password: password);
          //TODO: FIX USER PROVIDER SETTERRRRR
      var user = userProvider.readOwner(ProviderStateOwner()).state;
      user.uid = await currentFirebaseUser.then((user) => user.uid);
      user.email = email;
      return null;
    } catch (e) {
      return (e).toString();
    }
  }
}
