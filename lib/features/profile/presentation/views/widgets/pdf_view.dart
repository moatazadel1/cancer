// import 'package:flutter/material.dart';
// import 'package:flutter_pdfview/flutter_pdfview.dart';
// import 'package:go_router/go_router.dart';

// class PdfView extends StatelessWidget {
//   const PdfView({super.key});

//   @override
//   Widget build(BuildContext context) {
//     // Retrieve the extra data (PDF path) from the GoRouter state
//     final state = GoRouterState.of(context);
//     final String? pdfPath = state.extra as String?;

//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('PDF Viewer'),
//       ),
//       body: pdfPath != null
//           ? PDFView(
//               filePath: pdfPath,
//             )
//           : const Center(
//               child: Text('No PDF file path provided'),
//             ),
//     );
//   }
// }

import 'dart:developer';
import 'package:breast_cancer/core/utils/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:go_router/go_router.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'package:provider/provider.dart';
import '../../../../../core/widgets/edit_info_screen.dart';
import '../../view_model/pdf_provider.dart';

class PdfView extends StatelessWidget {
  const PdfView({super.key});

  Future<void> _downloadPdf(String pdfPath) async {
    final directory = await getApplicationDocumentsDirectory();
    final newFilePath = '${directory.path}/downloaded_report.pdf';
    final file = File(pdfPath);
    final newFile = await file.copy(newFilePath);
    // Handle the newFile as needed, e.g., show a success message
    log('PDF saved at: $newFilePath');
  }

  @override
  Widget build(BuildContext context) {
    final pdfState = context.watch<PdfState>();
    final String? pdfPath = pdfState.pdfPath;

    return Scaffold(
      appBar: AppBar(
        title: const Text('PDF Viewer'),
      ),
      body: pdfPath != null
          ? Column(
              children: [
                Expanded(
                  child: PDFView(
                    filePath: pdfPath,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      onPressed: () async {
                        // Navigate to the EditInfoScreen and await the result
                        final result = await GoRouter.of(context).push<String>(
                          AppRoutes.kEditInfoView,
                          extra: EditInfoScreenArguments(
                            userName: pdfState.userName ?? "",
                            title: pdfState.title ?? "",
                            safetyStatus: pdfState.safetyStatus ?? "",
                            details: pdfState.details ?? [],
                            percentage: pdfState.percentage ?? "",
                          ),
                        );

                        if (result != null) {
                          // Update the PDF path in the state with the new path
                          await pdfState.setPdfPath(result);
                          // Refresh the view
                          GoRouter.of(context).refresh();
                        }
                      },
                      child: const Text('Edit'),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        // Download the PDF to the device
                        _downloadPdf(pdfPath);
                      },
                      child: const Text('Download'),
                    ),
                  ],
                ),
              ],
            )
          : const Center(
              child: Text('No PDF file path provided'),
            ),
    );
  }
}
