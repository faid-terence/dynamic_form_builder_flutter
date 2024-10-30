import 'package:dynamic_form_generator/components/list_of_payments.dart';
import 'package:flutter/material.dart';

class UserPayments extends StatelessWidget {
  const UserPayments({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Payment Methods'),
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
      body: ListOfPayments(
        number: '1. ',
        phoneNumber: '0780 000 000',
        onPressed: () {
          Navigator.pushNamed(context, '/paymentMethods');
        },
      ),
    );
  }
}
