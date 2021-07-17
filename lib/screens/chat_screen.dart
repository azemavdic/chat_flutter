import 'package:chat_app/widgets/chat/messages.dart';
import 'package:chat_app/widgets/chat/new_message.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

class ChatScreen extends StatefulWidget {
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  @override
  void initState() {
    super.initState();
    final fbm = FirebaseMessaging();
    fbm.subscribeToTopic('chat');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tehnolozi'),
        // ignore: always_specify_types
        actions: [
          // ignore: always_specify_types
          DropdownButton(
            underline: Container(),
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
