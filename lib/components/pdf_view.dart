import 'package:dynamic_form_generator/components/app_bar.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class PdfViewCard extends StatelessWidget {
  final String pdfPath;
  final String fileName;
  final double previewHeight;
  final String? viewerTitle;
  final Color? iconColor;
  final Color? iconBackgroundColor;
  final double borderRadius;
  final double elevation;

  const PdfViewCard({
    super.key,
    required this.pdfPath,
    required this.fileName,
    this.previewHeight = 300,
    this.viewerTitle = 'PDF Viewer',
    this.iconColor = Colors.purple,
    this.iconBackgroundColor,
    this.borderRadius = 25,
    this.elevation = 2,
  });

  void _openPdfViewer(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => Scaffold(
          appBar: AppBar(
            title: Text(viewerTitle!),
            leading: IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () => Navigator.pop(context),
            ),
          ),
          body: SfPdfViewer.asset(
            pdfPath,
            enableDoubleTapZooming: true,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(borderRadius),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          children: [
            GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: () => _openPdfViewer(context),
              child: ClipRRect(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(borderRadius),
                  topRight: Radius.circular(borderRadius),
                ),
                child: SizedBox(
                  height: previewHeight,
                  child: SfPdfViewer.asset(
                    pdfPath,
                    enableDoubleTapZooming: false,
                    initialZoomLevel: 0.75,
                  ),
                ),
              ),
            ),
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
                onPressed: () => _openPdfViewer(context),
                style: TextButton.styleFrom(
                  minimumSize: const Size(double.infinity, 50),
                  padding:
                      const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(borderRadius),
                      bottomRight: Radius.circular(borderRadius),
                    ),
                  ),
                ),
                child: Row(
                  children: [
                    Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color:
                            iconBackgroundColor ?? iconColor?.withOpacity(0.1),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        FontAwesomeIcons.filePdf,
                        color: iconColor,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        fileName,
                        style: const TextStyle(
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
    );
  }
}
