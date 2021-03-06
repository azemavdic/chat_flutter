import 'package:chat_app/widgets/chat/message_bubble.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Messages extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('chat')
          .orderBy('createdAt', descending: true)
          .snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        final List<DocumentSnapshot> documents = snapshot.data.docs;
        return ListView.builder(
          reverse: true,
          itemCount: documents.length,
          itemBuilder: (BuildContext context, int index) {
            return Container(
              padding: const EdgeInsets.all(8),
              child: MessageBubble(
                documents[index].data()['text'].toString(),
                documents[index].data()['userId'] == user.uid,
                documents[index].data()['userImage'].toString(),
                documents[index].data()['userName'].toString(),
                key: ValueKey(documents[index].id),
              ),
            );
          },
        );
      },
    );
  }
}
