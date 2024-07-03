import 'package:breast_cancer/generated/l10n.dart';
import 'package:flutter/material.dart';

class PrivacyViewBody extends StatelessWidget {
  const PrivacyViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          S.of(context).PrivacyPolicy,
          textAlign: TextAlign.center,
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
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 30,
              ),
              Text(
                S.of(context).Typesdatawecollect,
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w600,
                  height: 0.09,
                  letterSpacing: 0.10,
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              Text(
                S.of(context).Loremipsum,
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 14,
                  fontFamily: 'Roboto',
                  fontWeight: FontWeight.w400,
                  height: 0,
                  letterSpacing: 0.25,
                ),
              ),
              const SizedBox(
                height: 32,
              ),
              Text(
                S.of(context).Useofyourpersonaldata,
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w600,
                  height: 0.09,
                  letterSpacing: 0.10,
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              Text(
                S.of(context).Sedutperspiciatis,
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 14,
                  fontFamily: 'Roboto',
                  fontWeight: FontWeight.w400,
                  height: 0,
                  letterSpacing: 0.25,
                ),
              ),
              const SizedBox(
                height: 32,
              ),
              Text(
                S.of(context).Disclosureofyourpersonaldata,
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w600,
                  height: 0.09,
                  letterSpacing: 0.10,
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              Text(
                S.of(context).Atveroeos,
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 14,
                  fontFamily: 'Roboto',
                  fontWeight: FontWeight.w400,
                  height: 0,
                  letterSpacing: 0.25,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
