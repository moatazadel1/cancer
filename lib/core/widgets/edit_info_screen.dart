import 'package:flutter/material.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:path_provider/path_provider.dart';
import 'dart:io';

class EditInfoScreen extends StatefulWidget {
  final EditInfoScreenArguments args;

  const EditInfoScreen({super.key, required this.args});

  @override
  _EditInfoScreenState createState() => _EditInfoScreenState();
}

class _EditInfoScreenState extends State<EditInfoScreen> {
  late TextEditingController _userNameController;
  late TextEditingController _titleController;
  late TextEditingController _safetyStatusController;
  late List<TextEditingController> _detailsControllers;
  late TextEditingController _percentageController;

  @override
  void initState() {
    super.initState();
    _userNameController = TextEditingController(text: widget.args.userName);
    _titleController = TextEditingController(text: widget.args.title);
    _safetyStatusController =
        TextEditingController(text: widget.args.safetyStatus);
    _detailsControllers = widget.args.details
        .map((detail) => TextEditingController(text: detail))
        .toList();
    _percentageController = TextEditingController(text: widget.args.percentage);
  }

  @override
  void dispose() {
    _userNameController.dispose();
    _titleController.dispose();
    _safetyStatusController.dispose();
    for (var controller in _detailsControllers) {
      controller.dispose();
    }
    _percentageController.dispose();
    super.dispose();
  }

  Future<void> _createPdf() async {
    final pdf = pw.Document();

    pdf.addPage(
      pw.Page(
        build: (pw.Context context) => pw.Column(
          children: [
            pw.Text(_userNameController.text,
                style:
                    pw.TextStyle(fontSize: 24, fontWeight: pw.FontWeight.bold)),
            pw.SizedBox(height: 10),
            pw.Text(_titleController.text,
                style:
                    pw.TextStyle(fontSize: 20, fontWeight: pw.FontWeight.bold)),
            pw.SizedBox(height: 10),
            pw.Text(_safetyStatusController.text,
                style:
                    const pw.TextStyle(fontSize: 16, color: PdfColors.green)),
            pw.SizedBox(height: 10),
            ..._detailsControllers
                .map((controller) => pw.Bullet(text: controller.text)),
            pw.SizedBox(height: 20),
            pw.Text(_percentageController.text,
                style: pw.TextStyle(
                    fontSize: 24,
                    fontWeight: pw.FontWeight.bold,
                    color: PdfColors.green)),
          ],
        ),
      ),
    );

    final output = await getTemporaryDirectory();
    final file = File("${output.path}/edited_report.pdf");
    await file.writeAsBytes(await pdf.save());

    // Update the state with the new PDF path
    if (!mounted) return;
    Navigator.pop(context, file.path);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Information'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              TextField(
                controller: _userNameController,
                decoration: const InputDecoration(labelText: 'User Name'),
              ),
              TextField(
                controller: _titleController,
                decoration: const InputDecoration(labelText: 'Title'),
              ),
              TextField(
                controller: _safetyStatusController,
                decoration: const InputDecoration(labelText: 'Safety Status'),
              ),
              ..._detailsControllers.map((controller) => TextField(
                    controller: controller,
                    decoration: const InputDecoration(labelText: 'Detail'),
                  )),
              TextField(
                controller: _percentageController,
                decoration: const InputDecoration(labelText: 'Percentage'),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _createPdf,
                child: const Text('Update PDF'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class EditInfoScreenArguments {
  final String userName;
  final String title;
  final String safetyStatus;
  final List<String> details;
  final String percentage;

  EditInfoScreenArguments({
    required this.userName,
    required this.title,
    required this.safetyStatus,
    required this.details,
    required this.percentage,
  });
}
