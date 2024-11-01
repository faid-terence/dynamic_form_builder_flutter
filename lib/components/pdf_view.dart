import 'package:dynamic_form_generator/components/app_bar.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class PdfViewTerence extends StatefulWidget {
  const PdfViewTerence({super.key});

  @override
  State<PdfViewTerence> createState() => _PdfViewTerenceState();
}

class _PdfViewTerenceState extends State<PdfViewTerence> {
  bool _isFullView = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: "PDF Viewer",
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            GestureDetector(
              onTap: _isFullView
                  ? () {
                      setState(() {
                        _isFullView = false;
                      });
                    }
                  : null,
              child: Builder(builder: (context) {
                return Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25),
                  ),
                  child: Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25),
                    ),
                    height: _isFullView
                        ? MediaQuery.of(context).size.height - 100
                        : 300,
                    child: SfPdfViewer.asset(
                      "assets/images/cert.pdf",
                      enableDoubleTapZooming: _isFullView,
                      initialZoomLevel: _isFullView ? 1 : 0.75,
                    ),
                  ),
                );
              }),
            ),
            if (!_isFullView)
              TextButton(
                onPressed: () {
                  setState(() {
                    _isFullView = true;
                  });
                },
                style: TextButton.styleFrom(
                  minimumSize: const Size(double.infinity, 50),
                  padding:
                      const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
                child: Row(
                  children: [
                    Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color:
                            Colors.purple.shade100, // Light purple background
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        FontAwesomeIcons.filePdf,
                        color: Colors.purple, // Purple icon color
                      ),
                    ),
                    const SizedBox(width: 12), // Space between icon and text
                    const Expanded(
                      child: Text(
                        "Birth certificate/01/2024.pdf",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          color: Colors.black87,
                        ),
                      ),
                    ),
                  ],
                ),
              )
          ],
        ),
      ),
    );
  }
}
