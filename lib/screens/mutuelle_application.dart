import 'package:dynamic_form_generator/components/json_form_builder.dart';
import 'package:dynamic_form_generator/components/my_custom_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:dynamic_form_generator/provider/form_state_provider.dart';
import 'package:dynamic_form_generator/services/mutuelle_service.dart';

class MutuelleApplication extends StatefulWidget {
  const MutuelleApplication({super.key});

  @override
  State<MutuelleApplication> createState() => _MutuelleApplicationState();
}

class _MutuelleApplicationState extends State<MutuelleApplication> {
  final MutuelleService _mutuelleService = MutuelleService();
  List<Map<String, dynamic>>? formFields;
  bool isLoading = true;
  String? errorMessage;

  @override
  void initState() {
    super.initState();
    _loadFormFields();
  }

  Future<void> _loadFormFields() async {
    try {
      final fields = await _mutuelleService.fetchFormFields();
      setState(() {
        formFields = fields;
        isLoading = false;
      });
    } catch (error) {
      setState(() {
        errorMessage = error.toString();
        isLoading = false;
      });
    }
  }

  Future<void> _handlePayment(FormStateProvider formProvider) async {
    try {
      await _mutuelleService.processPayment(formProvider.formData);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Payment successful!'),
            backgroundColor: Colors.green,
          ),
        );
        formProvider.clearFormData();
      }
    } catch (error) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(error.toString()),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => FormStateProvider(),
      child: Scaffold(
        appBar: _buildAppBar(),
        body: _buildBody(),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      title: const Text('Mutuelle de santé'),
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

  Widget _buildBody() {
    return Padding(
      padding: const EdgeInsets.all(25),
      child: isLoading
          ? const Center(child: CircularProgressIndicator())
          : errorMessage != null
              ? Center(child: Text(errorMessage!))
              : _buildFormContent(),
    );
  }

  Widget _buildFormContent() {
    return Consumer<FormStateProvider>(
      builder: (context, formProvider, child) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeader(),
            JsonFormBuilder(
              jsonFields: formFields!,
              onSubmit: (data) {},
            ),
            const SizedBox(height: 20),
            _buildPaymentSection(),
            const SizedBox(height: 20),
            _buildPaymentButton(formProvider),
          ],
        );
      },
    );
  }

  Widget _buildHeader() {
    return const Padding(
      padding: EdgeInsets.only(bottom: 20),
      child: Text(
        'Provide the following details',
        style: TextStyle(
          fontSize: 16,
          color: Color(0xFF666666),
          fontWeight: FontWeight.normal,
        ),
        textAlign: TextAlign.start,
      ),
    );
  }

  Widget _buildPaymentSection() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 50),
      child: Row(
        children: [
          const Text.rich(
            TextSpan(
              children: [
                TextSpan(
                  text: "Pay with: ",
                  style: TextStyle(
                    fontSize: 16,
                    color: Color(0xFF666666),
                    fontWeight: FontWeight.normal,
                  ),
                ),
                TextSpan(
                  text: "0780 000 000",
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 10),
          TextButton(
            onPressed: () => Navigator.pushNamed(context, "/paymentMethods"),
            style: TextButton.styleFrom(
              foregroundColor: Colors.purple,
              textStyle: const TextStyle(
                fontSize: 16,
                decoration: TextDecoration.underline,
                decorationColor: Colors.purple,
              ),
            ),
            child: const Text("Edit"),
          ),
        ],
      ),
    );
  }

  Widget _buildPaymentButton(FormStateProvider formProvider) {
    final amount = formProvider.getFieldValue('ammountToPay');
    return MyCustomButton(
      text: amount != null ? "Pay $amount Rwf" : "Pay",
      onPressed: amount != null ? () => _handlePayment(formProvider) : null,
      backgroundColor: amount != null ? Colors.purple : Colors.grey,
    );
  }
}
