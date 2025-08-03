import 'dart:io';

import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class PDFViewScreen extends StatefulWidget {
 final File  pdfFile;
   PDFViewScreen({super.key,required this.pdfFile});

  @override
  State<PDFViewScreen> createState() => _PDFViewScreenState();
}

class _PDFViewScreenState extends State<PDFViewScreen> {
  @override
   
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(title: const Text("Your PDF Summary")),
      body: SfPdfViewer.file(widget.pdfFile),
    );
  }
}