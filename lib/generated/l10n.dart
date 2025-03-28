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
    assert(
      _current != null,
      'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.',
    );
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name =
        (locale.countryCode?.isEmpty ?? false)
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
    assert(
      instance != null,
      'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?',
    );
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Pulse`
  String get appName {
    return Intl.message('Pulse', name: 'appName', desc: '', args: []);
  }

  /// `Poppins`
  String get appFontFamily {
    return Intl.message('Poppins', name: 'appFontFamily', desc: '', args: []);
  }

  /// `Choose App theme mode:`
  String get chooseThemeMode {
    return Intl.message(
      'Choose App theme mode:',
      name: 'chooseThemeMode',
      desc: '',
      args: [],
    );
  }

  /// `Light Mode`
  String get themeLightMode {
    return Intl.message(
      'Light Mode',
      name: 'themeLightMode',
      desc: '',
      args: [],
    );
  }

  /// `Dark Mode`
  String get themeDarkMode {
    return Intl.message('Dark Mode', name: 'themeDarkMode', desc: '', args: []);
  }

  /// `Welcome to`
  String get authStartupFirstText {
    return Intl.message(
      'Welcome to',
      name: 'authStartupFirstText',
      desc: '',
      args: [],
    );
  }

  /// `A place where you can reach all your friends`
  String get authStartupSecondText {
    return Intl.message(
      'A place where you can reach all your friends',
      name: 'authStartupSecondText',
      desc: '',
      args: [],
    );
  }

  /// `Let's Get Started`
  String get authStartupThirdText {
    return Intl.message(
      'Let\'s Get Started',
      name: 'authStartupThirdText',
      desc: '',
      args: [],
    );
  }

  /// `Continue with Google`
  String get authStartupFirstButtonText {
    return Intl.message(
      'Continue with Google',
      name: 'authStartupFirstButtonText',
      desc: '',
      args: [],
    );
  }

  /// `Continue with Email`
  String get authStartupSecondButtonText {
    return Intl.message(
      'Continue with Email',
      name: 'authStartupSecondButtonText',
      desc: '',
      args: [],
    );
  }

  /// `Already have an account?`
  String get authStartupHaveAnAccount {
    return Intl.message(
      'Already have an account?',
      name: 'authStartupHaveAnAccount',
      desc: '',
      args: [],
    );
  }

  /// `Login`
  String get authStartupLoginButtonText {
    return Intl.message(
      'Login',
      name: 'authStartupLoginButtonText',
      desc: '',
      args: [],
    );
  }

  /// `Register`
  String get registerFirstText {
    return Intl.message(
      'Register',
      name: 'registerFirstText',
      desc: '',
      args: [],
    );
  }

  /// `account `
  String get registerAccountText {
    return Intl.message(
      'account ',
      name: 'registerAccountText',
      desc: '',
      args: [],
    );
  }

  /// `Create an `
  String get registerCreateText {
    return Intl.message(
      'Create an ',
      name: 'registerCreateText',
      desc: '',
      args: [],
    );
  }

  /// `to access all the\nfeatures of `
  String get registerCreateSecondText {
    return Intl.message(
      'to access all the\nfeatures of ',
      name: 'registerCreateSecondText',
      desc: '',
      args: [],
    );
  }

  /// `Email Address`
  String get registerTffEmail {
    return Intl.message(
      'Email Address',
      name: 'registerTffEmail',
      desc: '',
      args: [],
    );
  }

  /// `Ex: ZDZPf@example.com`
  String get registerTffEmailHint {
    return Intl.message(
      'Ex: ZDZPf@example.com',
      name: 'registerTffEmailHint',
      desc: '',
      args: [],
    );
  }

  /// `Your Password`
  String get registerTffPassword {
    return Intl.message(
      'Your Password',
      name: 'registerTffPassword',
      desc: '',
      args: [],
    );
  }

  /// `Confirm Your Password`
  String get registerTffConfirmPassword {
    return Intl.message(
      'Confirm Your Password',
      name: 'registerTffConfirmPassword',
      desc: '',
      args: [],
    );
  }

  /// `********`
  String get registerTffPasswordHint {
    return Intl.message(
      '********',
      name: 'registerTffPasswordHint',
      desc: '',
      args: [],
    );
  }

  /// `Your Name`
  String get registerTffName {
    return Intl.message(
      'Your Name',
      name: 'registerTffName',
      desc: '',
      args: [],
    );
  }

  /// `Ex. John Doe`
  String get registerTffNameHint {
    return Intl.message(
      'Ex. John Doe',
      name: 'registerTffNameHint',
      desc: '',
      args: [],
    );
  }

  /// `Login now to contact with all your friends\nat a place!`
  String get loginFirstText {
    return Intl.message(
      'Login now to contact with all your friends\nat a place!',
      name: 'loginFirstText',
      desc: '',
      args: [],
    );
  }

  /// `Forgot Password?`
  String get loginForgetPassword {
    return Intl.message(
      'Forgot Password?',
      name: 'loginForgetPassword',
      desc: '',
      args: [],
    );
  }

  /// `Don't have an account?`
  String get loginNotHaveAccount {
    return Intl.message(
      'Don\'t have an account?',
      name: 'loginNotHaveAccount',
      desc: '',
      args: [],
    );
  }

  /// `Chats`
  String get drawerChats {
    return Intl.message('Chats', name: 'drawerChats', desc: '', args: []);
  }

  /// `Settings`
  String get drawerSettings {
    return Intl.message('Settings', name: 'drawerSettings', desc: '', args: []);
  }

  /// `Log Out`
  String get drawerLogout {
    return Intl.message('Log Out', name: 'drawerLogout', desc: '', args: []);
  }

  /// `Logged out successfully`
  String get loggedOutSuccess {
    return Intl.message(
      'Logged out successfully',
      name: 'loggedOutSuccess',
      desc: '',
      args: [],
    );
  }

  /// `No messages yet, start a conversation`
  String get noMessages {
    return Intl.message(
      'No messages yet, start a conversation',
      name: 'noMessages',
      desc: '',
      args: [],
    );
  }

  /// `No blocked users`
  String get noBlockedUsers {
    return Intl.message(
      'No blocked users',
      name: 'noBlockedUsers',
      desc: '',
      args: [],
    );
  }

  /// `Blocked Users`
  String get blockedUsers {
    return Intl.message(
      'Blocked Users',
      name: 'blockedUsers',
      desc: '',
      args: [],
    );
  }

  /// `Theme Mode`
  String get themeMode {
    return Intl.message('Theme Mode', name: 'themeMode', desc: '', args: []);
  }

  /// `Language`
  String get language {
    return Intl.message('Language', name: 'language', desc: '', args: []);
  }

  /// `Light`
  String get lightMode {
    return Intl.message('Light', name: 'lightMode', desc: '', args: []);
  }

  /// `Dark`
  String get darkMode {
    return Intl.message('Dark', name: 'darkMode', desc: '', args: []);
  }

  /// `English`
  String get english {
    return Intl.message('English', name: 'english', desc: '', args: []);
  }

  /// `Arabic`
  String get arabic {
    return Intl.message('Arabic', name: 'arabic', desc: '', args: []);
  }

  /// `Settings`
  String get settings {
    return Intl.message('Settings', name: 'settings', desc: '', args: []);
  }

  /// `No user logged in`
  String get noUserLoggedIn {
    return Intl.message(
      'No user logged in',
      name: 'noUserLoggedIn',
      desc: '',
      args: [],
    );
  }

  /// `Log Out`
  String get logOut {
    return Intl.message('Log Out', name: 'logOut', desc: '', args: []);
  }

  /// `{name} unblocked successfully`
  String unblockedSuccess(Object name) {
    return Intl.message(
      '$name unblocked successfully',
      name: 'unblockedSuccess',
      desc: '',
      args: [name],
    );
  }

  /// `Password does not match`
  String get passwordMismatch {
    return Intl.message(
      'Password does not match',
      name: 'passwordMismatch',
      desc: '',
      args: [],
    );
  }

  /// `Please fill all the fields`
  String get fillAllFieldsError {
    return Intl.message(
      'Please fill all the fields',
      name: 'fillAllFieldsError',
      desc: '',
      args: [],
    );
  }

  /// `Account created successfully`
  String get accountCreatedSuccess {
    return Intl.message(
      'Account created successfully',
      name: 'accountCreatedSuccess',
      desc: '',
      args: [],
    );
  }

  /// `Logged in successfully`
  String get loginSuccess {
    return Intl.message(
      'Logged in successfully',
      name: 'loginSuccess',
      desc: '',
      args: [],
    );
  }

  /// `Unblock`
  String get unblock {
    return Intl.message('Unblock', name: 'unblock', desc: '', args: []);
  }

  /// `Report message`
  String get reportMessage {
    return Intl.message(
      'Report message',
      name: 'reportMessage',
      desc: '',
      args: [],
    );
  }

  /// `Are you sure you want to report this message?`
  String get reportMessageConfirmation {
    return Intl.message(
      'Are you sure you want to report this message?',
      name: 'reportMessageConfirmation',
      desc: '',
      args: [],
    );
  }

  /// `Cancel`
  String get cancel {
    return Intl.message('Cancel', name: 'cancel', desc: '', args: []);
  }

  /// `Report`
  String get report {
    return Intl.message('Report', name: 'report', desc: '', args: []);
  }

  /// `Message reported`
  String get messageReported {
    return Intl.message(
      'Message reported',
      name: 'messageReported',
      desc: '',
      args: [],
    );
  }

  /// `Type your message...`
  String get typeMessageHint {
    return Intl.message(
      'Type your message...',
      name: 'typeMessageHint',
      desc: '',
      args: [],
    );
  }

  /// `Block {name}`
  String blockUser(Object name) {
    return Intl.message(
      'Block $name',
      name: 'blockUser',
      desc: '',
      args: [name],
    );
  }

  /// `{name} blocked successfully`
  String blockSuccess(Object name) {
    return Intl.message(
      '$name blocked successfully',
      name: 'blockSuccess',
      desc: '',
      args: [name],
    );
  }

  /// `The password provided is too weak.`
  String get weakPassword {
    return Intl.message(
      'The password provided is too weak.',
      name: 'weakPassword',
      desc: '',
      args: [],
    );
  }

  /// `The account already exists for that email.`
  String get emailAlreadyInUse {
    return Intl.message(
      'The account already exists for that email.',
      name: 'emailAlreadyInUse',
      desc: '',
      args: [],
    );
  }

  /// `The email address is badly formatted.`
  String get invalidEmail {
    return Intl.message(
      'The email address is badly formatted.',
      name: 'invalidEmail',
      desc: '',
      args: [],
    );
  }

  /// `No user found for that email.`
  String get userNotFound {
    return Intl.message(
      'No user found for that email.',
      name: 'userNotFound',
      desc: '',
      args: [],
    );
  }

  /// `Wrong password provided for that user.`
  String get wrongPassword {
    return Intl.message(
      'Wrong password provided for that user.',
      name: 'wrongPassword',
      desc: '',
      args: [],
    );
  }

  /// `Authentication error.`
  String get authenticationError {
    return Intl.message(
      'Authentication error.',
      name: 'authenticationError',
      desc: '',
      args: [],
    );
  }

  /// `Google sign in cancelled`
  String get googleSignInCancelled {
    return Intl.message(
      'Google sign in cancelled',
      name: 'googleSignInCancelled',
      desc: '',
      args: [],
    );
  }

  /// `Anonymous User`
  String get AnonymousUser {
    return Intl.message(
      'Anonymous User',
      name: 'AnonymousUser',
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
