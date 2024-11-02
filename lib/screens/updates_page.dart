import 'package:dynamic_form_generator/components/list_updates.dart';
import 'package:dynamic_form_generator/components/notification_render.dart';
import 'package:dynamic_form_generator/provider/updates_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UpdatesPage extends StatelessWidget {
  final int notificationCount;

  const UpdatesPage({super.key, required this.notificationCount});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Updates',
          style: TextStyle(fontSize: 33, fontWeight: FontWeight.bold),
        ),
        centerTitle: false,
        automaticallyImplyLeading: false,
      ),
      body: Consumer<UpdatesProvider>(
        builder: (context, provider, child) {
          final updates = provider.getUpdates();
          return ListView.builder(
            itemCount: updates.length,
            itemBuilder: (context, index) => ListUpdates(
              title: updates[index].title,
              description: updates[index].description,
              time: updates[index].time,
              iconBackgroundColor: updates[index].color,
              imagePath: updates[index].imagePath,
              notificationCount: updates[index].notificationCount,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => NotificationRender(
                      title: updates[index].title,
                      message: updates[index].description,
                      time: updates[index].time,
                      hasToPay: updates[index].hasToPay,
                      paymentLink: updates[index].paymentLink,
                      onInfoPressed: () {},
                      onPayPressed: () {},
                    ),
                  ),
                );
                // set notification count to read
                provider.setNotificationCount(index, 0);
              },
            ),
          );
        },
      ),
    );
  }
}
