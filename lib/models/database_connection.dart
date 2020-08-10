import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseConnection {
  Firestore _database = Firestore.instance;
  Future<List<String>> getUserLikes(String uid) async {
    var collect = await _database
        .collection('users')
        .document(uid)
        .collection('likes')
        .getDocuments();
    var malids = List<String>();
    collect.documents.forEach((doc) {
      malids.add(doc.data.containsKey('malid').toString());
    });
    return Future.value(malids);
  }

  void updateUserLikes(String uid, String malid) async {
    await animeExistsInUserLikes(uid, malid)
        ? removeAnimeFromUserLikes(uid, malid)
        : addAnimeToUserLikes(uid, malid);
  }

  Future<bool> animeExistsInUserLikes(String uid, String malid) async {
    var collect = await _database
        .collection('users')
        .document(uid)
        .collection('likes')
        .getDocuments();
    return Future.value(collect.documents.contains(malid));
  }

  void removeAnimeFromUserLikes(String uid, String malid) async {
    await _database
        .collection('users')
        .document(uid)
        .collection('likes')
        .document(malid)
        .delete();
  }

  void addAnimeToUserLikes(String uid, String malid) async {
    await _database
        .collection('users')
        .document(uid)
        .collection('likes')
        .add({'malid': malid});
  }
}
