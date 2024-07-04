import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:go_router/go_router.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../../../../../core/utils/app_routes.dart';

class PatientAccessView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Select a Patient')),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('patients').snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          }

          final patients = snapshot.data!.docs;

          return ListView.builder(
            itemCount: patients.length,
            itemBuilder: (context, index) {
              final patient = patients[index];
              return ListTile(
                title: Text(patient['userName']),
                subtitle: Text(patient['userEmail']),
                onTap: () {
                  // final patientData = patient.data() as Map<String, dynamic>;
                  GoRouter.of(context).push(
                    AppRoutes.kEditPdfView,
                    extra: patient.id,
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}
