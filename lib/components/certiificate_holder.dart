import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'dart:io';

class CertificateHolder extends StatelessWidget {
  final String pdfPath;
  final String pdfName;

  const CertificateHolder({
    super.key,
    required this.pdfPath,
    required this.pdfName,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _openPdf(context, pdfPath),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: 150,
              height: 200,
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.3),
                    spreadRadius: 1,
                    blurRadius: 5,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: const Center(
                child: Icon(
                  Icons.picture_as_pdf,
                  size: 50,
                  color: Colors.red,
                ),
              ),
            ),
            const SizedBox(height: 12),
            Text(
              pdfName,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }

  void _openPdf(BuildContext context, String path) {
    if (File(path).existsSync()) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) =>
              PdfViewerScreen(pdfPath: path, pdfName: pdfName),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('PDF file not found'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }
}

class PdfViewerScreen extends StatefulWidget {
  final String pdfPath;
  final String pdfName;

  const PdfViewerScreen({
    super.key,
    required this.pdfPath,
    required this.pdfName,
  });

  @override
  State<PdfViewerScreen> createState() => _PdfViewerScreenState();
}

class _PdfViewerScreenState extends State<PdfViewerScreen> {
  bool _isLoading = true;
  int _totalPages = 0;
  int _currentPage = 0;
  PDFViewController? _pdfViewController;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.pdfName),
        actions: [
          if (!_isLoading)
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Center(
                child: Text(
                  'Page ${_currentPage + 1} of $_totalPages',
                  style: const TextStyle(fontSize: 16),
                ),
              ),
            ),
        ],
      ),
      body: Stack(
        children: [
          PDFView(
            filePath: widget.pdfPath,
            enableSwipe: true,
            swipeHorizontal: true,
            autoSpacing: false,
            pageFling: true,
            pageSnap: true,
            defaultPage: 0,
            fitPolicy: FitPolicy.BOTH,
            preventLinkNavigation: false,
            onRender: (pages) {
              setState(() {
                _totalPages = pages!;
                _isLoading = false;
              });
            },
            onError: (error) {
              setState(() => _isLoading = false);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(error.toString()),
                  backgroundColor: Colors.red,
                ),
              );
            },
            onPageError: (page, error) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Error loading page $page: $error'),
                  backgroundColor: Colors.red,
                ),
              );
            },
            onViewCreated: (PDFViewController pdfViewController) {
              _pdfViewController = pdfViewController;
            },
            onPageChanged: (int? page, int? total) {
              setState(() => _currentPage = page!);
            },
          ),
          if (_isLoading)
            const Center(
              child: CircularProgressIndicator(),
            ),
        ],
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          if (!_isLoading && _currentPage > 0)
            FloatingActionButton(
              heroTag: 'prev',
              onPressed: () {
                _pdfViewController?.setPage(_currentPage - 1);
              },
              child: const Icon(Icons.navigate_before),
            ),
          if (!_isLoading && _currentPage < _totalPages - 1) ...[
            const SizedBox(width: 16),
            FloatingActionButton(
              heroTag: 'next',
              onPressed: () {
                _pdfViewController?.setPage(_currentPage + 1);
              },
              child: const Icon(Icons.navigate_next),
            ),
          ],
        ],
      ),
    );
  }
}
