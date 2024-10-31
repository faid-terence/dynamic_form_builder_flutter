import 'package:dynamic_form_generator/components/json_form_builder.dart';
import 'package:dynamic_form_generator/components/primary_button.dart';
import 'package:dynamic_form_generator/view_models/payment_methods_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PaymentMethods extends StatelessWidget {
  const PaymentMethods({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => PaymentMethodsViewModel()..loadPaymentMethods(),
      child: const PaymentMethodsView(),
    );
  }
}

class PaymentMethodsView extends StatelessWidget {
  const PaymentMethodsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(context),
      body: _buildBody(context),
    );
  }

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return AppBar(
      title: const Text('Payment Methods'),
      foregroundColor: Colors.black,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back_ios),
        onPressed: () => Navigator.pop(context),
      ),
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(1.0),
        child: Container(
          color: Colors.grey.shade300,
          height: 1.0,
        ),
      ),
    );
  }

  Widget _buildBody(BuildContext context) {
    return Consumer<PaymentMethodsViewModel>(
      builder: (context, viewModel, child) {
        if (viewModel.isLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        if (viewModel.errorMessage != null) {
          return Center(child: Text(viewModel.errorMessage!));
        }

        return Padding(
          padding: const EdgeInsets.all(25),
          child: Column(
            children: [
              _buildForm(viewModel),
              const Text(
                "This is the number that will be used to pay. It can be MTN or Airtel Mobile Money",
              ),
              const SizedBox(height: 40),
              _buildSaveButton(context, viewModel),
            ],
          ),
        );
      },
    );
  }

  Widget _buildForm(PaymentMethodsViewModel viewModel) {
    return JsonFormBuilder(
      jsonFields: viewModel.formFields!,
      onSubmit: (data) {
        print(data);
      },
    );
  }

  Widget _buildSaveButton(
      BuildContext context, PaymentMethodsViewModel viewModel) {
    return PrimaryButton(
      text: "Save Number",
      onPressed: () => viewModel.saveNumber(context),
    );
  }
}
