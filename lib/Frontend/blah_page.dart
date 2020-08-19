import 'package:FlutterApp06/Data_Models/chat_message.dart';
import 'package:FlutterApp06/Data_Models/user_account.dart';
import 'package:FlutterApp06/Frontend/registration_page.dart';
import 'package:FlutterApp06/Services/firestore_services.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gradient_app_bar/gradient_app_bar.dart';
import 'package:gradient_bottom_navigation_bar/gradient_bottom_navigation_bar.dart';

import 'logged_in_page.dart';

class BlahPage extends StatefulWidget {
  String userId;
  BlahPage(this.userId);

  @override
  _BlahPageState createState() => _BlahPageState();
}

class _BlahPageState extends State<BlahPage> {
  FirestoreService firestoreService = new FirestoreService();
  int selectedIndex = 1;
  String message;
  String id;
  bool showProgress = false;
  @override
  Widget build(BuildContext context) {
    id = widget.userId;
    print("BLAH BLAH PAGE, USER ID: " + id);
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
      bottomNavigationBar: GradientBottomNavigationBar(
        backgroundColorStart: Colors.purple,
        backgroundColorEnd: Colors.deepOrange,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.home), title: Text('Home')),
          BottomNavigationBarItem(icon: Icon(Icons.chat), title: Text('BLAH')),
        ],
        currentIndex: selectedIndex,
        onTap: onPressNavigationBar,
      ),
      body: Center(
          child: Column(
        children: [
          Expanded(
            child: StreamBuilder<List<ChatMessage>>(
                stream: firestoreService.streamMessages(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    print(
                        "Has Data entries: " + snapshot.data.length.toString());
                    return ListView.builder(
                        shrinkWrap: true,
                        padding: const EdgeInsets.all(8.0),
                        itemCount: snapshot.data.length,
                        itemBuilder: (context, index) {
                          return ListTile(
                              title: Text(snapshot.data[index].content),
                              subtitle: Text("Poster: " +
                                  snapshot.data[index].posterDisplayName));
                        });
                  } else {
                    print("StreamMessage didn't return any data");
                    return Container();
                  }
                }),
          ),
          SizedBox(
            height: 20.0,
          ),
          TextField(
            obscureText: false,
            textAlign: TextAlign.center,
            onChanged: (value) {
              message = value; //get value from textField
            },
            decoration: InputDecoration(
                hintText: "Enter message...",
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
                  firestoreService.postChatMessage(id, message);
                  setState(() {
                    showProgress = false;
                  });
                } catch (e) {}
              },
              minWidth: 200.0,
              height: 45.0,
              child: Text(
                "Post Message",
                style: TextStyle(fontWeight: FontWeight.w500, fontSize: 20.0),
              ),
            ),
          ),
          SizedBox(
            height: 20.0,
          ),
        ],
      )),
    );
  }

  void onPressNavigationBar(int index) {
    setState(() {
      selectedIndex = index;
      if (selectedIndex == 0) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => LoggedInPage(id)),
        );
      } else {}
    });
  }
}
/*



 */
