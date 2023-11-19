import 'package:flutter/foundation.dart';

class Messages {
  final String message;
  final String id;

  Messages({required this.id, required this.message});

  factory Messages.fromJson(json) {
    return Messages(message: json['message'], id: json['Id']);
  }
}
