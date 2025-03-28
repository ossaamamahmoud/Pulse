import 'package:intl/intl.dart';

class GetCurrentLang {
  static bool isArabic() => Intl.getCurrentLocale() == 'ar';

  static bool isEnglish() => Intl.getCurrentLocale() == 'en';
}
