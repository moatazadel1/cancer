// // import 'dart:io';
// // import 'package:path_provider/path_provider.dart';
// // import 'package:pdf/pdf.dart';
// // import 'package:pdf/widgets.dart' as pw;
// // import 'package:printing/printing.dart';
// //
// // Future<File> createPdf(String userName, String title, String safetyStatus,
// //     List<String> details, String percentage) async {
// //   final pdf = pw.Document();
// //
// //   pdf.addPage(
// //     pw.Page(
// //       build: (pw.Context context) => pw.Column(
// //         children: [
// //           pw.Text(userName,
// //               style:
// //                   pw.TextStyle(fontSize: 24, fontWeight: pw.FontWeight.bold)),
// //           pw.SizedBox(height: 10),
// //           pw.Text(title,
// //               style:
// //                   pw.TextStyle(fontSize: 20, fontWeight: pw.FontWeight.bold)),
// //           pw.SizedBox(height: 10),
// //           pw.Text(safetyStatus,
// //               style: const pw.TextStyle(fontSize: 16, color: PdfColors.green)),
// //           pw.SizedBox(height: 10),
// //           ...details.map((detail) => pw.Bullet(text: detail)),
// //           pw.SizedBox(height: 20),
// //           pw.Text(percentage,
// //               style: pw.TextStyle(
// //                   fontSize: 24,
// //                   fontWeight: pw.FontWeight.bold,
// //                   color: PdfColors.green)),
// //         ],
// //       ),
// //     ),
// //   );
// //   await Printing.layoutPdf(
// //     onLayout: (PdfPageFormat format) async => pdf.save(),
// //   );
// //   final output = await getTemporaryDirectory();
// //   final file = File("${output.path}/report.pdf");
// //   await file.writeAsBytes(await pdf.save());
// //
// //   return file;
// // }
//
// import 'dart:convert';
// import 'dart:io';
// import 'package:flutter/cupertino.dart';
// import 'package:pdf/pdf.dart';
// import 'package:pdf/widgets.dart' as pw;
// import 'package:path_provider/path_provider.dart';
// import 'package:printing/printing.dart';
//
// Future<File> createPdf(
//     String userName,
//     // String title,
//     // String safetyStatus,
//     // List<String> details,
//     // String percentage,
//     String base64Image,
//     ) async {
//   final pdf = pw.Document();
//
//   final image = pw.MemoryImage(
//     base64Decode(base64Image.split(',')[1]),
//   );
//
//   pdf.addPage(
//     pw.Page(
//       build: (pw.Context context) {
//         return pw.Column(
//
//           children: [
//
//             pw.Text(userName,
//                 style:
//                 pw.TextStyle(fontSize: 24, fontWeight: pw.FontWeight.bold)),
//             pw.SizedBox(height: 10),
//             pw.Image(image),
//             pw.SizedBox(height: 10),
//             // pw.Text(title,
//             //     style:
//             //     pw.TextStyle(fontSize: 20, fontWeight: pw.FontWeight.bold)),
//             // pw.SizedBox(height: 10),
//             // pw.Text(safetyStatus,
//             //     style: const pw.TextStyle(fontSize: 16, color: PdfColors.green)),
//             // pw.SizedBox(height: 10),
//             // ...details.map((detail) => pw.Bullet(text: detail)),
//             // pw.SizedBox(height: 20),
//             // pw.Text(percentage,
//             //     style: pw.TextStyle(
//             //         fontSize: 24,
//             //         fontWeight: pw.FontWeight.bold,
//             //         color: PdfColors.green)),
//
//           ],
//         );
//       },
//     ),
//   );
//   await Printing.layoutPdf(
//     onLayout: (PdfPageFormat format) async => pdf.save(),
//   );
//
//   final output = await getTemporaryDirectory();
//   final file = File("${output.path}/example.pdf");
//   await file.writeAsBytes(await pdf.save());
//   return file;
// }

import 'dart:convert';
import 'dart:io';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:path_provider/path_provider.dart';
import 'package:printing/printing.dart';

Future<File> createPdf(
  String userName,
  String base64Image,
) async {
  final pdf = pw.Document();

  final image = pw.MemoryImage(
    base64Decode(base64Image.split(',')[1]),
  );

  pdf.addPage(
    pw.Page(
      build: (pw.Context context) {
        return pw.Center(
          child: pw.Column(
            mainAxisAlignment: pw.MainAxisAlignment.center,
            children: [
              pw.Text(userName,
                  style: pw.TextStyle(
                      fontSize: 24, fontWeight: pw.FontWeight.bold)),
              pw.SizedBox(height: 10),
              pw.Image(image),
              pw.SizedBox(height: 10),
            ],
          ),
        );
      },
    ),
  );

  await Printing.layoutPdf(
    onLayout: (PdfPageFormat format) async => pdf.save(),
  );

  final output = await getTemporaryDirectory();
  final file = File("${output.path}/example.pdf");
  await file.writeAsBytes(await pdf.save());
  return file;
}
