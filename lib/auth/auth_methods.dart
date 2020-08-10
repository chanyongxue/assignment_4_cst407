import 'package:assignment_4_cst407/models/user.dart';
import 'package:assignment_4_cst407/state/user_state.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AuthMethods {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future signOut() async {
    try {
      userProvider.readOwner(ProviderStateOwner()).state = User(uid: null);
      return await _auth.signOut();
    } catch (e) {
      return (e).toString();
    }
  }

  Future<String> registerWithEmailAndPassword(String email, String password) async {
    try {
      await _auth.createUserWithEmailAndPassword(email: email, password: password);
      return await signIn(email, password);
    } catch (e) {
      return (e).toString();
    }
  }

  Future<String> signIn(String email, String password) async {
    try {
      AuthResult result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      FirebaseUser user = result.user;
      userProvider.readOwner(ProviderStateOwner()).state = User(uid: user.uid);
      return null;
    } catch (e) {
      return (e).toString();
    }
  }
}
