import 'package:chat_app/widgets/chat/message_bubble.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Messages extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<FirebaseUser>(
      future: FirebaseAuth.instance.currentUser(),
      builder: (context, futureSnapshot) {
        if (futureSnapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        return StreamBuilder<QuerySnapshot>(
          stream: Firestore.instance
              .collection('chat')
              .orderBy('createdAt', descending: true)
              .snapshots(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            final List<DocumentSnapshot> documents = snapshot.data.documents;
            return ListView.builder(
              reverse: true,
              itemCount: documents.length,
              itemBuilder: (BuildContext context, int index) {
                return Container(
                  padding: const EdgeInsets.all(8),
                  child: MessageBubble(
                    documents[index]['text'].toString(),
                    documents[index]['userId'] == futureSnapshot.data.uid,
                    documents[index]['userImage'].toString(),
                    documents[index]['userName'].toString(),
                    key: ValueKey(documents[index].documentID),
                  ),
                );
              },
            );
          },
        );
      },
    );
  }
}
