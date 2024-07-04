import 'package:breast_cancer/core/utils/app_routes.dart';
import 'package:breast_cancer/features/authentication/model/user_model.dart';
import 'package:breast_cancer/features/profile/presentation/view_model/language_provider.dart';
import 'package:breast_cancer/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'features/profile/presentation/view_model/pdf_provider.dart';
import 'generated/l10n.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  final pdfState = PdfState();
  await pdfState.loadPdfPath(); // Ensure the PDF path is loaded

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => UserProvider()),
        ChangeNotifierProvider(create: (context) => LanguageProvider()),
        ChangeNotifierProvider(
            create: (context) => pdfState), // Provide the loaded PdfState here
      ],
      child: const BreastCancer(),
    ),
  );
}

class BreastCancer extends StatelessWidget {
  const BreastCancer({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<LanguageProvider>(
      builder: (context, languageProvider, child) {
        return MaterialApp.router(
          theme: ThemeData(
            scaffoldBackgroundColor: Colors.white,
            appBarTheme: const AppBarTheme(backgroundColor: Colors.white)
          ),
          locale: languageProvider.locale,
          localizationsDelegates: const [
            S.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: S.delegate.supportedLocales,
          debugShowCheckedModeBanner: false,
          routerConfig: AppRoutes.router,
        );
      },
    );
  }
}
