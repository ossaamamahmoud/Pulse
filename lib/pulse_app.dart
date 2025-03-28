// pulse_app.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pulse/core/di/dependency_injection.dart';
import 'package:pulse/core/routing/app_router.dart';
import 'package:pulse/features/auth/presentation/cubit/auth/auth_cubit.dart';
import 'package:pulse/features/theme/presentation/cubit/theme_cubit.dart';
import 'package:pulse/generated/l10n.dart';

import 'core/constants/constants.dart';
import 'core/cubits/language_cubit/language_cubit.dart';

class PulseApp extends StatelessWidget {
  final AppRouter appRouter;
  final String startupRoute;

  const PulseApp({
    super.key,
    required this.appRouter,
    required this.startupRoute,
  });

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: appDesignSize,
      minTextAdapt: true,
      child: MultiBlocProvider(
        providers: [
          BlocProvider<ThemeCubit>(
            create: (_) => getIt<ThemeCubit>(),
          ),
          BlocProvider<AuthCubit>(
            create: (_) => getIt<AuthCubit>(),
          ),
          BlocProvider<LangCubit>(
            create: (_) => getIt<LangCubit>(),
          ),
        ],
        child: BlocBuilder<ThemeCubit, ThemeState>(
          builder: (context, themeState) {
            return BlocBuilder<LangCubit, Language>(
              builder: (context, language) {
                final locale = language == Language.ar
                    ? const Locale('ar')
                    : const Locale('en');
                return MaterialApp(
                  debugShowCheckedModeBanner: false,
                  theme: themeState.themeData,
                  locale: locale,
                  localizationsDelegates: const [
                    S.delegate,
                    GlobalMaterialLocalizations.delegate,
                    GlobalWidgetsLocalizations.delegate,
                    GlobalCupertinoLocalizations.delegate,
                  ],
                  supportedLocales: S.delegate.supportedLocales,
                  onGenerateInitialRoutes: (initialRouteName) {
                    return [
                      appRouter
                          .generateRoute(RouteSettings(name: startupRoute)),
                    ];
                  },
                  onGenerateRoute: appRouter.generateRoute,
                );
              },
            );
          },
        ),
      ),
    );
  }
}
