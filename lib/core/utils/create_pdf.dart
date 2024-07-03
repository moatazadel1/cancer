import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

Future<File> createPdf(String userName, String title, String safetyStatus,
    List<String> details, String percentage) async {
  final pdf = pw.Document();

  pdf.addPage(
    pw.Page(
      build: (pw.Context context) => pw.Column(
        children: [
          pw.Text(userName,
              style:
                  pw.TextStyle(fontSize: 24, fontWeight: pw.FontWeight.bold)),
          pw.SizedBox(height: 10),
          pw.Text(title,
              style:
                  pw.TextStyle(fontSize: 20, fontWeight: pw.FontWeight.bold)),
          pw.SizedBox(height: 10),
          pw.Text(safetyStatus,
              style: const pw.TextStyle(fontSize: 16, color: PdfColors.green)),
          pw.SizedBox(height: 10),
          ...details.map((detail) => pw.Bullet(text: detail)),
          pw.SizedBox(height: 20),
          pw.Text(percentage,
              style: pw.TextStyle(
                  fontSize: 24,
                  fontWeight: pw.FontWeight.bold,
                  color: PdfColors.green)),
        ],
      ),
    ),
  );
  await Printing.layoutPdf(
    onLayout: (PdfPageFormat format) async => pdf.save(),
  );
  final output = await getTemporaryDirectory();
  final file = File("${output.path}/report.pdf");
  await file.writeAsBytes(await pdf.save());

  return file;
}
