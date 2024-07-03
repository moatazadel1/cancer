import 'dart:developer';

import 'package:breast_cancer/core/utils/app_routes.dart';
import 'package:breast_cancer/core/utils/validators.dart';
import 'package:breast_cancer/core/widgets/custom_button.dart';
import 'package:breast_cancer/core/widgets/custom_text_field.dart';
import 'package:breast_cancer/generated/l10n.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';

class EditProfile extends StatefulWidget {
  final String userType;

  const EditProfile({super.key, required this.userType});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  late final TextEditingController _nameController,
      _passwordController,
      _emailController,
      _contactNumberController,
      _nickNameController,
      _countryController,
      _genderController,
      _addressController;
  late final FocusNode _nameFocusNode,
      _passwordFocusNode,
      _nickNameFocusNode,
      _emailFocusNode,
      _countryFocusNode,
      _genderFocusNode,
      _addressFocusNode,
      _contactNumberFocusNode;
  late final _formKey = GlobalKey<FormState>();
  bool obscureText = true;
  final bool _isLoading = false;
  // XFile? _pickedImage;
  // String? _userImageUrl;
  // final StorageService _storageService = StorageService();

  // final auth = FirebaseAuth.instance;

  @override
  void initState() {
    _nameController = TextEditingController();
    _passwordController = TextEditingController();
    _emailController = TextEditingController();
    _contactNumberController = TextEditingController();
    _nickNameController = TextEditingController();
    _countryController = TextEditingController();
    _genderController = TextEditingController();
    _addressController = TextEditingController();
    _nameFocusNode = FocusNode();
    _passwordFocusNode = FocusNode();
    _contactNumberFocusNode = FocusNode();
    _nickNameFocusNode = FocusNode();
    _emailFocusNode = FocusNode();
    _countryFocusNode = FocusNode();
    _genderFocusNode = FocusNode();
    _addressFocusNode = FocusNode();
    super.initState();
    _loadUserData();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _passwordController.dispose();
    _contactNumberController.dispose();
    _nickNameController.dispose();
    _emailController.dispose();
    _countryController.dispose();
    _genderController.dispose();
    _addressController.dispose();
    _nameFocusNode.dispose();
    _passwordFocusNode.dispose();
    _contactNumberFocusNode.dispose();
    _nickNameFocusNode.dispose();
    _countryFocusNode.dispose();
    _genderFocusNode.dispose();
    _emailFocusNode.dispose();
    _addressFocusNode.dispose();
    super.dispose();
  }

  Future<void> _loadUserData() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      DocumentSnapshot userDoc = await FirebaseFirestore.instance
          .collection(widget.userType == 'patient' ? 'patients' : 'doctors')
          .doc(user.uid)
          .get();
      if (userDoc.exists) {
        setState(() {
          _nameController.text = userDoc['userName'];
          _contactNumberController.text = userDoc['contactNumber'];
          _emailController.text = userDoc['userEmail'];
          _addressController.text = userDoc['address'];
          _nickNameController.text = userDoc['nickName'];
          _countryController.text = userDoc['country'];
          _genderController.text = userDoc['gender'];

          // _dateOfBirthController.text = userDoc['dateOfBirth'];
          // _userImageUrl = userDoc['profileImageUrl'];
        });
      }
    }
  }

  // Future<void> _pickImage() async {
  //   final ImagePicker picker = ImagePicker();
  //   final pickedFile = await picker.pickImage(source: ImageSource.gallery);
  //   print("Picked Image: $pickedFile");
  //   if (pickedFile != null) {
  //     // Check if an image was picked
  //     setState(() {
  //       _pickedImage = pickedFile;
  //     });
  //   }
  // }

  Future<void> _updateUserProfile() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      // String? imageUrl = _userImageUrl;
      // if (_pickedImage != null) {
      //   try {
      //     imageUrl = await _storageService.uploadImageToStorage(
      //         user.uid, _pickedImage!);
      //     log("Uploaded Image URL: $imageUrl");
      //     if (imageUrl == null || imageUrl.isEmpty) {
      //       Fluttertoast.showToast(
      //         msg: "Failed to get image URL",
      //         toastLength: Toast.LENGTH_SHORT,
      //         textColor: Colors.white,
      //       );
      //       return;
      //     }
      //   } catch (error) {
      //     log("Error uploading image: $error");
      //     Fluttertoast.showToast(
      //       msg: "Failed to upload image",
      //       toastLength: Toast.LENGTH_SHORT,
      //       textColor: Colors.white,
      //     );
      //     return;
      //   }
      // }

      try {
        await FirebaseFirestore.instance
            .collection(widget.userType == 'patient' ? 'patients' : 'doctors')
            .doc(user.uid)
            .update({
          'userName': _nameController.text,
          'contactNumber': _contactNumberController.text,
          'userEmail': _emailController.text,
          'address': _addressController.text,
          'nickName': _nickNameController.text,
          'country': _countryController.text,
          'gender': _genderController.text,
          // 'dateOfBirth': _dateOfBirthController.text,
          // 'profileImageUrl': imageUrl,
        });

        // setState(() {
        //   _userImageUrl = imageUrl;
        // });
        if (!mounted) return;
        Fluttertoast.showToast(
          msg: S.of(context).Profileupdatedsuccessfully,
          toastLength: Toast.LENGTH_SHORT,
          textColor: Colors.white,
        );
        if (!mounted) return;
        GoRouter.of(context).push(AppRoutes.kRootView, extra: widget.userType);
      } catch (error) {
        log(S.of(context).Errorupdatingprofile);
        Fluttertoast.showToast(
          msg: S.of(context).Failedtoupdateprofile,
          toastLength: Toast.LENGTH_SHORT,
          textColor: Colors.white,
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            S.of(context).Editprofile,
            // textAlign: TextAlign.center,
            style: const TextStyle(
              color: Colors.black,
              fontSize: 22,
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w600,
              height: 0.06,
            ),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 17),
          child: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(
                    height: 65,
                  ),
                  CustomTextField(
                    controller: _nameController,
                    focusNode: _nameFocusNode,
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.name,
                    labelText: S.of(context).Fullname,
                    validator: (value) {
                      return Validators.displayNamevalidator(value, context);
                    },
                    fillColor: const Color(0x4CFFB8B8),
                  ),
                  const SizedBox(
                    height: 24,
                  ),
                  CustomTextField(
                    controller: _nickNameController,
                    focusNode: _nickNameFocusNode,
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.name,
                    labelText: S.of(context).Nickname,
                    validator: (value) {
                      return Validators.displayNamevalidator(value, context);
                    },
                    fillColor: const Color(0x4CFFB8B8),
                  ),
                  const SizedBox(
                    height: 24,
                  ),
                  CustomTextField(
                    controller: _emailController,
                    focusNode: _emailFocusNode,
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.emailAddress,
                    contentPadding: const EdgeInsets.symmetric(
                        horizontal: 19, vertical: 10),
                    labelText: S.of(context).Emailaddress,
                    validator: (value) {
                      return Validators.emailValidator(value, context);
                    },
                    fillColor: const Color(0x4CFFB8B8),
                  ),
                  const SizedBox(
                    height: 24,
                  ),
                  CustomTextField(
                    controller: _contactNumberController,
                    focusNode: _contactNumberFocusNode,
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.phone,
                    labelText: S.of(context).Phonenumber,
                    validator: (value) {
                      return Validators.contactNumberValidator(value, context);
                    },
                    fillColor: const Color(0x4CFFB8B8),
                  ),
                  const SizedBox(
                    height: 24,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: CustomTextField(
                          controller: _countryController,
                          focusNode: _countryFocusNode,
                          textInputAction: TextInputAction.next,
                          keyboardType: TextInputType.name,
                          labelText: S.of(context).Country,
                          validator: (value) {
                            return Validators.countryNameValidator(
                                value, context);
                          },
                          fillColor: const Color(0x4CFFB8B8),
                        ),
                      ),
                      const SizedBox(
                        width: 16,
                      ),
                      Expanded(
                        child: CustomTextField(
                          controller: _genderController,
                          focusNode: _genderFocusNode,
                          textInputAction: TextInputAction.next,
                          keyboardType: TextInputType.name,
                          labelText: S.of(context).Genre,
                          validator: (value) {
                            return Validators.genderValidator(value, context);
                          },
                          fillColor: const Color(0x4CFFB8B8),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 24,
                  ),
                  CustomTextField(
                    controller: _addressController,
                    focusNode: _addressFocusNode,
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.streetAddress,
                    labelText: S.of(context).Address,
                    validator: (value) {
                      return Validators.displayAddressvalidator(value, context);
                    },
                    fillColor: const Color(0x4CFFB8B8),
                  ),
                  const SizedBox(
                    height: 24,
                  ),
                  CustomButton(
                      onTap: () async {
                        await _updateUserProfile();
                      },
                      title: S.of(context).SUBMIT),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
