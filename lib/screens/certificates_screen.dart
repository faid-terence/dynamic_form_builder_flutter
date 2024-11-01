import 'package:dynamic_form_generator/components/app_bar.dart';
import 'package:dynamic_form_generator/components/list_of_certificates.dart';
import 'package:dynamic_form_generator/provider/certificates_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CertificatesScreen extends StatefulWidget {
  const CertificatesScreen({super.key});

  @override
  State<CertificatesScreen> createState() => _CertificatesScreenState();
}

class _CertificatesScreenState extends State<CertificatesScreen> {
  late final CertificatesProvider certificatesProvider;
  @override
  void initState() {
    super.initState();
    certificatesProvider =
        Provider.of<CertificatesProvider>(context, listen: false);
  }

  @override
  Widget build(BuildContext context) {
    final certificates = certificatesProvider.getCertificates();
    return Scaffold(
      appBar: const CustomAppBar(
        title: "My Certificates",
      ),
      body: ListView.builder(
        itemCount: certificates.length,
        itemBuilder: (context, index) => ListOfCertificates(
          title: certificates[index].title,
          imagePath: certificates[index].imagePath,
          subtitle: certificates[index].description,
          onTap: () {},
        ),
      ),
    );
  }
}
