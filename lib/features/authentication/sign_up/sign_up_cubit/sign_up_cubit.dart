import 'dart:developer';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
part 'sign_up_state.dart';

class SignUpCubit extends Cubit<SignUpState> {
  SignUpCubit() : super(SignUpInitial());

  Future<void> registerUser({
    required GlobalKey<FormState> formKey,
    required BuildContext context,
    required TextEditingController emailController,
    required TextEditingController passwordController,
    TextEditingController? contactNumberController,
    required TextEditingController nameController,
    TextEditingController? nickNameController,
    TextEditingController? countryController,
    TextEditingController? genderController,
    TextEditingController? addressController,
    required String collectionName,
    XFile? imageFile,
    XFile? pickedImage,
    String? userImageUrl,
  }) async {
    if (formKey.currentState != null) {
      final isValid = formKey.currentState!.validate();
      FocusScope.of(context).unfocus();
      if (isValid) {
        formKey.currentState!.save();
        emit(SignUpLoading());
        try {
          final auth = FirebaseAuth.instance;
          final authResult = await auth.createUserWithEmailAndPassword(
            email: emailController.text.trim(),
            password: passwordController.text.trim(),
          );
          final user = authResult.user;
          final uid = user!.uid;
          await FirebaseFirestore.instance
              .collection(collectionName)
              .doc(uid)
              .set({
            'userId': uid,
            'userName': nameController.text,
            'userEmail': emailController.text.toLowerCase(),
            'createdAt': Timestamp.now(),
            'contactNumber': contactNumberController?.text ?? "",
            'address': addressController?.text ?? "",
            'gender': genderController?.text ?? "",
            'country': countryController?.text ?? "",
            'nickName': nickNameController?.text ?? "",
          });
          Fluttertoast.showToast(
            msg: "An account has been created",
            toastLength: Toast.LENGTH_SHORT,
            textColor: Colors.white,
          );
          emit(SignUpSuccess());
        } on FirebaseAuthException catch (error) {
          if (error.code == 'weak-password') {
            emit(
              SignUpFailure(errMessage: 'The password provided is too weak.'),
            );
          }
          if (error.code == 'email-already-in-use') {
            emit(
              SignUpFailure(
                  errMessage: 'The account already exists for that email.'),
            );
          } else {
            emit(SignUpFailure(errMessage: error.toString()));
          }
        } catch (error) {
          emit(SignUpFailure(errMessage: error.toString()));
        }
      }
    }
  }

  Future<void> updateUser({
    required String collectionName,
    String? name,
    String? contactNumber,
    String? userEmail,
    String? country,
    String? gender,
    String? address,
    String? nickName,
  }) async {
    emit(SignUpLoading());
    try {
      final auth = FirebaseAuth.instance;
      final user = auth.currentUser;
      if (user == null) {
        emit(SignUpFailure(errMessage: 'No user is currently signed in.'));
        return;
      }
      final uid = user.uid;

      final Map<String, dynamic> updateData = {};
      if (name != null) updateData['userName'] = name;
      if (contactNumber != null) updateData['contactNumber'] = contactNumber;
      if (userEmail != null) updateData['userEmail'] = userEmail;
      if (country != null) updateData['country'] = country;
      if (gender != null) updateData['gender'] = gender;
      if (address != null) updateData['address'] = address;
      if (nickName != null) updateData['nickName'] = nickName;

      if (updateData.isNotEmpty) {
        await FirebaseFirestore.instance
            .collection(collectionName)
            .doc(uid)
            .update(updateData);
        Fluttertoast.showToast(
          msg: "Profile updated successfully",
          toastLength: Toast.LENGTH_SHORT,
          textColor: Colors.white,
        );
        emit(SignUpSuccess());
      } else {
        emit(SignUpFailure(errMessage: 'No changes to update.'));
      }
    } catch (error) {
      emit(SignUpFailure(errMessage: 'No changes to update.'));
    }
  }
}

class StorageService {
  final FirebaseStorage _storage = FirebaseStorage.instance;

  Future<String?> uploadImageToStorage(String userId, XFile imageFile) async {
    try {
      Reference storageRef = _storage.ref().child('user_images/$userId.jpg');
      UploadTask uploadTask = storageRef.putFile(File(imageFile.path));
      TaskSnapshot taskSnapshot = await uploadTask;
      return await taskSnapshot.ref.getDownloadURL();
    } catch (e) {
      log("Error uploading image: $e");
      return null;
    }
  }
}
