import 'package:FlutterApp06/Data_Models/chat_message.dart';
import 'package:FlutterApp06/Data_Models/user_account.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uuid/uuid.dart';

class FirestoreService 
{
  Firestore firestore = Firestore.instance;
  
  Stream<List<ChatMessage>> streamMessages()
  {
    print("Stream message start");
    return firestore.collection("chats").snapshots().map((snap)
    {
      print("Found Snaps: " + snap.documents.length.toString());
      var tempList = snap.documents.map((e) => new ChatMessage.fromJson(e.data)).toList();
      print("Snaps to return: " + tempList.toString());
      return snap.documents.map((e) => new ChatMessage.fromJson(e.data)).toList();
    });
  }

  void postChatMessage(String accountId, String message) async
  {
      print("POST MESSAGE ID: " + accountId);
      print("POST MESSAGE MESSAGE: " + message);

      UserAccount account = await firestore.collection("users").where("id", isEqualTo:accountId).getDocuments().then((event) {
        if (event.documents.isNotEmpty)
        {
          return new UserAccount.fromJson(event.documents.first.data);
        }
      return null;
      });

      print("POST MESSAGE RETRIEVED ACCOUNT: " + account.id);

      DocumentReference ref = await firestore.collection("chats").add({
      "id":"ID",
      "posterId":account.id,
      "posterDisplayName":account.id,
      "content":message
      });
      await firestore.collection("chats").document(ref.documentID).updateData({"id":ref.documentID});
      print("New Chat: " + ref.toString());
  }


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


  void postNewAccount(UserAccount account, String referralCode) async
  {
    print("Post new account start.");
    print("Account id: ||"+account.id+"||");
    print("Account email: ||"+account.email+"||");
    print("Account reflink: ||"+account.reflink+"||");
    print("Referal Code: ||"+referralCode+"||");
    int scoreForNewUser = 0;
    DocumentSnapshot linkOwner;
    if (referralCode != null)
    {
      print("Referral check follows...");
      linkOwner = await firestore.collection("users").where("reflink", isEqualTo:referralCode).getDocuments().then((event) {
      if (event.documents.isNotEmpty)
      {
        print("Referral found, returning.");
        return event.documents.first;
      }
      print("Referral NOT found, continuing.");
      return null;
    });
    }
    else
    {
      print("No referral code provided.");
    }


    if (linkOwner != null)
    {
      print("Link Owner: " + linkOwner.toString());
      print("Updating score for link owner.");
      int currentScore = await linkOwner["score"];
      await firestore.collection("users").document(linkOwner.documentID).updateData({"score":(currentScore + 100)});
      scoreForNewUser = 50;
    }
    
    
    var uuid = new Uuid();
    print("Creating new user in database.");
    DocumentReference ref = await firestore.collection("users").add({
      "id":account.id,
      "email":account.email,
      "reflink":uuid.v4(),
      "score":scoreForNewUser
      });
    print(ref.toString());
    print("DONE.");
  }
}
