import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gradient_app_bar/gradient_app_bar.dart';

import 'logged_in_page.dart';

class MyLoginPage extends StatefulWidget {
  @override
  _MyLoginPageState createState() => _MyLoginPageState();
}

class _MyLoginPageState extends State<MyLoginPage> {
  final _auth = FirebaseAuth.instance;
  bool showProgress = false;
  String email, password;
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
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Colors.cyan, Colors.pink])),
          child: ModalProgressHUD(
            inAsyncCall: showProgress,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                //Image.asset('Assets/SuperApp3000Logo.png',),
                Image.asset('Assets/Login.png', height: 80),
                // Text(
                //   "Login Page",
                //   style: TextStyle(fontWeight: FontWeight.w800, fontSize: 20.0),
                // ),
                // SizedBox(
                //   height: 20.0,
                // ),
                TextField(
                  keyboardType: TextInputType.emailAddress,
                  textAlign: TextAlign.center,
                  onChanged: (value) {
                    email = value; // get value from TextField
                  },
                  decoration: InputDecoration(
                      hintText: "Enter your Email",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(32.0)))),
                ),
                SizedBox(
                  height: 20.0,
                ),
                TextField(
                  obscureText: true,
                  textAlign: TextAlign.center,
                  onChanged: (value) {
                    password = value; //get value from textField
                  },
                  decoration: InputDecoration(
                      hintText: "Enter your Password",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(32.0)))),
                ),
                SizedBox(
                  height: 20.0,
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
                        final newUser = await _auth.signInWithEmailAndPassword(
                            email: email, password: password);

                        print(newUser.toString());

                        if (newUser != null) {
                          Fluttertoast.showToast(
                              msg: "Login Successfull",
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.CENTER,
                              //timeInSecForIos: 1,
                              backgroundColor: Colors.blueAccent,
                              textColor: Colors.white,
                              fontSize: 16.0);
                          setState(() {
                            showProgress = false;
                          });
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => LoggedInPage()));
                        
                        }
                      } catch (e) {}
                    },
                    minWidth: 200.0,
                    height: 45.0,
                    child: Text(
                      "Login",
                      style:
                          TextStyle(fontWeight: FontWeight.w500, fontSize: 20.0),
                    ),
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