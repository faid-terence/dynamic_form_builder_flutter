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
        padding: const EdgeInsets.all(16),
        child: Card(
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25),
          ),
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
                child: ClipRRect(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(25),
                    topRight: Radius.circular(25),
                  ),
                  child: SizedBox(
                    height: _isFullView
                        ? MediaQuery.of(context).size.height - 100
                        : 300,
                    child: SfPdfViewer.asset(
                      "assets/images/cert.pdf",
                      enableDoubleTapZooming: _isFullView,
                      initialZoomLevel: _isFullView ? 1 : 0.75,
                    ),
                  ),
                ),
              ),
              if (!_isFullView)
                Container(
                  decoration: BoxDecoration(
                    border: Border(
                      top: BorderSide(
                        color: Colors.grey.shade200,
                        width: 1,
                      ),
                    ),
                  ),
                  child: TextButton(
                    onPressed: () {
                      setState(() {
                        _isFullView = true;
                      });
                    },
                    style: TextButton.styleFrom(
                      minimumSize: const Size(double.infinity, 50),
                      padding: const EdgeInsets.symmetric(
                          vertical: 12, horizontal: 16),
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(25),
                          bottomRight: Radius.circular(25),
                        ),
                      ),
                    ),
                    child: Row(
                      children: [
                        Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            color: Colors.purple.shade100,
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            FontAwesomeIcons.filePdf,
                            color: Colors.purple,
                          ),
                        ),
                        const SizedBox(width: 12),
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
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
