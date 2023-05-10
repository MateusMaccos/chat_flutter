import 'package:flutter/material.dart';
import 'package:projeto_chat/core/models/chat_user.dart';
import 'package:projeto_chat/pages/auth_page.dart';
import 'package:projeto_chat/pages/chat_page.dart';
import 'package:projeto_chat/pages/loading_page.dart';
import '../core/services/auth/auth_service.dart';

class AuthOrAppPage extends StatelessWidget {
  const AuthOrAppPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: StreamBuilder<ChatUser?>(
      stream: AuthService().userChanges,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return LoadingPage();
        } else {
          return snapshot.hasData ? ChatPage() : AuthPage();
        }
      },
    ));
  }
}
