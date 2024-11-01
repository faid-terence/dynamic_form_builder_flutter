import 'package:dynamic_form_generator/components/app_bar.dart';
import 'package:dynamic_form_generator/components/pdf_view.dart';
import 'package:flutter/material.dart';

class ViewCertificates extends StatelessWidget {
  final String fileName;
  final String pdfPath;
  const ViewCertificates(
      {super.key, required this.fileName, required this.pdfPath});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: fileName,
      ),
      body: SingleChildScrollView(
        child: PdfViewCard(
          fileName: fileName,
          pdfPath: pdfPath,
        ),
      ),
    );
  }
}
