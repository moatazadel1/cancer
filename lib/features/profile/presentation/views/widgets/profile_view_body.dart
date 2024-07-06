import 'package:breast_cancer/core/utils/app_assets.dart';
import 'package:breast_cancer/core/utils/app_methods.dart';
import 'package:breast_cancer/core/utils/app_routes.dart';
import 'package:breast_cancer/features/authentication/model/user_model.dart';
import 'package:breast_cancer/features/profile/presentation/view_model/language_provider.dart';
import 'package:breast_cancer/features/profile/presentation/views/widgets/custom_profile_container.dart';
import 'package:breast_cancer/features/profile/presentation/views/widgets/custom_profile_item.dart';
import 'package:breast_cancer/features/profile/presentation/views/widgets/pdf_view.dart';
import 'package:breast_cancer/generated/l10n.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../../view_model/pdf_provider.dart';

class ProfileViewBody extends StatefulWidget {
  final String userType;

  const ProfileViewBody({super.key, required this.userType});

  @override
  State<ProfileViewBody> createState() => _ProfileViewBodyState();
}

class _ProfileViewBodyState extends State<ProfileViewBody>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

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
        img : AppAssets.warningImg,

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
    var languageProvider = Provider.of<LanguageProvider>(context);

    super.build(context);
    var height = MediaQuery.sizeOf(context).height;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
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
                  left: 25,
                  right: 25,

                  child: Row(
                    children: [
                      Text(
                        S.of(context).Profile,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 25,
                          fontFamily: 'Montserrat',
                          fontWeight: FontWeight.w600,
                          height: 0,
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
                Positioned(
                  bottom: 0,
                  left: MediaQuery.sizeOf(context).width / 2 + 20,
                  child: Container(
                    width: 46,
                    height: 46,
                    decoration: const ShapeDecoration(
                      color: Color(0xFFF5F5F5),
                      shape: OvalBorder(
                        side: BorderSide(width: 5, color: Colors.white),
                      ),
                    ),
                    child: GestureDetector(
                        onTap: () {
                          GoRouter.of(context).push(
                            AppRoutes.kEditProfileView,
                            extra: widget.userType == 'patient'
                                ? 'patient'
                                : 'doctor',
                          );
                        },
                        child: Image.asset(AppAssets.editImg)),
                  ),
                )
              ],
            ),
            const SizedBox(
              height: 10,
            ),
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
            const SizedBox(
              height: 48,
            ),
            CustomProfileContainer(
              child: Column(
                children: [
                  const SizedBox(
                    height: 14,
                  ),
                  CustomProfileItem(
                    onTap: () {
                      GoRouter.of(context).push(
                        AppRoutes.kEditProfileView,
                        extra:
                            widget.userType == 'patient' ? 'patient' : 'doctor',
                      );
                    },
                    title: S.of(context).Editprofile,
                    leading: Image.asset(AppAssets.edit2Img),
                  ),
                  widget.userType == 'patient' ?
                  CustomProfileItem(
                    onTap: () {
                      final pdfPath = context.read<PdfState>().pdfPath;
                      GoRouter.of(context).push(AppRoutes.kDoctorAccessView, extra: pdfPath);
                    },
                    title: "Doctor access",
                    leading: const Icon(Icons.send),
                  ) : CustomProfileItem(
                    onTap: () {
                      final pdfPath = context.read<PdfState>().pdfPath;
                      GoRouter.of(context).push(AppRoutes.kPatientAccessView , extra: pdfPath);
                    },
                    title: "Patient access",
                    leading: const Icon(Icons.send),
                  ),
                  widget.userType == 'patient' ?
                  CustomProfileItem(
                    onTap: () {
                      final pdfPath = context.read<PdfState>().pdfPath;
                      final patientId = userModel?.userId ?? "";  // Ensure you have the patientId
                      GoRouter.of(context).push(
                        AppRoutes.kPdfView,
                        extra: PdfViewArguments(pdfPath ?? '', patientId,widget.userType),
                      );
                    },
                    title: "Information about the disease",
                    leading:  Image.asset(AppAssets.medicalinpatientImg),
                  ) : Container(),
                  CustomProfileItem(
                    onTap: () {
                      GoRouter.of(context).push(AppRoutes.kNotificationView);
                    },
                    title: S.of(context).Notifications,
                    leading: Image.asset(AppAssets.notiLightImg),
                    trailing: Text(
                      S.of(context).ON,
                      style: const TextStyle(
                        color: Color(0xFF1573FE),
                        fontSize: 14,
                        fontFamily: 'Roboto',
                        fontWeight: FontWeight.w400,
                        letterSpacing: 0.25,
                      ),
                    ),
                  ),
                  CustomProfileItem(
                    onTap: () {
                      GoRouter.of(context).push(AppRoutes.kLanguageView);
                    },
                    title: S.of(context).Language,
                    leading: Image.asset(AppAssets.langLightImg),
                    trailing: Text(
                      languageProvider.languageName,
                      style: const TextStyle(
                        color: Color(0xFF1573FE),
                        fontSize: 14,
                        fontFamily: 'Roboto',
                        fontWeight: FontWeight.w400,
                        letterSpacing: 0.25,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 24,
            ),
            CustomProfileContainer(
              child: Column(
                children: [
                  const SizedBox(
                    height: 14,
                  ),
                  CustomProfileItem(
                    title: S.of(context).Security,
                    leading: Image.asset(AppAssets.securityLightImg),
                  ),
                  CustomProfileItem(
                    title: S.of(context).Theme,
                    leading: Image.asset(AppAssets.themeLightImg),
                    trailing: Text(
                      S.of(context).Lightmode,
                      style: const TextStyle(
                        color: Color(0xFF1573FE),
                        fontSize: 14,
                        fontFamily: 'Roboto',
                        fontWeight: FontWeight.w400,
                        letterSpacing: 0.25,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 24,
            ),
            CustomProfileContainer(
              child: Column(
                children: [
                  const SizedBox(
                    height: 14,
                  ),
                  CustomProfileItem(
                    title: S.of(context).HelpSupport,
                    leading: Image.asset(AppAssets.helpAndSupportImg),
                  ),
                  CustomProfileItem(
                    title: S.of(context).Contactus,
                    leading: Image.asset(AppAssets.contactUsImg),
                  ),
                  CustomProfileItem(
                    onTap: () {
                      GoRouter.of(context).push(AppRoutes.kPrivacyView);
                    },
                    title: S.of(context).PrivacyPolicy,
                    leading: Image.asset(AppAssets.privacyImg),
                  ),
                ],
              ),
            ),
            // const SizedBox(
            //   height: 24,
            // ),
          ],
        ),
      ),
    );
  }
}
