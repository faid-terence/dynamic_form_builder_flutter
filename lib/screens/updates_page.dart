import 'package:dynamic_form_generator/components/list_updates.dart';
import 'package:dynamic_form_generator/components/notification_render.dart';
import 'package:dynamic_form_generator/models/updates.dart';
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

          // Group updates by title
          final groupedUpdates = <String, List<dynamic>>{};
          for (var update in updates) {
            if (!groupedUpdates.containsKey(update.title)) {
              groupedUpdates[update.title] = [update, update.notificationCount];
            } else {
              groupedUpdates[update.title]![1] += update.notificationCount;
            }
          }

          return ListView.builder(
            itemCount: groupedUpdates.length,
            itemBuilder: (context, index) {
              final title = groupedUpdates.keys.elementAt(index);
              final update = groupedUpdates[title]![0] as Updates;
              final totalCount = groupedUpdates[title]![1];

              return ListUpdates(
                title: title,
                description: update.description,
                date: update.date,
                iconBackgroundColor: update.color,
                imagePath: update.imagePath,
                notificationCount: totalCount,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => NotificationRender(
                        title: title,
                        message: update.description,
                        date: update
                            .date, // Removed toString() since NotificationRender expects DateTime
                        hasToPay: update.hasToPay,
                        paymentLink: update.paymentLink ?? "",
                        onInfoPressed: () {},
                        onPayPressed: () {},
                      ),
                    ),
                  );
                  // set notification count to read permanently
                  provider.setNotificationCountByTitle(title, 0);
                },
              );
            },
          );
        },
      ),
    );
  }
}
