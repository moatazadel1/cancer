import 'package:breast_cancer/core/utils/app_assets.dart';
import 'package:breast_cancer/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import '../../../../../core/utils/app_methods.dart';

class DoctorAccessView extends StatefulWidget {
  final String pdfPath;

  const DoctorAccessView({super.key, required this.pdfPath});

  @override
  State<DoctorAccessView> createState() => _DoctorAccessViewState();
}

class _DoctorAccessViewState extends State<DoctorAccessView> {
  Future<void> sendPdfToDoctor(String doctorId) async {
    try {
      final file = File(widget.pdfPath);
      final ref = FirebaseStorage.instance
          .ref()
          .child('pdfs/$doctorId/${file.path.split('/').last}');
      await ref.putFile(file);
      final downloadUrl = await ref.getDownloadURL();

      await FirebaseFirestore.instance
          .collection('doctors')
          .doc(doctorId)
          .update({
        'pdfs': FieldValue.arrayUnion([downloadUrl]),
      });

      Fluttertoast.showToast(
        msg: S.of(context).Aninformationhasbeensent,
        toastLength: Toast.LENGTH_SHORT,
        textColor: Colors.white,
      );
    } catch (e) {
      Fluttertoast.showToast(
        msg: "${S.of(context).Failedtosendinformation} $e",
        toastLength: Toast.LENGTH_SHORT,
        textColor: Colors.red,
      );
    }
  }
  // @override
  // void initState() {
  //   if (widget.pdfPath!.isEmpty) {
  //     WidgetsBinding.instance.addPostFrameCallback((_) {
  //       AppMethods.showErrorORWarningDialog(
  //         context: context,
  //         subtitle: 'Please create a PDF with your information to view it.',
  //         fct: () {
  //           Navigator.pop(context); // Close the dialog
  //           // Navigator.pop(context); // Go back to the previous screen
  //           GoRouter.of(context).push(AppRoutes.kRootView);
  //         },
  //         img: AppAssets.warningImg,
  //         isError: true,
  //       );
  //     });
  //   }
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    if (widget.pdfPath.isEmpty) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        AppMethods.showErrorORWarningDialog(
          context: context,
          subtitle:
              S.of(context).PleasecreateaPDFwithyourinformationtoaccessdoctors,
          fct: () {},
          img: AppAssets.warningImg,
          isError: true,
        );
      });
      return Scaffold(
        appBar: AppBar(
          title: Text(
            S.of(context).Doctors,
            style: const TextStyle(
              color: Colors.black,
              fontSize: 22,
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        body: Center(
          child: Text(
            S.of(context).NoPDFavailablePleasecreateaPDFfirst,
            style: const TextStyle(fontSize: 18, color: Colors.red),
          ),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(
          S.of(context).Doctors,
          style: const TextStyle(
            color: Colors.black,
            fontSize: 22,
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('doctors').snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          final doctors = snapshot.data!.docs;
          return ListView.builder(
            scrollDirection: Axis.vertical,
            physics: const BouncingScrollPhysics(),
            itemCount: doctors.length,
            itemBuilder: (context, index) {
              final doctor = doctors[index];
              return DoctorsItem(
                name: doctor['userName'],
                onTap: () async {
                  bool confirmed = await AppMethods.showConfirmationDialog(
                    context: context,
                    subtitle: S.of(context).Confirmsendyourinformation,
                    img: AppAssets.successfulImg,
                    isError: false,
                    fct: () async {
                      Navigator.of(context).pop(true);
                    },
                  );
                  if (confirmed) {
                    await sendPdfToDoctor(doctor.id);
                  }
                },
              );
            },
          );
        },
      ),
    );
  }
}

class DoctorsItem extends StatelessWidget {
  final void Function()? onTap;
  final String name;
  const DoctorsItem({super.key, required this.name, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          const SizedBox(
            height: 30,
          ),
          SizedBox(
            height: 45,
            width: double.infinity,
            child: Padding(
              padding: const EdgeInsets.only(left: 8),
              child: Row(
                children: [
                  Image.asset(AppAssets.personImg),
                  const SizedBox(width: 28),
                  Text(
                    name,
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontFamily: 'Open Sans',
                      fontWeight: FontWeight.w400,
                      height: 1.2,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
