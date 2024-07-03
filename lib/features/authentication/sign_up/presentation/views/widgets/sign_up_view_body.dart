import 'package:breast_cancer/core/utils/app_methods.dart';
import 'package:breast_cancer/core/utils/app_routes.dart';
import 'package:breast_cancer/core/utils/validators.dart';
import 'package:breast_cancer/core/widgets/custom_app_bar.dart';
import 'package:breast_cancer/core/widgets/custom_button.dart';
import 'package:breast_cancer/core/widgets/custom_text_field.dart';
import 'package:breast_cancer/core/widgets/loading_widget.dart';
import 'package:breast_cancer/features/authentication/sign_up/sign_up_cubit/sign_up_cubit.dart';
import 'package:breast_cancer/generated/l10n.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class SignUpViewBody extends StatefulWidget {
  final String userType;

  const SignUpViewBody({super.key, required this.userType});

  @override
  State<SignUpViewBody> createState() => _SignUpViewBodyState();
}

class _SignUpViewBodyState extends State<SignUpViewBody> {
  bool obscureText = true;
  late bool currentBool = false;
  late final TextEditingController _nameController,
      _emailController,
      _passwordController,
      _contactNumberController;

  late final FocusNode _nameFocusNode,
      _emailFocusNode,
      _passwordFocusNode,
      _contactNumberFocusNode;
  late final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;
  final auth = FirebaseAuth.instance;

  @override
  void initState() {
    _nameController = TextEditingController();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    _contactNumberController = TextEditingController();

    _nameFocusNode = FocusNode();
    _emailFocusNode = FocusNode();
    _passwordFocusNode = FocusNode();
    _contactNumberFocusNode = FocusNode();

    super.initState();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _contactNumberController.dispose();

    _nameFocusNode.dispose();
    _emailFocusNode.dispose();
    _passwordFocusNode.dispose();
    _contactNumberFocusNode.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SignUpCubit, SignUpState>(
      listener: (context, state) {
        if (state is SignUpSuccess) {
          GoRouter.of(context).push(
            AppRoutes.kRootView,
            extra: widget.userType == 'patient' ? 'patient' : 'doctor',
          );
          _isLoading = false;
        } else if (state is SignUpFailure) {
          AppMethods.showErrorORWarningDialog(
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
                                        ? S.of(context).patientSignUp
                                        : S.of(context).doctorSignUp,
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
                                    controller: _nameController,
                                    focusNode: _nameFocusNode,
                                    textInputAction: TextInputAction.next,
                                    keyboardType: TextInputType.name,
                                    contentPadding: const EdgeInsets.symmetric(
                                        horizontal: 19, vertical: 10),
                                    labelText: S.of(context).EnterYourUsername,
                                    validator: (value) {
                                      return Validators.displayNamevalidator(
                                        value,
                                        context,
                                      );
                                    },
                                    onFieldSubmitted: (value) {
                                      FocusScope.of(context)
                                          .requestFocus(_emailFocusNode);
                                    },
                                  ),
                                  const SizedBox(
                                    height: 11,
                                  ),
                                  CustomTextField(
                                    controller: _emailController,
                                    focusNode: _emailFocusNode,
                                    textInputAction: TextInputAction.next,
                                    keyboardType: TextInputType.emailAddress,
                                    contentPadding: const EdgeInsets.symmetric(
                                        horizontal: 19, vertical: 10),
                                    labelText: S.of(context).EnterYourEmail,
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
                                    controller: _contactNumberController,
                                    focusNode: _contactNumberFocusNode,
                                    textInputAction: TextInputAction.next,
                                    keyboardType: TextInputType.phone,
                                    contentPadding: const EdgeInsets.symmetric(
                                        horizontal: 19, vertical: 10),
                                    labelText:
                                        S.of(context).EnterYourPhoneNumber,
                                    validator: (value) {
                                      return Validators.contactNumberValidator(
                                          value, context);
                                    },
                                  ),
                                  const SizedBox(
                                    height: 11,
                                  ),
                                  CustomTextField(
                                    controller: _passwordController,
                                    focusNode: _passwordFocusNode,
                                    textInputAction: TextInputAction.next,
                                    keyboardType: TextInputType.visiblePassword,
                                    contentPadding: const EdgeInsets.symmetric(
                                        horizontal: 19, vertical: 20),
                                    labelText: S.of(context).EnterYourPassword,
                                    obscureText: obscureText,
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
                                    height: 28,
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    S.of(context).Alreadyhaveanaccount,
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
                                      GoRouter.of(context).pop();
                                    },
                                    child: Text(
                                      S.of(context).Login,
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
                              height: 5,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 17),
                            child: CustomButton(
                              title: S.of(context).continuee,
                              onTap: () async {
                                BlocProvider.of<SignUpCubit>(context)
                                    .registerUser(
                                  formKey: _formKey,
                                  context: context,
                                  emailController: _emailController,
                                  passwordController: _passwordController,
                                  nameController: _nameController,
                                  contactNumberController:
                                      _contactNumberController,
                                  collectionName: widget.userType == 'patient'
                                      ? 'patients'
                                      : 'doctors',
                                );
                              },
                            ),
                          ),
                          const Expanded(
                            child: SizedBox(
                              height: 26,
                            ),
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
