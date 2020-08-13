import 'package:FlutterApp06/Frontend/registration_page.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gradient_app_bar/gradient_app_bar.dart';

import 'login_page.dart';

class LoggedInPage extends StatefulWidget {
  @override
  _LoggedInPageState createState() => _LoggedInPageState();
}

class _LoggedInPageState extends State<LoggedInPage> {
  bool showProgress = false;
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
        body: Center(child: Container(


          child: Column(children: [Material(
                  elevation: 5,
                  color: Colors.lightBlue,
                  borderRadius: BorderRadius.circular(32.0),
                  child: MaterialButton(
                    onPressed: () async {
                      setState(() {
                        showProgress = true;
                      });
                      try {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => MyHomePage()),
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
                ),],),
        )));
  }
}
