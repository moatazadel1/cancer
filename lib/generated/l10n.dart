// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(_current != null,
        'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(instance != null,
        'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?');
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Let’s get started!`
  String get Lets {
    return Intl.message(
      'Let’s get started!',
      name: 'Lets',
      desc: '',
      args: [],
    );
  }

  /// `Breast Cancer`
  String get BreastCancer {
    return Intl.message(
      'Breast Cancer',
      name: 'BreastCancer',
      desc: '',
      args: [],
    );
  }

  /// `login to enjoy the features we’ve\nprovided, and stay healthy!`
  String get enjoy {
    return Intl.message(
      'login to enjoy the features we’ve\nprovided, and stay healthy!',
      name: 'enjoy',
      desc: '',
      args: [],
    );
  }

  /// `Get started`
  String get getStarted {
    return Intl.message(
      'Get started',
      name: 'getStarted',
      desc: '',
      args: [],
    );
  }

  /// `Login Details`
  String get loginDetails {
    return Intl.message(
      'Login Details',
      name: 'loginDetails',
      desc: '',
      args: [],
    );
  }

  /// `Sign Up Details`
  String get signUpDetails {
    return Intl.message(
      'Sign Up Details',
      name: 'signUpDetails',
      desc: '',
      args: [],
    );
  }

  /// `Patient Login`
  String get patientLogin {
    return Intl.message(
      'Patient Login',
      name: 'patientLogin',
      desc: '',
      args: [],
    );
  }

  /// `Patient Sign Up`
  String get patientSignUp {
    return Intl.message(
      'Patient Sign Up',
      name: 'patientSignUp',
      desc: '',
      args: [],
    );
  }

  /// `Doctor Login`
  String get doctorLogin {
    return Intl.message(
      'Doctor Login',
      name: 'doctorLogin',
      desc: '',
      args: [],
    );
  }

  /// `Doctor Sign Up`
  String get doctorSignUp {
    return Intl.message(
      'Doctor Sign Up',
      name: 'doctorSignUp',
      desc: '',
      args: [],
    );
  }

  /// `Enter Your Username`
  String get EnterYourUsername {
    return Intl.message(
      'Enter Your Username',
      name: 'EnterYourUsername',
      desc: '',
      args: [],
    );
  }

  /// `Enter Your Email`
  String get EnterYourEmail {
    return Intl.message(
      'Enter Your Email',
      name: 'EnterYourEmail',
      desc: '',
      args: [],
    );
  }

  /// `Enter Your Phone Number`
  String get EnterYourPhoneNumber {
    return Intl.message(
      'Enter Your Phone Number',
      name: 'EnterYourPhoneNumber',
      desc: '',
      args: [],
    );
  }

  /// `Enter Your Password`
  String get EnterYourPassword {
    return Intl.message(
      'Enter Your Password',
      name: 'EnterYourPassword',
      desc: '',
      args: [],
    );
  }

  /// `Already have an account?`
  String get Alreadyhaveanaccount {
    return Intl.message(
      'Already have an account?',
      name: 'Alreadyhaveanaccount',
      desc: '',
      args: [],
    );
  }

  /// `Email Address`
  String get emailAdress {
    return Intl.message(
      'Email Address',
      name: 'emailAdress',
      desc: '',
      args: [],
    );
  }

  /// `Display name cannot be empty`
  String get Displaynamecannotbeempty {
    return Intl.message(
      'Display name cannot be empty',
      name: 'Displaynamecannotbeempty',
      desc: '',
      args: [],
    );
  }

  /// `Please enter an email`
  String get Pleaseenteranemail {
    return Intl.message(
      'Please enter an email',
      name: 'Pleaseenteranemail',
      desc: '',
      args: [],
    );
  }

  /// `Please enter a password`
  String get Pleaseenterapassword {
    return Intl.message(
      'Please enter a password',
      name: 'Pleaseenterapassword',
      desc: '',
      args: [],
    );
  }

  /// `Country name cannot be empty`
  String get Countrynamecannotbeempty {
    return Intl.message(
      'Country name cannot be empty',
      name: 'Countrynamecannotbeempty',
      desc: '',
      args: [],
    );
  }

  /// `Please enter a valid country name`
  String get Pleaseenteravalidcountryname {
    return Intl.message(
      'Please enter a valid country name',
      name: 'Pleaseenteravalidcountryname',
      desc: '',
      args: [],
    );
  }

  /// `Gender cannot be empty`
  String get Gendercannotbeempty {
    return Intl.message(
      'Gender cannot be empty',
      name: 'Gendercannotbeempty',
      desc: '',
      args: [],
    );
  }

  /// `Gender can be female or male only`
  String get Gendercanbefemaleormaleonly {
    return Intl.message(
      'Gender can be female or male only',
      name: 'Gendercanbefemaleormaleonly',
      desc: '',
      args: [],
    );
  }

  /// `Please enter a valid email`
  String get Pleaseenteravalidemail {
    return Intl.message(
      'Please enter a valid email',
      name: 'Pleaseenteravalidemail',
      desc: '',
      args: [],
    );
  }

  /// `Display Address must be between 50 and 255 characters`
  String get DisplayAddressmustbebetween50and255characters {
    return Intl.message(
      'Display Address must be between 50 and 255 characters',
      name: 'DisplayAddressmustbebetween50and255characters',
      desc: '',
      args: [],
    );
  }

  /// `Display Address cannot be empty`
  String get DisplayAddresscannotbeempty {
    return Intl.message(
      'Display Address cannot be empty',
      name: 'DisplayAddresscannotbeempty',
      desc: '',
      args: [],
    );
  }

  /// `contactNumber must be 11 characters long`
  String get contactNumbermustbe11characterslong {
    return Intl.message(
      'contactNumber must be 11 characters long',
      name: 'contactNumbermustbe11characterslong',
      desc: '',
      args: [],
    );
  }

  /// `Please enter contactNumber`
  String get PleaseentercontactNumber {
    return Intl.message(
      'Please enter contactNumber',
      name: 'PleaseentercontactNumber',
      desc: '',
      args: [],
    );
  }

  /// `Password must be at least 6 characters long`
  String get Passwordmustbeatleast6characterslong {
    return Intl.message(
      'Password must be at least 6 characters long',
      name: 'Passwordmustbeatleast6characterslong',
      desc: '',
      args: [],
    );
  }

  /// `Display name must be between 3 and 20 characters`
  String get Displaynamemustbebetween3and20characters {
    return Intl.message(
      'Display name must be between 3 and 20 characters',
      name: 'Displaynamemustbebetween3and20characters',
      desc: '',
      args: [],
    );
  }

  /// `Take a Test!`
  String get TakeaTest {
    return Intl.message(
      'Take a Test!',
      name: 'TakeaTest',
      desc: '',
      args: [],
    );
  }

  /// `Scan or Upload your X-ray\nphoto`
  String get ScanorUploadyourrayphoto {
    return Intl.message(
      'Scan or Upload your X-ray\nphoto',
      name: 'ScanorUploadyourrayphoto',
      desc: '',
      args: [],
    );
  }

  /// `Upload`
  String get Upload {
    return Intl.message(
      'Upload',
      name: 'Upload',
      desc: '',
      args: [],
    );
  }

  /// `Profile`
  String get Profile {
    return Intl.message(
      'Profile',
      name: 'Profile',
      desc: '',
      args: [],
    );
  }

  /// `Notifications`
  String get Notifications {
    return Intl.message(
      'Notifications',
      name: 'Notifications',
      desc: '',
      args: [],
    );
  }

  /// `Promotion`
  String get Promotion {
    return Intl.message(
      'Promotion',
      name: 'Promotion',
      desc: '',
      args: [],
    );
  }

  /// `Suggested`
  String get Suggested {
    return Intl.message(
      'Suggested',
      name: 'Suggested',
      desc: '',
      args: [],
    );
  }

  /// `English (US)`
  String get EnglishUS {
    return Intl.message(
      'English (US)',
      name: 'EnglishUS',
      desc: '',
      args: [],
    );
  }

  /// `Language`
  String get Language {
    return Intl.message(
      'Language',
      name: 'Language',
      desc: '',
      args: [],
    );
  }

  /// `Home`
  String get Home {
    return Intl.message(
      'Home',
      name: 'Home',
      desc: '',
      args: [],
    );
  }

  /// `Mandarin`
  String get Mandarin {
    return Intl.message(
      'Mandarin',
      name: 'Mandarin',
      desc: '',
      args: [],
    );
  }

  /// `Spanish`
  String get Spanish {
    return Intl.message(
      'Spanish',
      name: 'Spanish',
      desc: '',
      args: [],
    );
  }

  /// `English (UK)`
  String get EnglishUK {
    return Intl.message(
      'English (UK)',
      name: 'EnglishUK',
      desc: '',
      args: [],
    );
  }

  /// `Russian`
  String get Russian {
    return Intl.message(
      'Russian',
      name: 'Russian',
      desc: '',
      args: [],
    );
  }

  /// `Hindi`
  String get Hindi {
    return Intl.message(
      'Hindi',
      name: 'Hindi',
      desc: '',
      args: [],
    );
  }

  /// `Scan`
  String get Scan {
    return Intl.message(
      'Scan',
      name: 'Scan',
      desc: '',
      args: [],
    );
  }

  /// `French`
  String get French {
    return Intl.message(
      'French',
      name: 'French',
      desc: '',
      args: [],
    );
  }

  /// `Vietnamese`
  String get Vietnamese {
    return Intl.message(
      'Vietnamese',
      name: 'Vietnamese',
      desc: '',
      args: [],
    );
  }

  /// `App updates`
  String get Appupdates {
    return Intl.message(
      'App updates',
      name: 'Appupdates',
      desc: '',
      args: [],
    );
  }

  /// `Indonesia`
  String get Indonesia {
    return Intl.message(
      'Indonesia',
      name: 'Indonesia',
      desc: '',
      args: [],
    );
  }

  /// `Arabic`
  String get Arabic {
    return Intl.message(
      'Arabic',
      name: 'Arabic',
      desc: '',
      args: [],
    );
  }

  /// `Discount Avaiable`
  String get DiscountAvaiable {
    return Intl.message(
      'Discount Avaiable',
      name: 'DiscountAvaiable',
      desc: '',
      args: [],
    );
  }

  /// `Bill Reminder`
  String get BillReminder {
    return Intl.message(
      'Bill Reminder',
      name: 'BillReminder',
      desc: '',
      args: [],
    );
  }

  /// `Payment Request`
  String get PaymentRequest {
    return Intl.message(
      'Payment Request',
      name: 'PaymentRequest',
      desc: '',
      args: [],
    );
  }

  /// `Others`
  String get Others {
    return Intl.message(
      'Others',
      name: 'Others',
      desc: '',
      args: [],
    );
  }

  /// `Vibrate`
  String get Vibrate {
    return Intl.message(
      'Vibrate',
      name: 'Vibrate',
      desc: '',
      args: [],
    );
  }

  /// `New Tips Available`
  String get NewTipsAvailable {
    return Intl.message(
      'New Tips Available',
      name: 'NewTipsAvailable',
      desc: '',
      args: [],
    );
  }

  /// `New Service Available`
  String get NewServiceAvailable {
    return Intl.message(
      'New Service Available',
      name: 'NewServiceAvailable',
      desc: '',
      args: [],
    );
  }

  /// `System & services update`
  String get Systemservicesupdate {
    return Intl.message(
      'System & services update',
      name: 'Systemservicesupdate',
      desc: '',
      args: [],
    );
  }

  /// `Sound`
  String get Sound {
    return Intl.message(
      'Sound',
      name: 'Sound',
      desc: '',
      args: [],
    );
  }

  /// `General Notification`
  String get GeneralNotification {
    return Intl.message(
      'General Notification',
      name: 'GeneralNotification',
      desc: '',
      args: [],
    );
  }

  /// `Theme`
  String get Theme {
    return Intl.message(
      'Theme',
      name: 'Theme',
      desc: '',
      args: [],
    );
  }

  /// `Common`
  String get Common {
    return Intl.message(
      'Common',
      name: 'Common',
      desc: '',
      args: [],
    );
  }

  /// `Failed to update profile`
  String get Failedtoupdateprofile {
    return Intl.message(
      'Failed to update profile',
      name: 'Failedtoupdateprofile',
      desc: '',
      args: [],
    );
  }

  /// `1. Types data we collect`
  String get Typesdatawecollect {
    return Intl.message(
      '1. Types data we collect',
      name: 'Typesdatawecollect',
      desc: '',
      args: [],
    );
  }

  /// `Edit profile`
  String get Editprofile {
    return Intl.message(
      'Edit profile',
      name: 'Editprofile',
      desc: '',
      args: [],
    );
  }

  /// `Privacy Policy`
  String get PrivacyPolicy {
    return Intl.message(
      'Privacy Policy',
      name: 'PrivacyPolicy',
      desc: '',
      args: [],
    );
  }

  /// `Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. \n\nDuis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident.`
  String get Loremipsum {
    return Intl.message(
      'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. \n\nDuis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident.',
      name: 'Loremipsum',
      desc: '',
      args: [],
    );
  }

  /// `SUBMIT`
  String get SUBMIT {
    return Intl.message(
      'SUBMIT',
      name: 'SUBMIT',
      desc: '',
      args: [],
    );
  }

  /// `2. Use of your personal data`
  String get Useofyourpersonaldata {
    return Intl.message(
      '2. Use of your personal data',
      name: 'Useofyourpersonaldata',
      desc: '',
      args: [],
    );
  }

  /// `Sed ut perspiciatis unde omnis iste natus error sit voluptatem accusantium doloremque laudantium, totam rem aperiam, eaque ipsa quae ab illo inventore veritatis et quasi architecto beatae vitae.\n\nNemo enim ipsam voluptatem quia voluptas sit aspernatur aut odit aut fugit.`
  String get Sedutperspiciatis {
    return Intl.message(
      'Sed ut perspiciatis unde omnis iste natus error sit voluptatem accusantium doloremque laudantium, totam rem aperiam, eaque ipsa quae ab illo inventore veritatis et quasi architecto beatae vitae.\n\nNemo enim ipsam voluptatem quia voluptas sit aspernatur aut odit aut fugit.',
      name: 'Sedutperspiciatis',
      desc: '',
      args: [],
    );
  }

  /// `ON`
  String get ON {
    return Intl.message(
      'ON',
      name: 'ON',
      desc: '',
      args: [],
    );
  }

  /// `3. Disclosure of your personal data`
  String get Disclosureofyourpersonaldata {
    return Intl.message(
      '3. Disclosure of your personal data',
      name: 'Disclosureofyourpersonaldata',
      desc: '',
      args: [],
    );
  }

  /// `Login`
  String get Login {
    return Intl.message(
      'Login',
      name: 'Login',
      desc: '',
      args: [],
    );
  }

  /// `At vero eos et accusamus et iusto odio dignissimos ducimus qui blanditiis praesentium voluptatum deleniti atque corrupti quos dolores et quas molestias excepturi sint occaecati cupiditate non provident, similique sunt in culpa qui officia deserunt mollitia animi, id est laborum et dolorum fuga. \n\nEt harum quidem rerum facilis est et expedita distinctio. Nam libero tempore, cum soluta nobis est eligendi optio cumque nihil impedit quo minus id quod maxime placeat facere possimus, omnis voluptas assumenda est, omnis dolor repellendus. \n\nTemporibus autem quibusdam et aut officiis debitis aut rerum necessitatibus saepe eveniet ut et voluptates repudiandae sint et molestiae non recusandae. Itaque earum rerum hic tenetur a sapiente delectus`
  String get Atveroeos {
    return Intl.message(
      'At vero eos et accusamus et iusto odio dignissimos ducimus qui blanditiis praesentium voluptatum deleniti atque corrupti quos dolores et quas molestias excepturi sint occaecati cupiditate non provident, similique sunt in culpa qui officia deserunt mollitia animi, id est laborum et dolorum fuga. \n\nEt harum quidem rerum facilis est et expedita distinctio. Nam libero tempore, cum soluta nobis est eligendi optio cumque nihil impedit quo minus id quod maxime placeat facere possimus, omnis voluptas assumenda est, omnis dolor repellendus. \n\nTemporibus autem quibusdam et aut officiis debitis aut rerum necessitatibus saepe eveniet ut et voluptates repudiandae sint et molestiae non recusandae. Itaque earum rerum hic tenetur a sapiente delectus',
      name: 'Atveroeos',
      desc: '',
      args: [],
    );
  }

  /// `Address`
  String get Address {
    return Intl.message(
      'Address',
      name: 'Address',
      desc: '',
      args: [],
    );
  }

  /// `Genre`
  String get Genre {
    return Intl.message(
      'Genre',
      name: 'Genre',
      desc: '',
      args: [],
    );
  }

  /// `Country`
  String get Country {
    return Intl.message(
      'Country',
      name: 'Country',
      desc: '',
      args: [],
    );
  }

  /// `Full name`
  String get Fullname {
    return Intl.message(
      'Full name',
      name: 'Fullname',
      desc: '',
      args: [],
    );
  }

  /// `Phone number`
  String get Phonenumber {
    return Intl.message(
      'Phone number',
      name: 'Phonenumber',
      desc: '',
      args: [],
    );
  }

  /// `Email address`
  String get Emailaddress {
    return Intl.message(
      'Email address',
      name: 'Emailaddress',
      desc: '',
      args: [],
    );
  }

  /// `Nick name`
  String get Nickname {
    return Intl.message(
      'Nick name',
      name: 'Nickname',
      desc: '',
      args: [],
    );
  }

  /// `Help & Support`
  String get HelpSupport {
    return Intl.message(
      'Help & Support',
      name: 'HelpSupport',
      desc: '',
      args: [],
    );
  }

  /// `Error updating profile`
  String get Errorupdatingprofile {
    return Intl.message(
      'Error updating profile',
      name: 'Errorupdatingprofile',
      desc: '',
      args: [],
    );
  }

  /// `Password`
  String get password {
    return Intl.message(
      'Password',
      name: 'password',
      desc: '',
      args: [],
    );
  }

  /// `Contact us`
  String get Contactus {
    return Intl.message(
      'Contact us',
      name: 'Contactus',
      desc: '',
      args: [],
    );
  }

  /// `Security`
  String get Security {
    return Intl.message(
      'Security',
      name: 'Security',
      desc: '',
      args: [],
    );
  }

  /// `Remember Me`
  String get rememberMe {
    return Intl.message(
      'Remember Me',
      name: 'rememberMe',
      desc: '',
      args: [],
    );
  }

  /// `Profile updated successfully`
  String get Profileupdatedsuccessfully {
    return Intl.message(
      'Profile updated successfully',
      name: 'Profileupdatedsuccessfully',
      desc: '',
      args: [],
    );
  }

  /// `Privacy policy`
  String get Privacypolicy {
    return Intl.message(
      'Privacy policy',
      name: 'Privacypolicy',
      desc: '',
      args: [],
    );
  }

  /// `Forgot Password?`
  String get forgotPass {
    return Intl.message(
      'Forgot Password?',
      name: 'forgotPass',
      desc: '',
      args: [],
    );
  }

  // skipped getter for the 'Editprofile information' key

  /// `Or Sign In With`
  String get orWith {
    return Intl.message(
      'Or Sign In With',
      name: 'orWith',
      desc: '',
      args: [],
    );
  }

  /// `Sign Up`
  String get signUp {
    return Intl.message(
      'Sign Up',
      name: 'signUp',
      desc: '',
      args: [],
    );
  }

  /// `Continue`
  String get continuee {
    return Intl.message(
      'Continue',
      name: 'continuee',
      desc: '',
      args: [],
    );
  }

  /// `Don’t have an account ?`
  String get dontHAccount {
    return Intl.message(
      'Don’t have an account ?',
      name: 'dontHAccount',
      desc: '',
      args: [],
    );
  }

  /// `Please enter your email address to reset your password.`
  String get resetYourPass {
    return Intl.message(
      'Please enter your email address to reset your password.',
      name: 'resetYourPass',
      desc: '',
      args: [],
    );
  }

  /// `A password reset link has been sent to your email.`
  String get resetLink {
    return Intl.message(
      'A password reset link has been sent to your email.',
      name: 'resetLink',
      desc: '',
      args: [],
    );
  }

  /// `An error occurred while sending the reset email`
  String get errorResetEmail {
    return Intl.message(
      'An error occurred while sending the reset email',
      name: 'errorResetEmail',
      desc: '',
      args: [],
    );
  }

  /// `An error has been occured`
  String get error1 {
    return Intl.message(
      'An error has been occured',
      name: 'error1',
      desc: '',
      args: [],
    );
  }

  /// `Google sign-in failed`
  String get googlesigninfailed {
    return Intl.message(
      'Google sign-in failed',
      name: 'googlesigninfailed',
      desc: '',
      args: [],
    );
  }

  /// `Facebook sign-in failed`
  String get Facebooksigninfailed {
    return Intl.message(
      'Facebook sign-in failed',
      name: 'Facebooksigninfailed',
      desc: '',
      args: [],
    );
  }

  /// `Twitter sign-in failed`
  String get twitterfail {
    return Intl.message(
      'Twitter sign-in failed',
      name: 'twitterfail',
      desc: '',
      args: [],
    );
  }

  /// `OK`
  String get Ok {
    return Intl.message(
      'OK',
      name: 'Ok',
      desc: '',
      args: [],
    );
  }

  /// `CANCEL`
  String get CANCEL {
    return Intl.message(
      'CANCEL',
      name: 'CANCEL',
      desc: '',
      args: [],
    );
  }

  /// `Login Successfully`
  String get LoginSuccessfully {
    return Intl.message(
      'Login Successfully',
      name: 'LoginSuccessfully',
      desc: '',
      args: [],
    );
  }

  /// `No user found for that email.`
  String get Nouserfoundforthatemail {
    return Intl.message(
      'No user found for that email.',
      name: 'Nouserfoundforthatemail',
      desc: '',
      args: [],
    );
  }

  /// `Wrong password provided for that user.`
  String get Wrongpasswordprovidedforthatuser {
    return Intl.message(
      'Wrong password provided for that user.',
      name: 'Wrongpasswordprovidedforthatuser',
      desc: '',
      args: [],
    );
  }

  /// `Light mode`
  String get Lightmode {
    return Intl.message(
      'Light mode',
      name: 'Lightmode',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'ar'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
