import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:projeto_chat/core/models/chat_user.dart';
import 'package:projeto_chat/core/services/notification/push_notification_service.dart';
import 'package:projeto_chat/pages/chat_page.dart';
import 'package:projeto_chat/pages/loading_page.dart';
import 'package:provider/provider.dart';
import '../core/services/auth/auth_service.dart';
import 'login_or_signup.dart';

class AuthOrAppPage extends StatelessWidget {
  const AuthOrAppPage({super.key});

  Future<void> init(BuildContext context) async {
    await Firebase.initializeApp();
    await Provider.of<ChatNotificationService>(
      context,
      listen: false,
    ).init();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: init(context),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const LoadingPage();
          } else {
            return StreamBuilder<ChatUser?>(
              stream: AuthService().userChanges,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const LoadingPage();
                } else {
                  return snapshot.hasData
                      ? const ChatPage()
                      : const LoginOrSignUp();
                }
              },
            );
          }
        });
  }
}
