import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pulse/core/cache/cache_helper.dart';

enum Language { en, ar }

class LangCubit extends Cubit<Language> {
  LangCubit() : super(Language.en) {
    _initLanguage();
  }

  // Loads the cached language and emits it if different.
  void _initLanguage() {
    final cachedLang = CacheHelper.getStringData(key: 'lang');
    if (cachedLang == 'ar' && state != Language.ar) {
      emit(Language.ar);
    }
  }

  void switchLanguage(Language language) {
    if (language != state) {
      emit(language);
      CacheHelper.setStringData(
        key: 'lang',
        value: language == Language.ar ? 'ar' : 'en',
      );
    }
  }
}
