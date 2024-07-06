import 'dart:developer';
import 'package:breast_cancer/core/utils/app_routes.dart';
import 'package:breast_cancer/core/widgets/custom_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:go_router/go_router.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../../../../core/utils/app_assets.dart';
import '../../../../../core/utils/app_methods.dart';
import '../../../../../core/widgets/edit_info_screen.dart';
import '../../../../../generated/l10n.dart';
import '../../../../authentication/model/user_model.dart';
import '../../view_model/pdf_provider.dart';

class PdfView extends StatefulWidget {
  final String patientId;
  final String pdfPath;
  final String userType;


  const PdfView({super.key, required this.patientId, required this.pdfPath, required this.userType});

  @override
  State<PdfView> createState() => _PdfViewState();
}

class _PdfViewState extends State<PdfView> {
  Future<void> _downloadPdf(String pdfPath) async {
    final directory = await getApplicationDocumentsDirectory();
    final newFilePath = '${directory.path}/downloaded_report.pdf';
    final file = File(pdfPath);
    final newFile = await file.copy(newFilePath);
    log('PDF saved at: $newFilePath');
  }
  User? user = FirebaseAuth.instance.currentUser;
  PatientModel? userModel;
  bool _isLoading = true;

  Future<void> fetchUserInfo() async {
    if (user == null) {
      setState(() {
        _isLoading = false;
      });
      return;
    }

    final userProvider = Provider.of<UserProvider>(context, listen: false);
    try {
      userModel = await userProvider.fetchUserInfo(
          collectionName:
          widget.userType == 'patient' ? 'patients' : 'doctors');
    } catch (error) {
      if (!mounted) return;
      await AppMethods.showErrorORWarningDialog(
        img : AppAssets.warningImg,

        context: context,
        subtitle: "$error",
        fct: () {},
      );
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  void initState() {
    fetchUserInfo();
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    final pdfState = context.watch<PdfState>();
    var height = MediaQuery.sizeOf(context).height;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
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
                  left: 25,
                  right: 25,
                  child: Row(
                    children: [
                      IconButton(
                        padding: EdgeInsets.zero,
                        onPressed: (){
                        Navigator.pop(context);
                      }, icon: const Icon(Icons.arrow_back_ios_new,color: Colors.white,size:15,),),
                      const Text(
                       'Information',
                        style: TextStyle(
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
                    child: Image.asset(widget.userType == 'patient'
                        ? AppAssets.pictureImg
                        : AppAssets.doctorImg),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              widget.userType == 'patient'
                  ? userModel?.userName ?? ""
                  : userModel?.userName ?? "",
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Colors.black,
                fontSize: 22,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w600,
              ),
            ),
            Text(
              '${userModel?.userEmail} | ${userModel?.contactNumber}',
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
              height: 48,
            ),
            Expanded(
              child: PDFView(
                enableSwipe: true,
                filePath: widget.pdfPath,
              ),
            ),
            FutureBuilder<DocumentSnapshot>(
              future: FirebaseFirestore.instance.collection('patients').doc(widget.patientId).get(),
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
                  child: Column(
                    children: [
                      const Text('Doctor Notes:'),
                      const SizedBox(height: 17,),
                      Text(additionalNotes),
                    ],
                  ),
                );
              },
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Container(
                color: Colors.white,
                child: CustomButton(
                  title: 'Download',
                  onTap: () {
                    _downloadPdf(widget.pdfPath);
                  },
                ),
              ),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: CustomButton(
                title: 'Continue',
                onTap: () {
                  Navigator.pop(context);
                },
              ),
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
  final String userType;

  PdfViewArguments(this.pdfPath, this.patientId, this.userType);
}
