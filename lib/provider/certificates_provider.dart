import 'package:dynamic_form_generator/models/certificate.dart';
import 'package:flutter/material.dart';

class CertificatesProvider extends ChangeNotifier {
  List<Certificate> certificates = [
    Certificate(
      title: "Birth Certificate",
      imagePath: "assets/images/birthcert.png",
      description: "Click here to view it",
      pdfPath: "assets/images/cert.pdf",
    ),
    Certificate(
      title: "Marriage Certificate",
      imagePath: "assets/images/marriagecert.png",
      description: "usually available within 1 day",
      pdfPath: "assets/pdf/marriagecert.pdf",
    ),
    Certificate(
      title: "Certificate of being single",
      imagePath: "assets/images/single.png",
      description: "Looks like you re already off the market",
      pdfPath: "assets/pdf/single.pdf",
    ),
  ];

  // get certificates
  List<Certificate> getCertificates() {
    return certificates;
  }

  int? currentCertificateIndex;

  void setCurrentCertificateIndex(int index) {
    currentCertificateIndex = index;
    notifyListeners();
  }
}
