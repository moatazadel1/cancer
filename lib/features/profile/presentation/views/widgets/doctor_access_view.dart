import 'package:breast_cancer/core/utils/app_assets.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';

class DoctorAccessView extends StatelessWidget {
  final String pdfPath;

  const DoctorAccessView({Key? key, required this.pdfPath}) : super(key: key);

  Future<void> sendPdfToDoctor(String doctorId) async {
    try {
      final file = File(pdfPath);
      final ref = FirebaseStorage.instance.ref().child('pdfs/$doctorId/${file.path.split('/').last}');
      await ref.putFile(file);
      final downloadUrl = await ref.getDownloadURL();

      await FirebaseFirestore.instance.collection('doctors').doc(doctorId).update({
        'pdfs': FieldValue.arrayUnion([downloadUrl]),
      });

      Fluttertoast.showToast(
        msg: "An information has been sent",
        toastLength: Toast.LENGTH_SHORT,
        textColor: Colors.white,
      );
    } catch (e) {
      Fluttertoast.showToast(
        msg: "Failed to send information: $e",
        toastLength: Toast.LENGTH_SHORT,
        textColor: Colors.red,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(
        'Doctors',
        style: TextStyle(
          color: Colors.black,
          fontSize: 22,
          fontFamily: 'Poppins',
          fontWeight: FontWeight.w600,
        ),
      )),
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
              return DoctorsItem(name:doctor['userName'], onTap: () => sendPdfToDoctor(doctor.id), );
              //   ListTile(
              //   title: Text(doctor['userName']),
              //   subtitle: Text(doctor['userEmail']),
              //   onTap: () => sendPdfToDoctor(doctor.id),
              // );
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
        const  SizedBox(
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


