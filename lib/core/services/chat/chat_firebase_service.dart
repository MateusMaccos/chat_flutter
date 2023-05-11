import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:projeto_chat/core/models/chat_message.dart';
import 'package:projeto_chat/core/services/chat/chat_service.dart';

import '../../models/chat_user.dart';

class ChatFirebaseService implements ChatService {
  @override
  Stream<List<ChatMessage>> messagesStream() {
    return Stream<List<ChatMessage>>.empty();
  }

  @override
  Future<ChatMessage?> save(String text, ChatUser user) async {
    final store = FirebaseFirestore.instance;
    store.collection('chat').add({
      'text': text,
      'createdAt': DateTime.now().toIso8601String(),
      'userId': user.id,
      'userName': user.name,
      'userImageURL': user.ImageUrl,
    });
    return null;
  }
}
