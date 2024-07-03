import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class PatientModel with ChangeNotifier {
  // dateOfBirth
  final String userId, userName, contactNumber, userEmail;
  final Timestamp createdAt;
  PatientModel({
    required this.userId,
    // required this.dateOfBirth,
    required this.contactNumber,
    required this.userName,
    required this.userEmail,
    required this.createdAt,
  });
}

class UserProvider with ChangeNotifier {
  PatientModel? userModel;
  PatientModel? get getUserModel {
    return userModel;
  }

  Future<PatientModel?> fetchUserInfo({required String collectionName}) async {
    final FirebaseAuth auth = FirebaseAuth.instance;
    User? user = auth.currentUser;
    if (user == null) {
      return null;
    }
    var uid = user.uid;
    try {
      final userDoc = await FirebaseFirestore.instance
          .collection(collectionName)
          .doc(uid)
          .get();
      userModel = PatientModel(
          userId: userDoc.get("userId"),
          // dateOfBirth: userDoc.get('dateOfBirth'),
          contactNumber: userDoc.get("contactNumber"),
          userName: userDoc.get("userName"),
          userEmail: userDoc.get('userEmail'),
          createdAt: userDoc.get('createdAt'));
      return userModel;
    } on FirebaseException catch (error) {
      throw error.message.toString();
    } catch (error) {
      rethrow;
    }
  }
}
