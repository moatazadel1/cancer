import 'dart:developer';
import 'dart:typed_data';
import 'package:firebase_storage/firebase_storage.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';

Future<void> uploadPdf(String pdfName, Uint8List pdfData) async {
  final tempDir = await getTemporaryDirectory();
  final file = File('${tempDir.path}/$pdfName.pdf');
  await file.writeAsBytes(pdfData);

  final storageRef = FirebaseStorage.instance.ref().child('pdfs/$pdfName.pdf');
  await storageRef.putFile(file);

  final downloadUrl = await storageRef.getDownloadURL();
  log('Download URL: $downloadUrl');
}
