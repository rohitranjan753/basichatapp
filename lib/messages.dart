import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'message_bubble.dart';

class Messages extends StatelessWidget {
  const Messages({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    User? currentUserInfo = FirebaseAuth.instance.currentUser;
    return FutureBuilder(
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
      if (snapshot.connectionState == ConnectionState.waiting) {
        return Center(
          child: CircularProgressIndicator(),
        );
      }
      return StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection("chat")
            .orderBy('timeStamp', descending: true)
            .snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> chatSnapshot) {
          if (chatSnapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          final chatDocs = chatSnapshot.data!.docs;
          return ListView.builder(
            reverse: true,
            // itemBuilder: (context, index) => Text(chatDocs[index]['text']),
            itemBuilder: (context, index) => MessageBubble(
                chatDocs[index]['text'],
                chatDocs[index]['username'],
                chatDocs[index]['userImage'],
                chatDocs[index]['userId'] == currentUserInfo!.uid,
              key: ValueKey(chatDocs[index].id)),

            itemCount: chatDocs.length,
          );
        },
      );
    });
  }
}
