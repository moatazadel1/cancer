import 'package:breast_cancer/core/utils/app_assets.dart';
import 'package:breast_cancer/core/utils/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../generated/l10n.dart';
import 'widgets/custom_join_as_container.dart';

class JoinAsScreen extends StatelessWidget {
  const JoinAsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.only(right: 20, left: 20),
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(
                  height: 79,
                ),
                SizedBox(
                  width: 182,
                  child: Text(
                    S.of(context).welcome,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 32,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w600,
                      height: 0,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 12,
                ),
                Image.asset(
                  AppAssets.joinAsImg,
                  height: MediaQuery.sizeOf(context).height * 0.4,
                ),
                const SizedBox(
                  height: 55,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Align(
                    // alignment: Alignment.centerLeft,
                    child: Text(
                      S.of(context).Loginasa,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 25,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w600,
                        height: 0,
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 22,
                ),
                GestureDetector(
                  onTap: () {
                    GoRouter.of(context)
                        .push(AppRoutes.kLoginView, extra: 'patient');
                  },
                  child: CustomJoinAsContainer(
                      textName: Text(
                    S.of(context).PATIENT,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 25,
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w600,
                      height: 0,
                    ),
                  )),
                ),
                const SizedBox(
                  height: 47,
                ),
                GestureDetector(
                  onTap: () {
                    GoRouter.of(context)
                        .push(AppRoutes.kLoginView, extra: 'doctor');
                  },
                  child: CustomJoinAsContainer(
                      textName: Text(
                    S.of(context).DOCTOR,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 25,
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w600,
                      height: 0,
                    ),
                  )),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
