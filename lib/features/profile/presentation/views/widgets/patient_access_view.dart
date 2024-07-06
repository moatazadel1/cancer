import 'package:breast_cancer/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:go_router/go_router.dart';
import '../../../../../core/utils/app_assets.dart';
import '../../../../../core/utils/app_routes.dart';

class PatientAccessView extends StatelessWidget {
  const PatientAccessView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(S.of(context).SelectaPatient)),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('patients').snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }
          final patients = snapshot.data!.docs;
          return ListView.builder(
            itemCount: patients.length,
            itemBuilder: (context, index) {
              final patient = patients[index];
              return PatientsItem(
                  name: patient['userName'],
                  onTap: () {
                    GoRouter.of(context).push(
                      AppRoutes.kEditPdfView,
                      extra: patient.id,
                    );
                  });
            },
          );
        },
      ),
    );
  }
}

class PatientsItem extends StatelessWidget {
  final void Function()? onTap;
  final String name;
  const PatientsItem({super.key, required this.name, required this.onTap});

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
