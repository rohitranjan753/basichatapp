import 'package:chatproject/messages.dart';
import 'package:chatproject/new_message.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {

  @override
  void initState() {
    super.initState();
    final fbm = FirebaseMessaging.instance;
    fbm.requestPermission();
    FirebaseMessaging.onMessage.listen((message) {
      print(message);
      return;
    });
    FirebaseMessaging.onMessageOpenedApp.listen((message) {
      print(message);
      return;
    });
  }

  @override
  Widget build(BuildContext context) {


    return Scaffold(
      appBar: AppBar(
        title: Text("Flutter Chat"),
        actions: [
          DropdownButton(
            underline: Container(),
            icon: Icon(
              Icons.more_vert,
              color: Theme.of(context).primaryIconTheme.color,
            ),
            items: [
              DropdownMenuItem(
                child: Container(
                  child: Row(
                    children: [
                      Icon(Icons.exit_to_app),
                      SizedBox(
                        width: 8,
                      ),
                      Text("Logout"),
                    ],
                  ),
                ),
                value: 'logout',
              )
            ],
            onChanged: (itemIdentifier) {
              if (itemIdentifier == 'logout') {
                FirebaseAuth.instance.signOut();
              }
            },
          )
        ],
      ),

      //in body it was there
      //   StreamBuilder(
      //     stream: FirebaseFirestore.instance
      //         .collection('chats/miv5Wr0TK2hgFlmdVrFL/messages')
      //         .snapshots(),
      //     builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
      //       if (snapshot.connectionState == ConnectionState.waiting) {
      //         return Center(
      //           child: CircularProgressIndicator(),
      //         );
      //       }
      //       final documents = snapshot.data!.docs;
      //       return ListView.builder(
      //         itemCount: documents.length,
      //         itemBuilder: (cxt, index) => Container(
      //           padding: EdgeInsets.all(9),
      //           child: Text(documents[index]['text']),
      //         ),
      //       );
      //     },
      //   ),
      body: Container(
        child: Column(
          children: [
            Expanded(child: Messages(),
            ),
            NewMessage(),
          ],
        ),
      ),
      // floatingActionButton: FloatingActionButton(
      //   child: Icon(Icons.add),
      //   onPressed: () {
      //     FirebaseFirestore.instance
      //         .collection("chats/miv5Wr0TK2hgFlmdVrFL/messages")
      //         .add({'text': "This was added by me"});
      //   },
      // ),
    );
  }
}
