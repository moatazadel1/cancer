import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PdfState extends ChangeNotifier {
  String? _userName;
  String? _title;
  String? _safetyStatus;
  List<String>? _details;
  String? _percentage;
  String? _pdfPath;
  String? _patientId; // Add the patientId field

  PdfState({
    String? userName,
    String? title,
    String? safetyStatus,
    List<String>? details,
    String? percentage,
    String? pdfPath,
    String? patientId, // Include patientId in the constructor
  })  : _userName = userName,
        _title = title,
        _safetyStatus = safetyStatus,
        _details = details,
        _percentage = percentage,
        _pdfPath = pdfPath,
        _patientId = patientId;

  String? get userName => _userName;
  String? get title => _title;
  String? get safetyStatus => _safetyStatus;
  List<String>? get details => _details;
  String? get percentage => _percentage;
  String? get pdfPath => _pdfPath;
  String? get patientId => _patientId; // Add the getter for patientId

  Future<void> setPdfPath(String path) async {
    _pdfPath = path;
    notifyListeners();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('pdfPath', path);
  }

  Future<void> loadPdfPath() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _pdfPath = prefs.getString('pdfPath');
    notifyListeners();
  }

  void updatePdfData({
    required String userName,
    required String title,
    required String safetyStatus,
    required List<String> details,
    required String percentage,
  }) {
    _userName = userName;
    _title = title;
    _safetyStatus = safetyStatus;
    _details = details;
    _percentage = percentage;
    notifyListeners();
  }

  // Add a method to set the patientId
  void setPatientId(String patientId) {
    _patientId = patientId;
    notifyListeners();
  }
}
