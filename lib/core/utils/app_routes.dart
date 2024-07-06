import 'package:breast_cancer/features/authentication/log_in/log_in_cubit/log_in_cubit.dart';
import 'package:breast_cancer/features/authentication/log_in/presentation/views/login_view.dart';
import 'package:breast_cancer/features/authentication/sign_up/presentation/views/sign_up_view.dart';
import 'package:breast_cancer/features/authentication/sign_up/sign_up_cubit/sign_up_cubit.dart';
import 'package:breast_cancer/features/home/presentation/views/home_view.dart';
import 'package:breast_cancer/features/home/presentation/views/result_view.dart';
import 'package:breast_cancer/features/join_us/presentation/views/join_us_screen.dart';
import 'package:breast_cancer/features/on_boarding/presentation/views/on_boarding_view.dart';
import 'package:breast_cancer/features/profile/presentation/views/language_view.dart';
import 'package:breast_cancer/features/profile/presentation/views/notification_view.dart';
import 'package:breast_cancer/features/profile/presentation/views/privacy_view.dart';
import 'package:breast_cancer/features/profile/presentation/views/profile_view.dart';
import 'package:breast_cancer/features/profile/presentation/views/widgets/doctor_access_view.dart';
import 'package:breast_cancer/features/profile/presentation/views/widgets/edit_profile.dart';
import 'package:breast_cancer/features/profile/presentation/views/widgets/patient_access_view.dart';
import 'package:breast_cancer/features/profile/presentation/views/widgets/pdf_view.dart';
import 'package:breast_cancer/features/splash/presentation/views/splash_view.dart';
import 'package:breast_cancer/root_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../features/profile/presentation/views/widgets/edit_pdf_view.dart';
import '../widgets/edit_info_screen.dart';

abstract class AppRoutes {
  static const String kOnBoardingView = '/onBoardingView';
  static const String kHomeView = '/homeView';
  static const String kLoginView = '/LoginView';
  static const String kSignUpView = '/SignUpView';
  static const String kRootView = '/RootView';
  static const String kLanguageView = '/LanguageView';
  static const String kNotificationView = '/NotificationView';
  static const String kProfileView = '/ProfileView';
  static const String kEditProfileView = '/EditProfileView';
  static const String kResultView = '/ResultView';
  static const String kPrivacyView = '/PrivacyView';
  static const String kJoinAsView = '/JoinAsView';
  static const String kPdfView = '/PdfView';
  static const String kDoctorAccessView = '/DoctorAccessView';
  static const String kPatientAccessView = '/PatientAccessView';
  static const String kEditInfoView = '/EditInfoView';
  static const String kEditPdfView = '/EditPdfView';


  static final router = GoRouter(
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => const SplashView(),
      ),
      GoRoute(
        path: kOnBoardingView,
        builder: (context, state) => const OnBoardingView(),
      ),
      GoRoute(
        path: kLoginView,
        builder: (context, state) {
          final userType = state.extra as String;
          return BlocProvider(
            create: (context) => LogInCubit(),
            child: LoginView(userType: userType),
          );
        },
      ),
      GoRoute(
        path: kSignUpView,
        builder: (context, state) {
          final userType = state.extra as String;
          return BlocProvider(
            create: (context) => SignUpCubit(),
            child: SignUpView(userType: userType),
          );
        },
      ),
      GoRoute(
          path: kRootView,
          builder: (context, state) {
            final userType = state.extra as String;
            return RootView(userType: userType);
          }),
      GoRoute(
          path: kHomeView,
          builder: (context, state) {
            final userType = state.extra as String;
            return HomeView(userType: userType);
          }),
      GoRoute(
        path: kLanguageView,
        builder: (context, state) => const LanguageView(),
      ),
      GoRoute(
          path: kProfileView,
          builder: (context, state) {
            final userType = state.extra as String;
            return ProfileView(userType: userType);
          }),
      GoRoute(
        path: kNotificationView,
        builder: (context, state) => const NotificationView(),
      ),
      GoRoute(
          path: kEditProfileView,
          builder: (context, state) {
            final userType = state.extra as String;
            return EditProfile(userType: userType);
          }),
      GoRoute(
          path: kResultView,
          builder: (context, state) {
            final userType = state.extra as String;
            return ResultView(
              userType: userType,
              imageUrl: '',
            );
          }),
      GoRoute(
        path: kPrivacyView,
        builder: (context, state) => const PrivacyView(),
      ),
      GoRoute(
        path: kJoinAsView,
        builder: (context, state) => const JoinAsScreen(),
      ),
      GoRoute(
          path: kPdfView,
          builder: (context, state) {
            final args = state.extra as PdfViewArguments;

            return  PdfView(
              userType: args.userType,
              patientId: args.patientId,
              pdfPath: args.pdfPath,
            );
          }),
      GoRoute(
        path: kDoctorAccessView,
        builder: (context, state) {
          final pdfPath = state.extra as String;
          return  DoctorAccessView(
            pdfPath: pdfPath,
          );
  },),
      GoRoute(
          path: kPatientAccessView,
          builder: (context, state) {
            final pdfPath = state.extra as String;
            return   PatientAccessView(
              // pdfPath: pdfPath,
            );
          }
      ),
      GoRoute(
        path: kEditPdfView,
        name: AppRoutes.kEditPdfView,
        builder: (context, state) {
          final patientId = state.extra as String;
          return EditPdfScreen(patientId: patientId);
        },
      ),
      GoRoute(
        path: kEditInfoView,
        builder: (context, state) {
          final args = state.extra as EditInfoScreenArguments?;
          if (args == null) {
            // Handle the case where args is null
            return const Scaffold(
              body: Center(
                child: Text('No arguments provided'),
              ),
            );
          }
          return EditInfoScreen(args: args);
        },
      ),
    ],
  );
}
