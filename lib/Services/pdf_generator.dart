import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:flutter/material.dart';
import 'package:open_file/open_file.dart';

Future<String> generateAndOpenPDF(BuildContext context, String title, String content) async {
  final pdf = pw.Document();

  pdf.addPage(
    pw.Page(
      build: (context) => pw.Column(
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: [
          pw.Text(
            title,
            style: pw.TextStyle(fontSize: 24, fontWeight: pw.FontWeight.bold),
          ),
          pw.SizedBox(height: 16),
          pw.Text(
            content,
            style: pw.TextStyle(fontSize: 14),
          ),
        ],
      ),
    ),
  );

  final dir = await getApplicationDocumentsDirectory();
  final file = File("${dir.path}/summary.pdf");
  await file.writeAsBytes(await pdf.save());

  print("✅ Step 3 done: PDF saved at ${file.path}");

  final result = await OpenFile.open(file.path);
  print("📂 OpenFile result: ${result.toString()} - ${result.message}");

  return file.path;
}
