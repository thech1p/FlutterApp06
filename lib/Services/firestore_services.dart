import 'package:FlutterApp06/Data_Models/user_account.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uuid/uuid.dart';

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

  Stream<List<UserAccount>> getUser(String id)
  {
    //UserAccount account;

    //return firestore.collection("users").where("uuid", isEqualTo:id).snapshots();
     return firestore.collection("users").where("id", isEqualTo:id).snapshots().map((snap) 
     {
       return snap.documents.map((e) => new UserAccount.fromJson(e.data)).toList();
     });

    // var reference = await firestore.collection("users").document(id).get(); 
    // if (returnValue != null)
    // {
    //   var returnAcc = new UserAccount.fromJson(reference.data);
    // }
    // return null;
  }


  void postNewAccount(UserAccount account, String referalCode) async
  {
    int scoreForNewUser = 0;

    DocumentSnapshot linkOwner; 
    await firestore.collection("users").where("reflink", isEqualTo:referalCode).getDocuments().then((event) {
      if (event.documents.isNotEmpty)
      {
        linkOwner = event.documents.first;
      }
    });

    if (linkOwner != null)
    {
      await firestore.collection("users").document(linkOwner.documentID).updateData({"score":linkOwner["score"] + 100});
      scoreForNewUser = 50;
    }
    
    var uuid = new Uuid();
    DocumentReference ref = await firestore.collection("users").add({
      "id":account.id,
      "email":account.email,
      "reflink":uuid.v4(),
      "score":scoreForNewUser
      });
    print(ref.toString());
  }
}
