import 'dart:io';
import 'package:flutter/material.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:path_provider/path_provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fluttertoast/fluttertoast.dart';

class EditPdfScreen extends StatefulWidget {
  final String patientId;

  const EditPdfScreen({Key? key, required this.patientId}) : super(key: key);

  @override
  _EditPdfScreenState createState() => _EditPdfScreenState();
}

class _EditPdfScreenState extends State<EditPdfScreen> {
  late TextEditingController _additionalNotesController;
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
      final doc = await FirebaseFirestore.instance.collection('patients').doc(widget.patientId).get();
      if (doc.exists) {
        setState(() {
          patientData = doc.data()!;
          isLoading = false;
        });
      } else {
        setState(() {
          isLoading = false;
        });
        Fluttertoast.showToast(
          msg: "Patient data not found",
          toastLength: Toast.LENGTH_SHORT,
          textColor: Colors.white,
        );
      }
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      Fluttertoast.showToast(
        msg: "Error fetching patient data",
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
    final pdf = pw.Document();

    pdf.addPage(
      pw.Page(
        build: (pw.Context context) => pw.Column(
          children: [
            pw.Text(patientData['userName'] ?? '',
                style: pw.TextStyle(fontSize: 24, fontWeight: pw.FontWeight.bold)),
            pw.SizedBox(height: 10),
            pw.Text(patientData['title'] ?? '',
                style: pw.TextStyle(fontSize: 20, fontWeight: pw.FontWeight.bold)),
            pw.SizedBox(height: 10),
            pw.Text(patientData['safetyStatus'] ?? '',
                style: pw.TextStyle(fontSize: 16, color: PdfColors.green)),
            pw.SizedBox(height: 10),
            ...?patientData['details']?.map((detail) => pw.Bullet(text: detail)).toList(),
            pw.SizedBox(height: 20),
            pw.Text(patientData['percentage'] ?? '',
                style: pw.TextStyle(fontSize: 24, fontWeight: pw.FontWeight.bold, color: PdfColors.green)),
            pw.SizedBox(height: 20),
            pw.Text('Additional Notes:', style: pw.TextStyle(fontSize: 18, fontWeight: pw.FontWeight.bold)),
            pw.Text(_additionalNotesController.text),
          ],
        ),
      ),
    );

    final output = await getTemporaryDirectory();
    final file = File("${output.path}/updated_patient_report.pdf");
    await file.writeAsBytes(await pdf.save());

    await FirebaseFirestore.instance.collection('patients').doc(widget.patientId).update({
      'pdfPath': file.path,
      'additionalNotes': _additionalNotesController.text,
    });

    Fluttertoast.showToast(
      msg: "PDF updated and sent to patient",
      toastLength: Toast.LENGTH_SHORT,
      textColor: Colors.white,
    );

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Edit PDF')),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Text('Patient: ${patientData['userName']}'),
              SizedBox(height: 20),
              Text('Title: ${patientData['title']}'),
              SizedBox(height: 20),
              Text('Safety Status: ${patientData['safetyStatus']}'),
              SizedBox(height: 20),
              Text('Details: ${patientData['details']?.join(", ")}'),
              SizedBox(height: 20),
              Text('Percentage: ${patientData['percentage']}'),
              SizedBox(height: 20),
              TextField(
                controller: _additionalNotesController,
                decoration: InputDecoration(labelText: 'Additional Notes'),
                maxLines: 5,
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _updatePdf,
                child: Text('Update PDF'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
