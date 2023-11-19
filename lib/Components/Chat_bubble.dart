import 'package:flutter/material.dart';
import 'package:transigo_app/Models/cahr_messages_data.dart';

class ChatBubbleResiver extends StatelessWidget {
  const ChatBubbleResiver({super.key, required this.messages});

  final Messages messages;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 32, vertical: 16),
        margin: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(32),
            color: Theme.of(context).primaryColor.withOpacity(0.1)),
        child: Text(
          messages.message,
          style: TextStyle(
              color: Theme.of(context).primaryColor,
              fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}

class ChatBubbleSender extends StatelessWidget {
  const ChatBubbleSender({super.key, required this.messages});

  final Messages messages;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 32, vertical: 16),
        margin: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            color: Theme.of(context).primaryColor),
        child: Text(
          messages.message,
          style: TextStyle(
              color: Theme.of(context).primaryColorLight,
              fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
