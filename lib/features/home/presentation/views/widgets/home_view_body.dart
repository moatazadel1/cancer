import 'dart:convert';
import 'dart:developer';
import 'package:breast_cancer/core/utils/app_assets.dart';
import 'package:breast_cancer/core/utils/app_methods.dart';
import 'package:breast_cancer/features/authentication/model/user_model.dart';
import 'package:breast_cancer/features/home/presentation/views/result_view.dart';
import 'package:breast_cancer/generated/l10n.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

class HomeViewBody extends StatefulWidget {
  final String userType;

  const HomeViewBody({super.key, required this.userType});

  @override
  State<HomeViewBody> createState() => _HomeViewBodyState();
}

class _HomeViewBodyState extends State<HomeViewBody>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  XFile? _pickedImage;
  final ImagePicker picker = ImagePicker();
  User? user = FirebaseAuth.instance.currentUser;
  PatientModel? userModel;
  bool _isLoading = true;
  String? _predictedImageUrl;

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

  // Future<void> localImagePicker() async {
  //   final ImagePicker picker = ImagePicker();
  //   await AppMethods.imagePickerDialog(
  //     context: context,
  //     cameraFCT: () async {
  //       _pickedImage = await picker.pickImage(source: ImageSource.camera);
  //       if (_pickedImage != null) {
  //         await uploadImage(_pickedImage!);
  //         navigateToResultView();
  //       }
  //     },
  //     galleryFCT: () async {
  //       _pickedImage = await picker.pickImage(source: ImageSource.gallery);
  //       if (_pickedImage != null) {
  //         await uploadImage(_pickedImage!);
  //         navigateToResultView();
  //       }
  //     },
  //     removeFCT: () {
  //       setState(() {
  //         _pickedImage = null;
  //       });
  //     },
  //   );
  // }

  Future<void> uploadImage(XFile image) async {
    setState(() {
      _isLoading = true;
    });

    var request = http.MultipartRequest(
      'POST',
      Uri.parse('http://10.0.2.2:5000/predict'), // Use 10.0.2.2 for emulator
    );
    request.files.add(await http.MultipartFile.fromPath('file', image.path));

    try {
      var response = await request.send();

      if (response.statusCode == 200) {
        var responseData = await response.stream.toBytes();
        var base64Image = base64Encode(responseData);
        setState(() {
          _predictedImageUrl = 'data:image/png;base64,$base64Image';
          _isLoading = false;
        });
      } else {
        log('Failed to load predicted image with status code: ${response.statusCode}');
        setState(() {
          _isLoading = false;
        });
      }
    } catch (error) {
      log('Error occurred while uploading image: $error');
      setState(() {
        _isLoading = false;
      });
    }
  }

  void navigateToResultView() {
    if (_predictedImageUrl != null) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ResultView(
            imageUrl: _predictedImageUrl!,
            userType: widget.userType,
          ),
        ),
      );
    }
  }

  @override
  void initState() {
    fetchUserInfo();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    var height = MediaQuery.sizeOf(context).height;
    return Scaffold(
      body: Column(
        children: [
          Stack(
            children: [
              SizedBox(
                width: double.infinity,
                height: height * 0.47,
                child: Image.asset(
                  AppAssets.handsImg,
                  fit: BoxFit.cover,
                ),
              ),
              Container(
                height: 88,
                clipBehavior: Clip.antiAlias,
                decoration: const BoxDecoration(
                  color: Color(0xADD97676),
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(50),
                      topLeft: Radius.circular(50)),
                ),
                child: Row(
                  children: [
                    const SizedBox(
                      width: 29,
                    ),
                    Image.asset(AppAssets.userImg),
                    const SizedBox(
                      width: 12,
                    ),
                    Text(
                      widget.userType == 'patient'
                          ? userModel?.userName ?? ""
                          : userModel?.userName ?? "",
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w700,
                        height: 0,
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 63,
          ),
          Text(
            S.of(context).TakeaTest,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Colors.black,
              fontSize: 27,
              fontFamily: 'Inter',
              fontWeight: FontWeight.w700,
              height: 0,
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          Text(
            S.of(context).ScanorUploadyourrayphoto,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Color(0xFF625B5B),
              fontSize: 20,
              fontFamily: 'Inter',
              fontWeight: FontWeight.w400,
              height: 0,
            ),
          ),
          const SizedBox(
            height: 42,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              GestureDetector(
                onTap: () async {
                  _pickedImage =
                      await picker.pickImage(source: ImageSource.gallery);
                  if (_pickedImage != null) {
                    await uploadImage(_pickedImage!);
                    navigateToResultView();
                  }
                },
                child: Column(
                  children: [
                    Image.asset(AppAssets.galleryImg),
                    const SizedBox(
                      height: 13,
                    ),
                    Text(
                      S.of(context).Upload,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w400,
                        height: 0,
                      ),
                    )
                  ],
                ),
              ),
              GestureDetector(
                onTap: () async {
                  _pickedImage =
                      await picker.pickImage(source: ImageSource.camera);
                  if (_pickedImage != null) {
                    await uploadImage(_pickedImage!);
                    navigateToResultView();
                  }
                },
                child: Column(
                  children: [
                    Image.asset(AppAssets.scanImg),
                    const SizedBox(
                      height: 18,
                    ),
                    Text(
                      S.of(context).Scan,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w400,
                        height: 0,
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}


// import 'dart:convert';
// import 'dart:developer';
// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:http/http.dart' as http;
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:provider/provider.dart';
// import 'package:breast_cancer/core/utils/app_assets.dart';
// import 'package:breast_cancer/core/utils/app_methods.dart';
// import 'package:breast_cancer/features/authentication/model/user_model.dart';
// import 'package:breast_cancer/generated/l10n.dart';

// class HomeViewBody extends StatefulWidget {
//   const HomeViewBody({super.key});

//   @override
//   State<HomeViewBody> createState() => _HomeViewBodyState();
// }

// class _HomeViewBodyState extends State<HomeViewBody>
//     with AutomaticKeepAliveClientMixin {
//   @override
//   bool get wantKeepAlive => true;

  // XFile? _pickedImage;
  // final ImagePicker picker = ImagePicker();
  // User? user = FirebaseAuth.instance.currentUser;
  // PatientModel? userModel;
  // bool _isLoading = true;
  // String? _predictedImageUrl;

//   Future<void> fetchUserInfo() async {
//     if (user == null) {
//       setState(() {
//         _isLoading = false;
//       });
//       return;
//     }

//     final userProvider = Provider.of<UserProvider>(context, listen: false);
//     try {
//       userModel = await userProvider.fetchUserInfo();
//     } catch (error) {
//       if (!mounted) return;
//       await AppMethods.showErrorORWarningDialog(
//         context: context,
//         subtitle: "$error",
//         fct: () {},
//       );
//     } finally {
//       setState(() {
//         _isLoading = false;
//       });
//     }
//   }

  // Future<void> uploadImage(XFile image) async {
  // //     static const String emulatorUrl = 'http://10.0.2.2:5000/predict';
  // // static const String deviceUrl = 'http://192.168.1.4:5000/predict';

  //   setState(() {
  //     _isLoading = true;
  //   });

  //   var request = http.MultipartRequest(
  //     'POST',
  //     Uri.parse(
  //         'http://10.0.2.2:5000/predict'), // Use 10.0.2.2 for Android emulator
  //   );
  //   request.files.add(await http.MultipartFile.fromPath('file', image.path));

  //   try {
  //     var response = await request.send();

  //     if (response.statusCode == 200) {
  //       var responseData = await response.stream.toBytes();
  //       var base64Image = base64Encode(responseData);
  //       setState(() {
  //         _predictedImageUrl = 'data:image/png;base64,$base64Image';
  //         _isLoading = false;
  //       });
  //     } else {
  //       log('Failed to load predicted image with status code: ${response.statusCode}');
  //       setState(() {
  //         _isLoading = false;
  //       });
  //     }
  //   } catch (error) {
  //     log('Error occurred while uploading image: $error');
  //     setState(() {
  //       _isLoading = false;
  //     });
  //   }
  // }

//   Future<void> localImagePicker() async {
//     await AppMethods.imagePickerDialog(
//       context: context,
//       cameraFCT: () async {
//         try {
//           _pickedImage = await picker.pickImage(source: ImageSource.camera);
//           if (_pickedImage != null) {
//             await uploadImage(_pickedImage!);
//           }
//           setState(() {});
//         } catch (error) {
//           log('Error picking image from camera: $error');
//         }
//       },
//       galleryFCT: () async {
//         try {
//           _pickedImage = await picker.pickImage(source: ImageSource.gallery);
//           if (_pickedImage != null) {
//             await uploadImage(_pickedImage!);
//           }
//           setState(() {});
//         } catch (error) {
//           log('Error picking image from gallery: $error');
//         }
//       },
//       removeFCT: () {
//         setState(() {
//           _pickedImage = null;
//         });
//       },
//     );
//   }

//   @override
//   void initState() {
//     fetchUserInfo();
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     super.build(context);
//     var height = MediaQuery.sizeOf(context).height;
//     return Scaffold(
//       body: SingleChildScrollView(
//         child: Column(
//           children: [
//             Stack(
//               children: [
//                 SizedBox(
//                   width: double.infinity,
//                   height: height * 0.47,
//                   child: Image.asset(
//                     AppAssets.handsImg,
//                     fit: BoxFit.cover,
//                   ),
//                 ),
//                 Container(
//                   height: 88,
//                   clipBehavior: Clip.antiAlias,
//                   decoration: const BoxDecoration(
//                     color: Color(0xADD97676),
//                     borderRadius: BorderRadius.only(
//                       topRight: Radius.circular(50),
//                       topLeft: Radius.circular(50),
//                     ),
//                   ),
//                   child: Row(
//                     children: [
//                       const SizedBox(
//                         width: 29,
//                       ),
//                       Image.asset(AppAssets.userImg),
//                       const SizedBox(
//                         width: 12,
//                       ),
//                       Text(
//                         userModel?.userName ?? "",
//                         textAlign: TextAlign.center,
//                         style: const TextStyle(
//                           color: Colors.white,
//                           fontSize: 18,
//                           fontFamily: 'Inter',
//                           fontWeight: FontWeight.w700,
//                           height: 0,
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//             const SizedBox(
//               height: 63,
//             ),
//             Text(
//               S.of(context).TakeaTest,
//               textAlign: TextAlign.center,
//               style: const TextStyle(
//                 color: Colors.black,
//                 fontSize: 27,
//                 fontFamily: 'Inter',
//                 fontWeight: FontWeight.w700,
//                 height: 0,
//               ),
//             ),
//             const SizedBox(
//               height: 15,
//             ),
//             Text(
//               S.of(context).ScanorUploadyourrayphoto,
//               textAlign: TextAlign.center,
//               style: const TextStyle(
//                 color: Color(0xFF625B5B),
//                 fontSize: 20,
//                 fontFamily: 'Inter',
//                 fontWeight: FontWeight.w400,
//                 height: 0,
//               ),
//             ),
//             const SizedBox(
//               height: 42,
//             ),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//               children: [
//                 GestureDetector(
//                   onTap: () async {
//                     await localImagePicker();
//                   },
//                   child: Column(
//                     children: [
//                       Image.asset(AppAssets.galleryImg),
//                       const SizedBox(
//                         height: 13,
//                       ),
//                       Text(
//                         S.of(context).Upload,
//                         textAlign: TextAlign.center,
//                         style: const TextStyle(
//                           color: Colors.black,
//                           fontSize: 18,
//                           fontFamily: 'Inter',
//                           fontWeight: FontWeight.w400,
//                           height: 0,
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//                 GestureDetector(
//                   onTap: () async {
//                     await localImagePicker();
//                   },
//                   child: Column(
//                     children: [
//                       Image.asset(AppAssets.scanImg),
//                       const SizedBox(
//                         height: 18,
//                       ),
//                       Text(
//                         S.of(context).Scan,
//                         textAlign: TextAlign.center,
//                         style: const TextStyle(
//                           color: Colors.black,
//                           fontSize: 18,
//                           fontFamily: 'Inter',
//                           fontWeight: FontWeight.w400,
//                           height: 0,
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//             const SizedBox(height: 20),
//             if (_isLoading) const CircularProgressIndicator(),
//             if (_predictedImageUrl != null)
//               Column(
//                 children: [
//                   const SizedBox(height: 20),
//                   const Text(
//                     'Predicted Mask:',
//                     style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//                   ),
//                   const SizedBox(height: 10),
//                   Image.memory(base64Decode(_predictedImageUrl!.split(',')[1])),
//                 ],
//               ),
//           ],
//         ),
//       ),
//     );
//   }
// }
