import 'package:chat_app/widgets/chat/messages.dart';
import 'package:chat_app/widgets/chat/new_message.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ChatScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tehnolozi'),
        // ignore: always_specify_types
        actions: [
          // ignore: always_specify_types
          DropdownButton(
            icon: const Icon(Icons.more_vert),
            onChanged: (value) {
              if (value == 'odjava') {
                FirebaseAuth.instance.signOut();
              }
            },
            items: [
              DropdownMenuItem(
                  value: 'odjava',
                  child: SizedBox(
                    child: Row(
                      // ignore: prefer_const_literals_to_create_immutables
                      children: [
                        const Icon(Icons.exit_to_app),
                        const SizedBox(width: 8),
                        const Text('Odjava'),
                      ],
                    ),
                  )),
            ],
          ),
        ],
      ),
      body: SizedBox(
        child: Column(
          children: [
            Expanded(
              child: Messages(),
            ),
            NewMessage(),
          ],
        ),
      ),
    );
  }
}
