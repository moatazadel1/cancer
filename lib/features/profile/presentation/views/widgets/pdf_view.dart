import 'dart:developer';
import 'package:breast_cancer/core/utils/app_routes.dart';
import 'package:breast_cancer/core/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:go_router/go_router.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../../../../core/widgets/edit_info_screen.dart';
import '../../view_model/pdf_provider.dart';

class PdfView extends StatelessWidget {
  final String patientId;
  final String pdfPath;

  const PdfView({super.key, required this.patientId, required this.pdfPath});

  Future<void> _downloadPdf(String pdfPath) async {
    final directory = await getApplicationDocumentsDirectory();
    final newFilePath = '${directory.path}/downloaded_report.pdf';
    final file = File(pdfPath);
    final newFile = await file.copy(newFilePath);
    log('PDF saved at: $newFilePath');
  }

  @override
  Widget build(BuildContext context) {
    final pdfState = context.watch<PdfState>();

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text('Information'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          children: [
            Expanded(
              child: PDFView(
                enableSwipe: false,
                filePath: pdfPath,
              ),
            ),
            FutureBuilder<DocumentSnapshot>(
              future: FirebaseFirestore.instance.collection('patients').doc(patientId).get(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (!snapshot.hasData || snapshot.data == null || !snapshot.data!.exists) {
                  return const Center(child: Text('No additional notes found'));
                }
                final data = snapshot.data!.data() as Map<String, dynamic>;
                final additionalNotes = data['additionalNotes'] ?? 'No additional notes';
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 15.0),
                  child: Text('Doctor Notes: $additionalNotes'),
                );
              },
            ),
            Container(
              color: Colors.white,
              child: CustomButton(
                title: 'Download',
                onTap: () {
                  _downloadPdf(pdfPath);
                },
              ),
            ),
            const SizedBox(height: 20),
            CustomButton(
              title: 'Continue',
              onTap: () {
                Navigator.pop(context);
              },
            ),
            Expanded(
              child: Container(
                color: Colors.white,
                height: 100,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class PdfViewArguments {
  final String pdfPath;
  final String patientId;

  PdfViewArguments(this.pdfPath, this.patientId);
}
