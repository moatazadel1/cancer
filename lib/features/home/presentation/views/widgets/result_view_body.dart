import 'dart:convert';
import 'package:breast_cancer/core/utils/app_assets.dart';
import 'package:breast_cancer/core/utils/app_methods.dart';
import 'package:breast_cancer/core/widgets/custom_button.dart';
import 'package:breast_cancer/features/authentication/model/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../../../../core/utils/app_routes.dart';
import '../../../../../core/utils/create_pdf.dart';
import '../../../../profile/presentation/view_model/pdf_provider.dart';

class ResultViewBody extends StatefulWidget {
  final String userType;

  final String imageUrl;

  const ResultViewBody(
      {super.key, required this.imageUrl, required this.userType});

  @override
  State<ResultViewBody> createState() => _ResultViewBodyState();
}

class _ResultViewBodyState extends State<ResultViewBody> {
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
    // Sample data for PDF creation
    String userName = userModel?.userName ?? "User Name";
    const String title = 'Lorem Ipsum';
    const String safetyStatus = 'You are in safe';
    final List<String> details = [
      'Lorem Ipsum is simply dummy',
      'Lorem Ipsum is simply dummy',
      'Lorem Ipsum is simply dummy',
      'Lorem Ipsum is simply dummy',
    ];
    const String percentage = '76%';

    var width = MediaQuery.sizeOf(context).width;
    var height = MediaQuery.sizeOf(context).height;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
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
                    userModel?.userName ?? "User Name",
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w700,
                      height: 0,
                    ),
                  ),
                ],
              ),
            ),
            Stack(
              children: [
                Container(
                  width: 350,
                  height: 572.02,
                  decoration: ShapeDecoration(
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    shadows: const [
                      BoxShadow(
                        color: Color(0x3F000000),
                        blurRadius: 7,
                        offset: Offset(0, 4),
                        spreadRadius: 0,
                      )
                    ],
                  ),
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 30,
                      ),
                      Container(
                        height: height * 0.25,
                        width: width * 0.5,
                        decoration: ShapeDecoration(
                          image: DecorationImage(
                            image: MemoryImage(
                                base64Decode(widget.imageUrl.split(',')[1])),
                            fit: BoxFit.fill,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 18,
                      ),
                      const Text(
                        'Lorem Ipsum',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Color(0xFF3C3C3C),
                          fontSize: 27,
                          fontFamily: 'Montserrat',
                          fontWeight: FontWeight.w700,
                          height: 0,
                        ),
                      ),
                      const SizedBox(
                        height: 9,
                      ),
                      Container(
                        decoration: ShapeDecoration(
                          color: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(33),
                          ),
                          shadows: const [
                            BoxShadow(
                              color: Color(0x3F000000),
                              blurRadius: 4,
                              offset: Offset(0, 4),
                              spreadRadius: 0,
                            )
                          ],
                        ),
                        child: const Padding(
                          padding:
                              EdgeInsets.symmetric(horizontal: 32, vertical: 2),
                          child: Text(
                            'You are in safe',
                            style: TextStyle(
                              color: Color(0xFF1C6C32),
                              fontSize: 16,
                              fontFamily: 'Montserrat',
                              fontWeight: FontWeight.w700,
                              height: 0,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 13,
                      ),
                      const Padding(
                        padding: EdgeInsets.only(left: 34),
                        child: Column(
                          children: [
                            CustomListTile(
                              title: "Lorem Ipsum is simply dummy",
                            ),
                            CustomListTile(
                              title: "Lorem Ipsum is simply dummy",
                            ),
                            CustomListTile(
                              title: "Lorem Ipsum is simply dummy",
                            ),
                            CustomListTile(
                              title: "Lorem Ipsum is simply dummy",
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      const Text(
                        '76%',
                        style: TextStyle(
                          color: Color(0xFF1C6C32),
                          fontSize: 27,
                          fontFamily: 'Montserrat',
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
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 28),
              child: CustomButton(
                title: 'Continue',
                onTap: () async {
                                    final pdfFile = await createPdf(
                      userName, title, safetyStatus, details, percentage);
                  context.read<PdfState>().setPdfPath(
                      pdfFile.path); // Store the PDF path in the state

                  GoRouter.of(context)
                      .push(AppRoutes.kPdfView, extra: pdfFile.path);

                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CustomListTile extends StatelessWidget {
  final String title;
  const CustomListTile({
    super.key,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      minTileHeight: 0,
      title: Row(
        children: [
          const Icon(
            Icons.circle,
            size: 5,
          ),
          const SizedBox(
            width: 7,
          ),
          Text(title),
        ],
      ),
    );
  }
}
