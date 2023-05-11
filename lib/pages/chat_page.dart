import 'package:flutter/material.dart';
import 'package:projeto_chat/components/messages.dart';
import 'package:projeto_chat/components/new_message.dart';
import 'package:projeto_chat/pages/notification_page.dart';
import 'package:provider/provider.dart';
import '../core/services/auth/auth_service.dart';
import '../core/services/notification/push_notification_service.dart';

class ChatPage extends StatelessWidget {
  const ChatPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: Text(
          'Chat',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        actions: [
          DropdownButtonHideUnderline(
            child: DropdownButton(
                items: [
                  DropdownMenuItem(
                      value: 'logout',
                      child: Container(
                        child: const Row(
                          children: [
                            Icon(
                              Icons.exit_to_app,
                              color: Colors.black87,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text('Sair')
                          ],
                        ),
                      ))
                ],
                icon: Icon(
                  Icons.more_vert,
                  color: Theme.of(context).primaryIconTheme.color,
                ),
                onChanged: (value) {
                  if (value == 'logout') {
                    AuthService().logout();
                  }
                }),
          ),
          Stack(
            children: [
              IconButton(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(builder: (ctx) {
                    return const NotificationPage();
                  }));
                },
                icon: Icon(
                  Icons.notifications,
                  color: Theme.of(context).primaryIconTheme.color,
                ),
              ),
              Positioned(
                child: CircleAvatar(
                  maxRadius: 10,
                  backgroundColor: Colors.red.shade800,
                  child: Text(
                    '${Provider.of<ChatNotificationService>(context).itemsCount}',
                    style: TextStyle(fontSize: 12),
                  ),
                ),
              )
            ],
          )
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(child: Messages()),
            NewMessages(),
          ],
        ),
      ),
      /* floatingActionButton: FloatingActionButton(
        onPressed: () {
          Provider.of<ChatNotificationService>(context, listen: false)
              .add(ChatNotification(
            title: 'Mais uma notificação!',
            body: Random().nextDouble().toString(),
          ));
        },
        child: Icon(Icons.add),
      ), */
    );
  }
}
