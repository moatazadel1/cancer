import 'package:breast_cancer/core/utils/app_assets.dart';
import 'package:breast_cancer/core/utils/app_methods.dart';
import 'package:breast_cancer/core/utils/app_routes.dart';
import 'package:breast_cancer/core/utils/validators.dart';
import 'package:breast_cancer/core/widgets/custom_app_bar.dart';
import 'package:breast_cancer/core/widgets/custom_button.dart';
import 'package:breast_cancer/core/widgets/custom_container_for_logo.dart';
import 'package:breast_cancer/core/widgets/custom_text_field.dart';
import 'package:breast_cancer/core/widgets/loading_widget.dart';
import 'package:breast_cancer/features/authentication/log_in/log_in_cubit/log_in_cubit.dart';
import 'package:breast_cancer/generated/l10n.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:twitter_login/twitter_login.dart';

class LoginViewBody extends StatefulWidget {
  final String userType;

  const LoginViewBody({super.key, required this.userType});

  @override
  State<LoginViewBody> createState() => _LoginViewBodyState();
}

class _LoginViewBodyState extends State<LoginViewBody> {
  late final TextEditingController _emailController;
  late final TextEditingController _passwordController;
  late final FocusNode _emailFocusNode;
  late final FocusNode _passwordFocusNode;
  late final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;
  final auth = FirebaseAuth.instance;
  bool obscureText = true;
  late bool currentBool = false;

  @override
  void initState() {
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    _emailFocusNode = FocusNode();
    _passwordFocusNode = FocusNode();
    super.initState();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _emailFocusNode.dispose();
    _passwordFocusNode.dispose();
    super.dispose();
  }

  Future<void> _resetPassword() async {
    if (_emailController.text.isEmpty) {
      AppMethods.showErrorORWarningDialog(
        context: context,        img : AppAssets.warningImg,

        subtitle: S.of(context).resetYourPass,
        fct: () {},
      );
      return;
    }

    try {
      await auth.sendPasswordResetEmail(email: _emailController.text);
      if (!mounted) return;
      Fluttertoast.showToast(
        msg: S.of(context).resetLink,
        toastLength: Toast.LENGTH_SHORT,
        textColor: Colors.white,
      );
    } catch (e) {
      AppMethods.showErrorORWarningDialog(
        img : AppAssets.warningImg,

        context: context,
        subtitle: "${S.of(context).errorResetEmail} ${e.toString()}",
        fct: () {},
      );
    }
  }

  Future<void> _signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      if (googleUser == null) return; // User cancelled the sign-in

      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;
      final OAuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      await auth.signInWithCredential(credential);
      if (!mounted) return;
      GoRouter.of(context).push(AppRoutes.kRootView);
    } catch (e) {
      AppMethods.showErrorORWarningDialog(
        img : AppAssets.warningImg,

        context: context,
        subtitle: S.of(context).googlesigninfailed,
        fct: () {},
      );
    }
  }

  Future<void> _signInWithFacebook() async {
    try {
      final LoginResult result = await FacebookAuth.instance.login();
      if (result.status == LoginStatus.success) {
        final OAuthCredential credential =
            FacebookAuthProvider.credential(result.accessToken!.tokenString);
        await auth.signInWithCredential(credential);
        if (!mounted) return;
        GoRouter.of(context).push(AppRoutes.kRootView);
      } else {
        if (!mounted) return;
        AppMethods.showErrorORWarningDialog(
          img : AppAssets.warningImg,

          context: context,
          subtitle: S.of(context).Facebooksigninfailed,
          fct: () {},
        );
      }
    } catch (e) {
      AppMethods.showErrorORWarningDialog(
        img : AppAssets.warningImg,

        context: context,
        subtitle: S.of(context).Facebooksigninfailed,
        fct: () {},
      );
    }
  }

  Future<void> _signInWithTwitter() async {
    try {
      final twitterLogin = TwitterLogin(
        apiKey: 'your-twitter-api-key',
        apiSecretKey: 'your-twitter-api-secret-key',
        redirectURI: 'your-twitter-redirect-uri',
      );

      final authResult = await twitterLogin.login();
      if (authResult.status == TwitterLoginStatus.loggedIn) {
        final OAuthCredential credential = TwitterAuthProvider.credential(
          accessToken: authResult.authToken!,
          secret: authResult.authTokenSecret!,
        );
        await auth.signInWithCredential(credential);
        if (!mounted) return;
        GoRouter.of(context).push(AppRoutes.kRootView);
      } else {
        if (!mounted) return;

        AppMethods.showErrorORWarningDialog(
          img : AppAssets.warningImg,

          context: context,
          subtitle: S.of(context).twitterfail,
          fct: () {},
        );
      }
    } catch (e) {
      AppMethods.showErrorORWarningDialog(
        img : AppAssets.warningImg,

        context: context,
        subtitle: S.of(context).twitterfail,
        fct: () {},
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LogInCubit, LogInState>(
      listener: (context, state) {
        if (state is LogInSuccess) {
          GoRouter.of(context).push(AppRoutes.kRootView,
              extra: widget.userType == 'patient' ? 'patient' : 'doctor');
          _isLoading = false;
        } else if (state is LogInFailure) {
          AppMethods.showErrorORWarningDialog(
            img : AppAssets.warningImg,

            context: context,
            subtitle: "${S.of(context).error1} ${state.errMessage}",
            fct: () {},
          );
          _isLoading = false;
        } else {
          //Loading State
          _isLoading = true;
        }
      },
      builder: (context, state) {
        return GestureDetector(
          onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
          child: Scaffold(
            body: LoadingWidget(
              isLoading: _isLoading,
              child: SafeArea(
                child: CustomScrollView(
                  slivers: [
                    SliverFillRemaining(
                      hasScrollBody: false,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const CustomAppBar(),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 23),
                            child: Form(
                              key: _formKey,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    widget.userType == 'patient'
                                        ? S.of(context).patientLogin
                                        : S.of(context).doctorLogin,
                                    style: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 24,
                                      fontFamily: 'Outfit',
                                      fontWeight: FontWeight.w500,
                                      height: 0,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 18,
                                  ),
                                  CustomTextField(
                                    controller: _emailController,
                                    keyboardType: TextInputType.emailAddress,
                                    focusNode: _emailFocusNode,
                                    textInputAction: TextInputAction.next,
                                    contentPadding: const EdgeInsets.symmetric(
                                        horizontal: 19, vertical: 20),
                                    labelText: S.of(context).Emailaddress,
                                    validator: (value) {
                                      return Validators.emailValidator(
                                          value, context);
                                    },
                                    onFieldSubmitted: (value) {
                                      FocusScope.of(context)
                                          .requestFocus(_passwordFocusNode);
                                    },
                                  ),
                                  const SizedBox(
                                    height: 11,
                                  ),
                                  CustomTextField(
                                    controller: _passwordController,
                                    focusNode: _passwordFocusNode,
                                    obscureText: obscureText,
                                    textInputAction: TextInputAction.none,
                                    keyboardType: TextInputType.visiblePassword,
                                    contentPadding: const EdgeInsets.symmetric(
                                        horizontal: 19, vertical: 20),
                                    labelText: S.of(context).password,
                                    suffixIcon: IconButton(
                                      onPressed: () {
                                        setState(() {
                                          obscureText = !obscureText;
                                        });
                                      },
                                      icon: Icon(
                                        obscureText
                                            ? Icons.visibility
                                            : Icons.visibility_off,
                                      ),
                                    ),
                                    validator: (value) {
                                      return Validators.passwordValidator(
                                          value, context);
                                    },
                                  ),
                                  const SizedBox(
                                    height: 25,
                                  ),
                                  Row(
                                    children: [
                                      Checkbox(
                                        value: currentBool,
                                        onChanged: (newValue) {
                                          setState(() {
                                            currentBool = newValue!;
                                          });
                                        },
                                        activeColor: Colors.white,
                                        checkColor: Colors.black,
                                        side: const BorderSide(
                                            color: Colors.grey),
                                      ),
                                      Text(
                                        S.of(context).rememberMe,
                                        style: const TextStyle(
                                          color: Color(0xFF000C14),
                                          fontSize: 15,
                                          fontFamily: 'Manrope',
                                          fontWeight: FontWeight.w500,
                                          height: 0,
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 47,
                                      ),
                                      GestureDetector(
                                        onTap: _resetPassword,
                                        child: Text(
                                          S.of(context).forgotPass,
                                          style: const TextStyle(
                                            color: Color(0xFFE76969),
                                            fontSize: 15,
                                            fontFamily: 'Poppins',
                                            fontWeight: FontWeight.w500,
                                            height: 0,
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 47,
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 7),
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: Container(
                                        height: 3,
                                        decoration: const BoxDecoration(
                                          gradient: LinearGradient(
                                            begin: Alignment(-1.00, -0.00),
                                            end: Alignment(1, 0),
                                            colors: [
                                              Color(0xFFFFD3CA),
                                              Color(0x00C4C4C4)
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                    Text(
                                      S.of(context).orWith,
                                      style: const TextStyle(
                                        color: Color(0xFF555151),
                                        fontSize: 12,
                                        fontFamily: 'Outfit',
                                        fontWeight: FontWeight.w500,
                                        height: 0,
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 17,
                                    ),
                                    Expanded(
                                      child: Container(
                                        height: 3,
                                        decoration: const BoxDecoration(
                                          gradient: LinearGradient(
                                            begin: Alignment(-1.00, -0.00),
                                            end: Alignment(1, 0),
                                            colors: [
                                              Color(0xFFFFD3CA),
                                              Color(0x00C4C4C4)
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(
                                height: 38,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  CustomContainerForLogo(
                                    onTap: _signInWithGoogle,
                                    child: Image.asset(AppAssets.googleLogoImg),
                                  ),
                                  CustomContainerForLogo(
                                    onTap: _signInWithFacebook,
                                    child:
                                        Image.asset(AppAssets.facbookLogoImg),
                                  ),
                                  CustomContainerForLogo(
                                    onTap: _signInWithTwitter,
                                    child:
                                        Image.asset(AppAssets.twitterLogoImg),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 23,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    S.of(context).dontHAccount,
                                    style: const TextStyle(
                                      color: Color(0xFF0D0D0D),
                                      fontSize: 16,
                                      fontFamily: 'Manrope',
                                      fontWeight: FontWeight.w600,
                                      height: 0,
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      widget.userType == 'patient'
                                          ? GoRouter.of(context).push(
                                              AppRoutes.kSignUpView,
                                              extra: 'patient')
                                          : GoRouter.of(context).push(
                                              AppRoutes.kSignUpView,
                                              extra: 'doctor');
                                    },
                                    child: Text(
                                      S.of(context).signUp,
                                      style: const TextStyle(
                                        color: Color(0xFFE76969),
                                        fontSize: 16,
                                        fontFamily: 'Manrope',
                                        fontWeight: FontWeight.w600,
                                        height: 0,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          const Expanded(
                              child: SizedBox(
                            height: 40,
                          )),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 17),
                            child: CustomButton(
                              title: S.of(context).continuee,
                              onTap: () {
                                BlocProvider.of<LogInCubit>(context).loginUser(
                                    context: context,
                                    formKey: _formKey,
                                    emailController: _emailController,
                                    passwordController: _passwordController);
                              },
                            ),
                          ),
                          const SizedBox(
                            height: 24,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
