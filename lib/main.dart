import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pulse/core/routing/app_router.dart';
import 'package:pulse/pulse_app.dart';

import 'app_observer.dart';
import 'core/cache/cache_helper.dart';
import 'core/di/dependency_injection.dart';
import 'core/routing/routes.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await ScreenUtil.ensureScreenSize();
  await setupDependencyInjection();
  await CacheHelper.init();
  String startupRoute;
  final bool hasThemeChosen =
      CacheHelper.getBoolData(key: 'hasThemeChosen') ?? false;
  bool logged = CacheHelper.getBoolData(key: 'Logged') ?? false;
  if (hasThemeChosen) {
    if (logged) {
      startupRoute = Routes.chatsScreen;
    } else {
      startupRoute = Routes.authStartupScreen;
    }
  } else {
    startupRoute = Routes.themeStartupScreen;
  }
  Bloc.observer = MyBlocObserver();
  runApp(
    PulseApp(
      appRouter: AppRouter(),
      startupRoute: startupRoute,
    ),
  );
}
