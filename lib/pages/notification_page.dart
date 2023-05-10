import 'package:flutter/material.dart';
import 'package:projeto_chat/core/services/notification/push_notification_service.dart';
import 'package:provider/provider.dart';

class NotificationPage extends StatelessWidget {
  const NotificationPage({super.key});

  @override
  Widget build(BuildContext context) {
    final service = Provider.of<ChatNotificationService>(context);
    final items = service.items;
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).primaryColor,
          iconTheme: IconThemeData(color: Colors.white),
          title: Text(
            'Minhas notificações',
            style: TextStyle(color: Colors.white),
          ),
        ),
        body: ListView.builder(
          itemCount: service.itemsCount,
          itemBuilder: (ctx, i) => ListTile(
            title: Text(items[i].title),
            subtitle: Text(items[i].body),
            onTap: () => service.remove(i),
          ),
        ));
  }
}
