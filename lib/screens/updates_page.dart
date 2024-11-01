import 'package:dynamic_form_generator/components/list_updates.dart';
import 'package:dynamic_form_generator/provider/updates_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UpdatesPage extends StatelessWidget {
  const UpdatesPage({super.key});

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
                // Handle the tap action here, e.g., navigate to details
              },
            ),
          );
        },
      ),
    );
  }
}
