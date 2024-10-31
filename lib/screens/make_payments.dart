import 'package:dynamic_form_generator/components/list_of_serives.dart';
import 'package:dynamic_form_generator/provider/services_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MakePayments extends StatefulWidget {
  const MakePayments({super.key});

  @override
  State<MakePayments> createState() => _MakePaymentsState();
}

class _MakePaymentsState extends State<MakePayments> {
  late final dynamic serviceProvider;
  @override
  void initState() {
    super.initState();
    serviceProvider = Provider.of<ServicesProvider>(context, listen: false);
  }

  void goToServiceScreen(int index) {
    serviceProvider.setCurrentServiceIndex(index);
    Navigator.pushNamed(context, "/mutuelle");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Make a payment'),
        foregroundColor: Colors.black,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1.0),
          child: Container(
            color: Colors.grey.shade300,
            height: 1.0,
          ),
        ),
      ),
      body: Consumer<ServicesProvider>(builder: (context, provider, child) {
        return ListView.builder(
          itemCount: provider.getServices().length,
          itemBuilder: (context, index) => ListOfSerives(
            title: provider.getServices()[index].title,
            color: provider.getServices()[index].color,
            imagePath: provider.getServices()[index].imagePath,
            onTap: () => goToServiceScreen(index),
          ),
        );
      }),
    );
  }
}
