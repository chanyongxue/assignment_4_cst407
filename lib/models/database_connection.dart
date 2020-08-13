import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseConnection {
  Firestore _database = Firestore.instance;

  void addUser(String uid, Map<String, dynamic> userData) {
    _database.collection('users').document(uid).setData(userData);
  }

  Future<List<int>> getUserLikes(String uid) async {
    var collect = await _database
        .collection('users')
        .document(uid)
        .collection('likes')
        .getDocuments();
    var malids = List<int>();
    collect.documents.forEach((doc) {
      malids.add(doc.data['malid'] as int);
    });
    return Future.value(malids);
  }

  void updateUserLikes(String uid, int malid) async {
    await animeExistsInUserLikes(uid, malid)
        ? removeAnimeFromUserLikes(uid, malid)
        : addAnimeToUserLikes(uid, malid);
  }

  Future<bool> animeExistsInUserLikes(String uid, int malid) async {
    var collect = await _database
        .collection('users')
        .document(uid)
        .collection('likes')
        .document(malid.toString())
        .get();
    return collect.exists;
  }

  void removeAnimeFromUserLikes(String uid, int malid) async {
    await _database
        .collection('users')
        .document(uid)
        .collection('likes')
        .document(malid.toString())
        .delete();
  }

  void addAnimeToUserLikes(String uid, int malid) async {
    await _database
        .collection('users')
        .document(uid)
        .collection('likes')
        .document(malid.toString())
        .setData({'malid': malid});
  }
}
