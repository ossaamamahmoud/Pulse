// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a en locale. All the
// messages from the main program should be duplicated here with the same
// function name.

// Ignore issues from commonly used lints in this file.
// ignore_for_file:unnecessary_brace_in_string_interps, unnecessary_new
// ignore_for_file:prefer_single_quotes,comment_references, directives_ordering
// ignore_for_file:annotate_overrides,prefer_generic_function_type_aliases
// ignore_for_file:unused_import, file_names, avoid_escaping_inner_quotes
// ignore_for_file:unnecessary_string_interpolations, unnecessary_string_escapes

import 'package:intl/intl.dart';
import 'package:intl/message_lookup_by_library.dart';

final messages = new MessageLookup();

typedef String MessageIfAbsent(String messageStr, List<dynamic> args);

class MessageLookup extends MessageLookupByLibrary {
  String get localeName => 'en';

  static String m0(name) => "${name} blocked successfully";

  static String m1(name) => "Block ${name}";

  static String m2(name) => "${name} unblocked successfully";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
    "AnonymousUser": MessageLookupByLibrary.simpleMessage("Anonymous User"),
    "accountCreatedSuccess": MessageLookupByLibrary.simpleMessage(
      "Account created successfully",
    ),
    "appFontFamily": MessageLookupByLibrary.simpleMessage("Poppins"),
    "appName": MessageLookupByLibrary.simpleMessage("Pulse"),
    "arabic": MessageLookupByLibrary.simpleMessage("Arabic"),
    "authStartupFirstButtonText": MessageLookupByLibrary.simpleMessage(
      "Continue with Google",
    ),
    "authStartupFirstText": MessageLookupByLibrary.simpleMessage("Welcome to"),
    "authStartupHaveAnAccount": MessageLookupByLibrary.simpleMessage(
      "Already have an account?",
    ),
    "authStartupLoginButtonText": MessageLookupByLibrary.simpleMessage("Login"),
    "authStartupSecondButtonText": MessageLookupByLibrary.simpleMessage(
      "Continue with Email",
    ),
    "authStartupSecondText": MessageLookupByLibrary.simpleMessage(
      "A place where you can reach all your friends",
    ),
    "authStartupThirdText": MessageLookupByLibrary.simpleMessage(
      "Let\'s Get Started",
    ),
    "authenticationError": MessageLookupByLibrary.simpleMessage(
      "Authentication error.",
    ),
    "blockSuccess": m0,
    "blockUser": m1,
    "blockedUsers": MessageLookupByLibrary.simpleMessage("Blocked Users"),
    "cancel": MessageLookupByLibrary.simpleMessage("Cancel"),
    "chooseThemeMode": MessageLookupByLibrary.simpleMessage(
      "Choose App theme mode:",
    ),
    "darkMode": MessageLookupByLibrary.simpleMessage("Dark"),
    "drawerChats": MessageLookupByLibrary.simpleMessage("Chats"),
    "drawerLogout": MessageLookupByLibrary.simpleMessage("Log Out"),
    "drawerSettings": MessageLookupByLibrary.simpleMessage("Settings"),
    "emailAlreadyInUse": MessageLookupByLibrary.simpleMessage(
      "The account already exists for that email.",
    ),
    "english": MessageLookupByLibrary.simpleMessage("English"),
    "fillAllFieldsError": MessageLookupByLibrary.simpleMessage(
      "Please fill all the fields",
    ),
    "googleSignInCancelled": MessageLookupByLibrary.simpleMessage(
      "Google sign in cancelled",
    ),
    "invalidEmail": MessageLookupByLibrary.simpleMessage(
      "The email address is badly formatted.",
    ),
    "language": MessageLookupByLibrary.simpleMessage("Language"),
    "lightMode": MessageLookupByLibrary.simpleMessage("Light"),
    "logOut": MessageLookupByLibrary.simpleMessage("Log Out"),
    "loggedOutSuccess": MessageLookupByLibrary.simpleMessage(
      "Logged out successfully",
    ),
    "loginFirstText": MessageLookupByLibrary.simpleMessage(
      "Login now to contact with all your friends\nat a place!",
    ),
    "loginForgetPassword": MessageLookupByLibrary.simpleMessage(
      "Forgot Password?",
    ),
    "loginNotHaveAccount": MessageLookupByLibrary.simpleMessage(
      "Don\'t have an account?",
    ),
    "loginSuccess": MessageLookupByLibrary.simpleMessage(
      "Logged in successfully",
    ),
    "messageReported": MessageLookupByLibrary.simpleMessage("Message reported"),
    "noBlockedUsers": MessageLookupByLibrary.simpleMessage("No blocked users"),
    "noMessages": MessageLookupByLibrary.simpleMessage(
      "No messages yet, start a conversation",
    ),
    "noUserLoggedIn": MessageLookupByLibrary.simpleMessage("No user logged in"),
    "passwordMismatch": MessageLookupByLibrary.simpleMessage(
      "Password does not match",
    ),
    "registerAccountText": MessageLookupByLibrary.simpleMessage("account "),
    "registerCreateSecondText": MessageLookupByLibrary.simpleMessage(
      "to access all the\nfeatures of ",
    ),
    "registerCreateText": MessageLookupByLibrary.simpleMessage("Create an "),
    "registerFirstText": MessageLookupByLibrary.simpleMessage("Register"),
    "registerTffConfirmPassword": MessageLookupByLibrary.simpleMessage(
      "Confirm Your Password",
    ),
    "registerTffEmail": MessageLookupByLibrary.simpleMessage("Email Address"),
    "registerTffEmailHint": MessageLookupByLibrary.simpleMessage(
      "Ex: ZDZPf@example.com",
    ),
    "registerTffName": MessageLookupByLibrary.simpleMessage("Your Name"),
    "registerTffNameHint": MessageLookupByLibrary.simpleMessage("Ex. John Doe"),
    "registerTffPassword": MessageLookupByLibrary.simpleMessage(
      "Your Password",
    ),
    "registerTffPasswordHint": MessageLookupByLibrary.simpleMessage("********"),
    "report": MessageLookupByLibrary.simpleMessage("Report"),
    "reportMessage": MessageLookupByLibrary.simpleMessage("Report message"),
    "reportMessageConfirmation": MessageLookupByLibrary.simpleMessage(
      "Are you sure you want to report this message?",
    ),
    "settings": MessageLookupByLibrary.simpleMessage("Settings"),
    "themeDarkMode": MessageLookupByLibrary.simpleMessage("Dark Mode"),
    "themeLightMode": MessageLookupByLibrary.simpleMessage("Light Mode"),
    "themeMode": MessageLookupByLibrary.simpleMessage("Theme Mode"),
    "typeMessageHint": MessageLookupByLibrary.simpleMessage(
      "Type your message...",
    ),
    "unblock": MessageLookupByLibrary.simpleMessage("Unblock"),
    "unblockedSuccess": m2,
    "userNotFound": MessageLookupByLibrary.simpleMessage(
      "No user found for that email.",
    ),
    "weakPassword": MessageLookupByLibrary.simpleMessage(
      "The password provided is too weak.",
    ),
    "wrongPassword": MessageLookupByLibrary.simpleMessage(
      "Wrong password provided for that user.",
    ),
  };
}
