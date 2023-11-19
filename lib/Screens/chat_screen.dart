import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:transigo_app/Components/Chat_bubble.dart';
import 'package:transigo_app/Components/Drawer.dart';
import 'package:transigo_app/Models/cahr_messages_data.dart';

class ChatScreen extends StatelessWidget {
  ChatScreen({super.key});

  TextEditingController controller = TextEditingController();
  ScrollController scrollController = ScrollController();
  CollectionReference messages =
      FirebaseFirestore.instance.collection('messages');

  @override
  Widget build(BuildContext context) {
    String email = ModalRoute.of(context)!.settings.arguments as String;
    return StreamBuilder<QuerySnapshot>(
      stream: messages.orderBy('CreatedAt', descending: true).snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          List<Messages> messagesList = [];
          for (int i = 0; i < snapshot.data!.docs.length; i++) {
            messagesList.add(Messages.fromJson(snapshot.data!.docs[i]));
          }

          return Scaffold(
            drawer: const AppDrawer(),
            appBar: AppBar(
              centerTitle: true,
              title: Image.asset(
                'assets/Logo.png',
                scale: 3.5,
              ),
              backgroundColor: Colors.transparent,
              elevation: 0.0,
              iconTheme: IconThemeData(
                color: Theme.of(context).primaryColor,
                size: 32,
              ),
            ),
            body: Column(children: [
              Expanded(
                child: ListView.builder(
                    reverse: true,
                    controller: scrollController,
                    itemCount: messagesList.length,
                    itemBuilder: (context, Index) {
                      return messagesList[Index].id == email
                          ? ChatBubbleSender(
                              messages: messagesList[Index],
                            )
                          : ChatBubbleResiver(
                              messages: messagesList[Index],
                            );
                    }),
              ),
              Padding(
                padding: const EdgeInsets.all(32.0),
                child: TextField(
                  controller: controller,
                  onSubmitted: (data) {
                    messages.add({
                      'message': data,
                      'Id': email,
                      'CreatedAt': DateTime.now()
                    });
                    ;
                    controller.clear();

                    scrollingMesseges();
                  },
                  decoration: InputDecoration(
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide: BorderSide(
                            color: Theme.of(context).primaryColor, width: 2),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide: BorderSide(
                            color: Theme.of(context).primaryColor, width: 5),
                      ),
                      hintText: "Enter Your Message ",
                      suffixIcon: GestureDetector(
                          // onTap: () => AddMessage(_controller.text),
                          child: Icon(Icons.send)),
                      iconColor: Theme.of(context).primaryColor),
                ),
              ),
            ]),
          );
        } else {
          return ModalProgressHUD(inAsyncCall: true, child: Scaffold());
        }
      },
    );
  }

  void scrollingMesseges() {
    scrollController.animateTo(
      0,
      duration: const Duration(seconds: 1),
      curve: Curves.fastOutSlowIn,
    );
  }
}
