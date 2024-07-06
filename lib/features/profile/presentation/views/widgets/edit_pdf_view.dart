import 'dart:convert';
import 'dart:io';
import 'package:breast_cancer/core/widgets/custom_button.dart';
import 'package:breast_cancer/core/widgets/custom_text_field.dart';
import 'package:breast_cancer/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:path_provider/path_provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../../../../core/utils/app_assets.dart';

class EditPdfScreen extends StatefulWidget {
  final String patientId;

  const EditPdfScreen({super.key, required this.patientId});

  @override
  _EditPdfScreenState createState() => _EditPdfScreenState();
}

class _EditPdfScreenState extends State<EditPdfScreen> {
  late TextEditingController _additionalNotesController;
  final _formKey = GlobalKey<FormState>();
  Map<String, dynamic> patientData = {};
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _additionalNotesController = TextEditingController();
    _fetchPatientData();
  }

  Future<void> _fetchPatientData() async {
    try {
      final doc = await FirebaseFirestore.instance
          .collection('patients')
          .doc(widget.patientId)
          .get();
      if (doc.exists) {
        setState(() {
          patientData = doc.data()!;
          isLoading = false;
        });
      } else {
        setState(() {
          isLoading = false;
        });
        if (!mounted) return;
        Fluttertoast.showToast(
          msg: S.of(context).Patientdatanotfound,
          toastLength: Toast.LENGTH_SHORT,
          textColor: Colors.white,
        );
      }
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      if (!mounted) return;

      Fluttertoast.showToast(
        msg: S.of(context).Errorfetchingpatientdata,
        toastLength: Toast.LENGTH_SHORT,
        textColor: Colors.white,
      );
    }
  }

  @override
  void dispose() {
    _additionalNotesController.dispose();
    super.dispose();
  }

  Future<void> _updatePdf() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    final pdf = pw.Document();
    final additionalNotesLabel =
        S.of(context).AdditionalNotesss; // Extracted here

    pdf.addPage(
      pw.Page(
        build: (pw.Context context) => pw.Column(
          children: [
            pw.Text(patientData['userName'] ?? '',
                style:
                    pw.TextStyle(fontSize: 24, fontWeight: pw.FontWeight.bold)),
            pw.SizedBox(height: 10),
            pw.Text(patientData['title'] ?? '',
                style:
                    pw.TextStyle(fontSize: 20, fontWeight: pw.FontWeight.bold)),
            pw.SizedBox(height: 10),
            pw.Text(patientData['safetyStatus'] ?? '',
                style:
                    const pw.TextStyle(fontSize: 16, color: PdfColors.green)),
            pw.SizedBox(height: 10),
            ...?patientData['details']
                ?.map((detail) => pw.Bullet(text: detail))
                .toList(),
            pw.SizedBox(height: 20),
            pw.Text(patientData['percentage'] ?? '',
                style: pw.TextStyle(
                    fontSize: 24,
                    fontWeight: pw.FontWeight.bold,
                    color: PdfColors.green)),
            pw.SizedBox(height: 20),
            pw.Text(additionalNotesLabel,
                style:
                    pw.TextStyle(fontSize: 18, fontWeight: pw.FontWeight.bold)),
            pw.Text(_additionalNotesController.text),
          ],
        ),
      ),
    );

    final output = await getTemporaryDirectory();
    final file = File("${output.path}/updated_patient_report.pdf");
    await file.writeAsBytes(await pdf.save());

    await FirebaseFirestore.instance
        .collection('patients')
        .doc(widget.patientId)
        .update({
      'pdfPath': file.path,
      'additionalNotes': _additionalNotesController.text,
    });

    Fluttertoast.showToast(
      msg: S.of(context).PDFupdatedandsenttopatient,
      toastLength: Toast.LENGTH_SHORT,
      textColor: Colors.white,
    );

    Navigator.pop(context);
  }

  String getBase64String(String dataUrl) {
    final startIndex = dataUrl.indexOf('base64,') + 7;
    return dataUrl.substring(startIndex);
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.sizeOf(context).height;
    return Scaffold(
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: Column(
                children: [
                  Stack(
                    children: [
                      SizedBox(
                        height: height * 0.34,
                        width: double.infinity,
                        child: Image.asset(
                          AppAssets.rectangleImg,
                          fit: BoxFit.fill,
                        ),
                      ),
                      Positioned(
                        height: kToolbarHeight + 32,
                        left: 5,
                        right: 5,
                        child: Row(
                          children: [
                            IconButton(
                              padding: EdgeInsets.zero,
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              icon: const Icon(
                                Icons.arrow_back_ios_new,
                                color: Colors.white,
                                size: 15,
                              ),
                            ),
                            Text(
                              S.of(context).Patientinformation,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 25,
                                fontFamily: 'Montserrat',
                                fontWeight: FontWeight.w600,
                                height: 0,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        left: 0,
                        child: SizedBox(
                          width: 120,
                          height: 120,
                          child: Image.asset(AppAssets.pictureImg),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    patientData['userName'] ?? "",
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 22,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    '${patientData['userEmail']} | ${patientData['contactNumber']}',
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 14,
                      fontFamily: 'Roboto',
                      fontWeight: FontWeight.w400,
                      letterSpacing: 0.25,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Text(
                      S.of(context).Informationaboutthediseaseee,
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontFamily: 'Roboto',
                        fontWeight: FontWeight.w400,
                        height: 0.10,
                        letterSpacing: 0.25,
                      ),
                    ),
                  ),
                  const SizedBox(height: 23),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 40),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          S.of(context).XRay,
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 14,
                            fontFamily: 'Roboto',
                            fontWeight: FontWeight.w400,
                            height: 0.10,
                            letterSpacing: 0.25,
                          ),
                        ),
                        const SizedBox(height: 15),
                        if (patientData['imageUrl'] != null)
                          Image.memory(
                            base64Decode(
                                getBase64String(patientData['imageUrl'])),
                            height: 100,
                            width: 123,
                            fit: BoxFit.cover,
                          ),
                        const SizedBox(height: 20),
                        // Text('Type: ${patientData['title']}'),
                        // const SizedBox(height: 20),
                        // Text('Status: ${patientData['safetyStatus']}'),
                        // const SizedBox(height: 20),
                        // Text('Details: ${patientData['details']?.join(", ")}'),
                        // const SizedBox(height: 20),
                        // Text('Percentage: ${patientData['percentage']}'),
                        // const SizedBox(height: 5),
                        Form(
                          key: _formKey,
                          child: CustomTextField(
                            maxLines: 5,
                            controller: _additionalNotesController,
                            labelText: S.of(context).AdditionalNotes,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return S
                                    .of(context)
                                    .Pleaseenteranadditionalnotes;
                              } else if (value.length < 10) {
                                return S
                                    .of(context)
                                    .Notesmustbeatleast10characterslong;
                              }
                              return null;
                            },
                          ),
                        ),
                        const SizedBox(height: 20),
                        Center(
                          child: CustomButton(
                            title: S.of(context).Updateinformation,
                            onTap: _updatePdf,
                          ),
                        ),
                        const SizedBox(height: 20),
                      ],
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
