import 'package:get_it/get_it.dart';
import 'package:pulse/features/auth/presentation/cubit/auth/auth_cubit.dart';
import 'package:pulse/features/chat/presentation/cubit/chat/chat_cubit.dart';
import 'package:pulse/features/theme/presentation/cubit/theme_cubit.dart';

import '../cubits/language_cubit/language_cubit.dart';

final getIt = GetIt.instance;

Future<void> setupDependencyInjection() async {
  getIt.registerLazySingleton<AuthCubit>(() => AuthCubit());
  getIt.registerLazySingleton<ThemeCubit>(() => ThemeCubit());
  getIt.registerLazySingleton<ChatCubit>(() => ChatCubit());
  getIt.registerLazySingleton<LangCubit>(() => LangCubit());
}
