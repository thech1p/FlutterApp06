import 'package:FlutterApp06/Data_Models/user_account.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:gradient_app_bar/gradient_app_bar.dart';

import 'package:FlutterApp06/Services/firestore_services.dart';
import 'login_page.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  FirestoreService firestoreService = new FirestoreService();
  final _auth = FirebaseAuth.instance;
  bool showProgress = false;
  String email, password, referralCode;
  @override
  Widget build(BuildContext context) {
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
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topRight,
                  end: Alignment.bottomLeft,
                  colors: [Colors.cyan, Colors.pink])),
          child: ModalProgressHUD(
            inAsyncCall: showProgress,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Image.asset(
                  'Assets/New_User.png',
                  height: 80,
                ),
                // Text(
                //   "New user",
                //   style: TextStyle(fontWeight: FontWeight.w800, fontSize: 30.0),
                // ),
                // SizedBox(
                //   height: 1.0,
                // ),
                TextField(
                  keyboardType: TextInputType.emailAddress,
                  textAlign: TextAlign.center,
                  onChanged: (value) {
                    email = value; //get the value entered by user.
                  },
                  decoration: InputDecoration(
                      hintText: "Enter your Email",
                      border: OutlineInputBorder(
                          borderRadius:
                              BorderRadius.all(Radius.circular(32.0)))),
                ),
                SizedBox(
                  height: 20.0,
                ),
                TextField(
                  obscureText: true,
                  textAlign: TextAlign.center,
                  onChanged: (value) {
                    password = value; //get the value entered by user.
                  },
                  decoration: InputDecoration(
                      hintText: "Enter your Password",
                      border: OutlineInputBorder(
                          borderRadius:
                              BorderRadius.all(Radius.circular(32.0)))),
                ),
                SizedBox(
                  height: 20.0,
                ),
                TextField(
                  obscureText: false,
                  textAlign: TextAlign.center,
                  onChanged: (value) {
                    referralCode = value; //get the value entered by user.
                  },
                  decoration: InputDecoration(
                      hintText: "Referral code",
                      border: OutlineInputBorder(
                          borderRadius:
                              BorderRadius.all(Radius.circular(16.0)))),
                ),
                SizedBox(
                  height: 10.0,
                ),
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
                        final newuser =
                            await _auth.createUserWithEmailAndPassword(
                                email: email, password: password);

                        if (newuser != null) {
                          print("newuser uid: " + newuser.user.uid);
                          UserAccount newAccount = new UserAccount(newuser.user.uid, email, "REFLINK", 0);
                          print("newAccount (id): " + newAccount.id);
                          print("newAccount (id): " + newAccount.email);
                          print("newAccount (id): " + newAccount.reflink);
                          print("newAccount (id): " + newAccount.score.toString());
                          firestoreService.postNewAccount(newAccount, referralCode.toString());
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => MyLoginPage()),
                          );
                          setState(() {
                            showProgress = false;
                          });
                        }
                      } catch (e) {}
                    },
                    minWidth: 200.0,
                    height: 45.0,
                    child: Text(
                      "Register",
                      style: TextStyle(
                          fontWeight: FontWeight.w500, fontSize: 20.0),
                    ),
                  ),
                ),
                SizedBox(
                  height: 15.0,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => MyLoginPage()),
                    );
                  },
                  child: Text(
                    "Already Registred? Login Now",
                    style: TextStyle(
                        color: Colors.blue, fontWeight: FontWeight.w900),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
