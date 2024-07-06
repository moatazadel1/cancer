import 'dart:convert';
import 'dart:developer';
import 'package:breast_cancer/core/utils/app_routes.dart';
import 'package:breast_cancer/core/widgets/custom_button.dart';
import 'package:breast_cancer/generated/l10n.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../../../../core/utils/app_assets.dart';
import '../../../../../core/utils/app_methods.dart';
import '../../../../authentication/model/user_model.dart';
import '../../view_model/pdf_provider.dart';

class PdfView extends StatefulWidget {
  final String patientId;
  final String pdfPath;
  final String userType;

  const PdfView(
      {super.key,
      required this.patientId,
      required this.pdfPath,
      required this.userType});

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
        img: AppAssets.warningImg,
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
      body: Column(
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
                      S.of(context).Informationaboutthedisease,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontFamily: 'Montserrat',
                        fontWeight: FontWeight.w600,
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
          const SizedBox(height: 10),
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
          const SizedBox(height: 8),
          Text(
            S.of(context).XRay,
            style: const TextStyle(
              color: Colors.black,
              fontSize: 14,
              fontFamily: 'Roboto',
              fontWeight: FontWeight.w400,
              letterSpacing: 0.25,
            ),
          ),
          const SizedBox(height: 10),
          FutureBuilder<DocumentSnapshot>(
            future: FirebaseFirestore.instance
                .collection('patients')
                .doc(widget.patientId)
                .get(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }
              if (!snapshot.hasData ||
                  snapshot.data == null ||
                  !snapshot.data!.exists) {
                return Center(child: Text(S.of(context).Noimagefound));
              }
              final data = snapshot.data!.data() as Map<String, dynamic>;
              final imageUrl = data['imageUrl'];
              return Center(
                child: Container(
                  height: height * 0.25,
                  width: height * 0.25,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: MemoryImage(base64Decode(imageUrl.split(',')[1])),
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
              );
            },
          ),
          const SizedBox(height: 20),
          FutureBuilder<DocumentSnapshot>(
            future: FirebaseFirestore.instance
                .collection('patients')
                .doc(widget.patientId)
                .get(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }
              if (!snapshot.hasData ||
                  snapshot.data == null ||
                  !snapshot.data!.exists) {
                return Center(
                    child: Text(S.of(context).Noadditionalnotesfound));
              }
              final data = snapshot.data!.data() as Map<String, dynamic>;
              final additionalNotes =
                  data['additionalNotes'] ?? S.of(context).Noadditionalnotes;
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 15.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Align(
                          // alignment: Alignment.centerLeft,
                          child: Text(S.of(context).DoctorNotes,
                              style: const TextStyle(fontSize: 18))),
                    ),
                    const SizedBox(height: 10),
                    Center(
                        child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Text(additionalNotes),
                    )),
                  ],
                ),
              );
            },
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: CustomButton(
              title: S.of(context).continuee,
              onTap: () {
                GoRouter.of(context).push(AppRoutes.kRootView,
                    extra: widget.userType == 'patient' ? 'patient' : 'doctor');
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
    );
  }
}

class PdfViewArguments {
  final String pdfPath;
  final String patientId;
  final String userType;

  PdfViewArguments(this.pdfPath, this.patientId, this.userType);
}
