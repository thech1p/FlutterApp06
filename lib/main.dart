import 'package:FlutterApp06/Data_Models/user_account.dart';
import 'package:FlutterApp06/Services/firestore_services.dart';
import 'package:flutter/material.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_performance/firebase_performance.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'Frontend/registration_page.dart';

FirebaseAnalytics analytics;

void main() {
  //analytics = FirebaseAnalytics();
  runApp(AppMainState());
}

class AppMainState extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.cyan,
      ),
      home: MyHomePage(),
    );
  }
}








// class MainPage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text("Test Application - Main page")),
//       body: Container(
//         alignment: Alignment.bottomCenter,
//         child: RaisedButton(
//           child: Text("Login"),
//           onPressed: () {
//             Navigator.push(
//                 context, MaterialPageRoute(builder: (context) => LoginPage()));
//           },
//         ),
//       ),
//     );
//   }
// }

// class LoginPage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text("Login")),
//       body: Container(
//         alignment: Alignment.center,
//         child: Column(
//           children: [
//             LoginContainer(),
//             RaisedButton(
//               child: Text("Go back"),
//               onPressed: () {
//                 Navigator.push(context,
//                     MaterialPageRoute(builder: (context) => MainPage()));
//               },
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// class LoginContainer extends StatefulWidget {
//   LoginContainer({Key key}) : super(key: key);
//   @override
//   LoginContainerState createState() => LoginContainerState();
// }

// class LoginContainerState extends State<LoginContainer> {
//   final _formKey = GlobalKey<FormState>();

//   @override
//   void initState() {
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Form(
//         key: _formKey,
//         child: Container(
//             decoration: const BoxDecoration(
//                       gradient: LinearGradient(
//                         begin: Alignment.bottomRight,
//                         end: Alignment.topLeft,
//                         colors: <Color>[
//                           Color.fromRGBO(250, 150, 0, 1),
//                           Color.fromRGBO(250, 250, 0, 1),
//                         ],
//                       ),
//                     ),
//             margin: EdgeInsets.all(10),
//             //color: Colors.amber[600],
            
//             child: Column(
//               children: <Widget>[
                


//                 Padding(
//                   padding: const EdgeInsets.all(8.0),
//                   child: TextFormField(
//                     decoration: const InputDecoration(
//                       hintText: 'Enter your email',
//                     ),
//                     validator: (value) {
//                       if (value.isEmpty) {
//                         return "Please enter your email";
//                       }
//                       return null;
//                     },
//                   ),
//                 ),
//                 Padding(
//                   padding: const EdgeInsets.all(8.0),
//                   child: TextFormField(
//                     decoration: const InputDecoration(
//                       hintText: 'Enter your password',
//                     ),
//                     validator: (value) {
//                       if (value.isEmpty) {
//                         return "Please enter your password";
//                       }
//                       return null;
//                     },
//                   ),
//                 ),
//                 RaisedButton(
//                   onPressed: () {
                      
//                       if (_formKey.currentState.validate()) {
//                             print("valid Entry");
//                           }
//                   },
//                   textColor: Colors.white,
//                   padding: const EdgeInsets.all(-20.0),
//                   child: Container(
//                     decoration: const BoxDecoration(
//                       gradient: LinearGradient(
//                         begin: Alignment.topLeft,
//                         end: Alignment.bottomRight,
//                         colors: <Color>[
//                           Color.fromRGBO(250, 150, 0, 1),
//                           Color.fromRGBO(250, 250, 0, 1),
//                         ],
//                       ),
//                     ),
//                     padding: const EdgeInsets.all(10.0),
//                     child: const Text('  Login  ',
//                         style: TextStyle(fontSize: 20)),
//                   ),
//                 ),
//               ],
//             )));
//   }
// }


// onPressed: () {
//                           if (_formKey.currentState.validate()) {
//                             print("valid Entry");
//                           }

// class MyApp extends StatefulWidget {
//   @override
//   MyAppState createState() => MyAppState();
// }

// class MyAppState extends State<MyApp> {
//   FirestoreService firestoreService = new FirestoreService();
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//         title: 'Flutter Demo',
//         theme: ThemeData(
//           primarySwatch: Colors.blue,
//           visualDensity: VisualDensity.adaptivePlatformDensity,
//         ),
//         home: Scaffold(
//           body: Center(
//               child: StreamBuilder<List<UserAccount>>(
//                   stream: firestoreService.streamUsers(),
//                   builder: (context, snapshot) {
//                     if (snapshot.hasData) {
//                       return ListView.builder(
//                           itemCount: snapshot.data.length,
//                           itemBuilder: (context, index) {
//                             return ListTile(
//                                 title: Text(snapshot.data[index].name),
//                                 subtitle: Text("Age: " +
//                                     snapshot.data[index].age.toString()));
//                           });
//                     } else {
//                       return Container();
//                     }
//                   })),
//         ));
//   }
// }

// class ButtonAndTitle extends StatefulWidget {
//   final String title;
//   final String buttonLabel;
//   ButtonAndTitle(this.title, this.buttonLabel);
//   @override
//   _ButtonAndTitleState createState() => _ButtonAndTitleState();
// }

// class _ButtonAndTitleState extends State<ButtonAndTitle> {
//   String _title;
//   String _buttonLabel;
//   @override
//   void initState() {
//     _title = widget.title;
//     _buttonLabel = widget.buttonLabel;
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//         child: Column(children: [
//       Text(_title),
//       RaisedButton(
//           onPressed: () {
//             setState(() {
//               print(_buttonLabel + " was pressed");
//             });
//           },
//           child: Text(_buttonLabel))
//     ]));
//   }
// }
