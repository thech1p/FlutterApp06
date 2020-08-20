import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gradient_app_bar/gradient_app_bar.dart';

import 'logged_in_page.dart';

class MyLoginPage extends StatefulWidget {
  @override
  MyLoginPageState createState() => MyLoginPageState();
}

class MyLoginPageState extends State<MyLoginPage> {
  FirebaseAuth auth = FirebaseAuth.instance;
  bool showProgress = false;
  //text controllers that store input text to be added to fields below
  TextEditingController email, password;

  showSuccessMessage() => Fluttertoast.showToast(
        msg: "Login Successful",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        //timeInSecForIos: 1,
        backgroundColor: Colors.blueAccent,
        textColor: Colors.white,
        fontSize: 16.0,
      );

  showErrorMessage() => Fluttertoast.showToast(
        msg: "Login Failed",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        //timeInSecForIos: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0,
      );

  //isolating business logic from flutter code (setstate, navigator, etc) for testing
  Future<AuthResult> signIn() => auth.signInWithEmailAndPassword(
        email: email.text,
        password: password.text,
      );

  Future<void> onPressed() async {
    setState(() => showProgress = true);

    try {
      //await sign in function
      final newUser = await signIn();

      print(newUser.toString());

      if (newUser != null) {
        //show success toast
        showSuccessMessage();

        //untoggle loading indicator
        setState(() => showProgress = false);

        print(newUser.user.uid);

        //push logged in view
        Navigator.of(context).push(LoggedInPage.route(newUser.user.uid));
      }
    } catch (e) {
      print(e);

      //show error toast
      showErrorMessage();
    }
  }

  @override
  void initState() {
    //initialising controllers that we use to listen to text input
    email = TextEditingController();
    password = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    //need to dispose controllers when view is destroyed
    email.dispose();
    password.dispose();
    super.dispose();
  }

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
                _LoginTextField(
                  controller: email,
                  hintText: "Enter your Email",
                ),
                SizedBox(height: 20.0),
                _LoginTextField(
                  controller: email,
                  hintText: "Enter your Password",
                  obscureText: true,
                ),
                SizedBox(height: 20.0),
                Material(
                  elevation: 5,
                  color: Colors.lightBlue,
                  borderRadius: BorderRadius.circular(32.0),
                  child: MaterialButton(
                    onPressed: onPressed,
                    minWidth: 200.0,
                    height: 45.0,
                    child: Text(
                      "Login",
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 20.0,
                      ),
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

class _LoginTextField extends StatelessWidget {
  const _LoginTextField({
    Key key,
    @required this.controller,
    @required this.hintText,
    this.obscureText = false,
  }) : super(key: key);

  final TextEditingController controller;
  final String hintText;
  final bool obscureText;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      obscureText: obscureText,
      keyboardType: TextInputType.emailAddress,
      textAlign: TextAlign.center,
      decoration: InputDecoration(
          hintText: hintText,
          border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(32.0)))),
    );
  }
}
