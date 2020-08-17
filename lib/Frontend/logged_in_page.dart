import 'package:FlutterApp06/Data_Models/user_account.dart';
import 'package:FlutterApp06/Frontend/registration_page.dart';
import 'package:FlutterApp06/Services/firestore_services.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gradient_app_bar/gradient_app_bar.dart';

import 'login_page.dart';

class LoggedInPage extends StatefulWidget {

  String userId; 

  LoggedInPage(this.userId);

  @override
  _LoggedInPageState createState() => _LoggedInPageState();
}

class _LoggedInPageState extends State<LoggedInPage> {
  FirestoreService firestoreService = new FirestoreService();

  bool showProgress = false;
  @override
  Widget build(BuildContext context) {
    String id = widget.userId;
    //UserAccount targetAccount = await firestoreService.getUser(widget.userId);
    return Scaffold(
        appBar: PreferredSize(
            preferredSize: Size.fromHeight(50.0), // here the desired height
            child: GradientAppBar(
              automaticallyImplyLeading: false, // hides leading widget
              flexibleSpace: Image.asset('Assets/SuperApp3000Logo.png'),
              //title: Text("Super App 3000"),
              //title: Image.asset('Assets/SuperApp3000Logo.png',),
              //title: Image.asset('Assets/SuperApp3000Logo.png'),
              backgroundColorStart: Colors.cyan,
              backgroundColorEnd: Colors.pink,
            )),
        body: Center(
            child: Container(
          child: Column(
            children: [
              
              Container(child: Text("USER INFO")),
              
              StreamBuilder<List<UserAccount>>(
                   stream: firestoreService.getUser(id),
                   builder: (context, snapshot) {
                     if (snapshot.hasData && snapshot.data.length > 0) {
                       return Column(children: [
                          SelectableText("Email: " + snapshot.data[0].email,
                            textAlign: TextAlign.center,
                            style: TextStyle(fontWeight: FontWeight.bold)),
                          SelectableText("Personal Ref link: " + snapshot.data[0].reflink,
                            textAlign: TextAlign.center,
                            style: TextStyle(fontWeight: FontWeight.bold)),
                          SelectableText("Personal Score: " + snapshot.data[0].score.toString(),
                            textAlign: TextAlign.center,
                            style: TextStyle(fontWeight: FontWeight.bold))
                       ],);
                      //Text(snapshot.data.toString());
                      //  ListView.builder(
                      //      itemCount: snapshot.data.length,
                      //      itemBuilder: (context, index) {
                      //        return ListTile(
                      //            title: Text(snapshot.data[index].name),
                      //            subtitle: Text("Age: " +
                      //                snapshot.data[index].age.toString()));
                      //      });
                     } else {
                       return Text("Loading");
                     }
                   }),
              
              Material(
                elevation: 5,
                color: Colors.lightBlue,
                borderRadius: BorderRadius.circular(32.0),
                child: MaterialButton(
                  onPressed: () async {
                    setState(() {
                      showProgress = true;
                    });
                    try {
                      Navigator.pop(
                        context,
                        MaterialPageRoute(builder: (context) => MyHomePage()),
                      );
                      setState(() {
                        showProgress = false;
                      });
                    } catch (e) {}
                  },
                  minWidth: 200.0,
                  height: 45.0,
                  child: Text(
                    "Log out",
                    style:
                        TextStyle(fontWeight: FontWeight.w500, fontSize: 20.0),
                  ),
                ),
              ),
            ],
          ),
    )));
  }
}
