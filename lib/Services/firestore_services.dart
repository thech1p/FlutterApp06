import 'package:FlutterApp06/Data_Models/user_account.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class FirestoreService 
{
  Firestore firestore = Firestore.instance;
  
  Stream<List<UserAccount>> streamUsers()
  {
    return firestore.collection("users").snapshots().map((snap) 
    {
      return snap.documents.map((e) => new UserAccount.fromJson(e.data)).toList();
    });
  }
}
