import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:flutter/material.dart';
import 'package:sagar_new_project/Pages/pdf_view.dart';


Future<void> generateAndOpenPDF(BuildContext context, String text) async {
  final pdf = pw.Document();
  pdf.addPage(pw.Page(build: (context) => pw.Text(text)));

  // ✅ Step 1: Save as a file on device
  final dir = await getApplicationDocumentsDirectory();
  final file = File("${dir.path}/summary.pdf");
  await file.writeAsBytes(await pdf.save());

  // ✅ Step 2: Navigate to PDF viewer screen
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (_) => PDFViewScreen(pdfFile: file),
    ),
  );
}
