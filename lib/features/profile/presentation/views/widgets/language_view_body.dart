import 'package:breast_cancer/core/utils/app_routes.dart';
import 'package:breast_cancer/features/profile/presentation/view_model/language_provider.dart';
import 'package:breast_cancer/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class LanguageViewBody extends StatefulWidget {
  const LanguageViewBody({super.key});

  @override
  State<LanguageViewBody> createState() => _LanguageViewBodyState();
}

class _LanguageViewBodyState extends State<LanguageViewBody> {
  ChoosingLanguage _language = ChoosingLanguage.englishUS;

  @override
  void initState() {
    super.initState();
    _language =
        Provider.of<LanguageProvider>(context, listen: false).selectedLanguage;
  }

  @override
  Widget build(BuildContext context) {
    var languageProvider = Provider.of<LanguageProvider>(context);

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        automaticallyImplyLeading: false,
        title: Text(
          S.of(context).Language,
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
                height: 49,
              ),
              Text(
                S.of(context).Suggested,
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
              RadioListTile<ChoosingLanguage>(
                contentPadding: const EdgeInsets.all(0),
                controlAffinity: ListTileControlAffinity.trailing,
                title: Text(S.of(context).EnglishUS,
                    style: const TextStyle(fontSize: 14)),
                value: ChoosingLanguage.englishUS,
                groupValue: _language,
                onChanged: (ChoosingLanguage? value) {
                  setState(() {
                    _language = value!;
                  });
                  languageProvider.setLanguage(value!);
                  GoRouter.of(context).push(AppRoutes.kRootView);
                },
              ),
              RadioListTile<ChoosingLanguage>(
                hoverColor: Colors.white,
                contentPadding: const EdgeInsets.all(0),
                controlAffinity: ListTileControlAffinity.trailing,
                title: Text(S.of(context).Arabic,
                    style: const TextStyle(fontSize: 14)),
                value: ChoosingLanguage.arabic,
                groupValue: _language,
                onChanged: (ChoosingLanguage? value) {
                  setState(() {
                    _language = value!;
                  });
                  languageProvider.setLanguage(value!);
                  GoRouter.of(context).push(AppRoutes.kRootView);
                },
              ), // const SizedBox(
              //   height: 31,
              // ),
              Container(
                decoration: const ShapeDecoration(
                  shape: RoundedRectangleBorder(
                    side: BorderSide(
                      width: 1,
                      strokeAlign: BorderSide.strokeAlignCenter,
                      color: Color(0xFFEEEEEE),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 21,
              ),
              Text(
                S.of(context).Others,
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
              SizedBox(
                height: 20,
                child: RadioListTile<ChoosingLanguage>(
                  contentPadding: const EdgeInsets.all(0),
                  controlAffinity: ListTileControlAffinity.trailing,
                  title: Text(
                    S.of(context).Mandarin,
                    style: const TextStyle(fontSize: 14),
                  ),
                  value: ChoosingLanguage.mandarin,
                  groupValue: _language,
                  onChanged: (ChoosingLanguage? value) {
                    _language = value!;
                  },
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                height: 20,
                child: RadioListTile<ChoosingLanguage>(
                  contentPadding: const EdgeInsets.all(0),
                  controlAffinity: ListTileControlAffinity.trailing,
                  title: Text(
                    S.of(context).Hindi,
                    style: const TextStyle(fontSize: 14),
                  ),
                  value: ChoosingLanguage.hindi,
                  groupValue: _language,
                  onChanged: (ChoosingLanguage? value) {
                    _language = value!;
                  },
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                height: 20,
                child: RadioListTile<ChoosingLanguage>(
                  contentPadding: const EdgeInsets.all(0),
                  controlAffinity: ListTileControlAffinity.trailing,
                  title: Text(
                    S.of(context).Spanish,
                    style: const TextStyle(fontSize: 14),
                  ),
                  value: ChoosingLanguage.spanish,
                  groupValue: _language,
                  onChanged: (ChoosingLanguage? value) {
                    _language = value!;
                  },
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                height: 20,
                child: RadioListTile<ChoosingLanguage>(
                  contentPadding: const EdgeInsets.all(0),
                  controlAffinity: ListTileControlAffinity.trailing,
                  title: Text(
                    S.of(context).French,
                    style: const TextStyle(fontSize: 14),
                  ),
                  value: ChoosingLanguage.french,
                  groupValue: _language,
                  onChanged: (ChoosingLanguage? value) {
                    _language = value!;
                  },
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                height: 20,
                child: RadioListTile<ChoosingLanguage>(
                  contentPadding: const EdgeInsets.all(0),
                  controlAffinity: ListTileControlAffinity.trailing,
                  title: Text(
                    S.of(context).EnglishUK,
                    style: const TextStyle(fontSize: 14),
                  ),
                  value: ChoosingLanguage.englishUk,
                  groupValue: _language,
                  onChanged: (ChoosingLanguage? value) {
                    _language = value!;
                  },
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                height: 20,
                child: RadioListTile<ChoosingLanguage>(
                  contentPadding: const EdgeInsets.all(0),
                  controlAffinity: ListTileControlAffinity.trailing,
                  title: Text(
                    S.of(context).Russian,
                    style: const TextStyle(fontSize: 14),
                  ),
                  value: ChoosingLanguage.russian,
                  groupValue: _language,
                  onChanged: (ChoosingLanguage? value) {
                    _language = value!;
                  },
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                height: 20,
                child: RadioListTile<ChoosingLanguage>(
                  contentPadding: const EdgeInsets.all(0),
                  controlAffinity: ListTileControlAffinity.trailing,
                  title: Text(
                    S.of(context).Indonesia,
                    style: const TextStyle(fontSize: 14),
                  ),
                  value: ChoosingLanguage.indonesia,
                  groupValue: _language,
                  onChanged: (ChoosingLanguage? value) {
                    _language = value!;
                  },
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                height: 20,
                child: RadioListTile<ChoosingLanguage>(
                  contentPadding: const EdgeInsets.all(0),
                  controlAffinity: ListTileControlAffinity.trailing,
                  title: Text(
                    S.of(context).Vietnamese,
                    style: const TextStyle(fontSize: 14),
                  ),
                  value: ChoosingLanguage.vietnamese,
                  groupValue: _language,
                  onChanged: (ChoosingLanguage? value) {
                    _language = value!;
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// choosing_language.dart
enum ChoosingLanguage {
  englishUS,
  arabic,
  mandarin,
  hindi,
  spanish,
  french,
  englishUk,
  russian,
  indonesia,
  vietnamese,
}
