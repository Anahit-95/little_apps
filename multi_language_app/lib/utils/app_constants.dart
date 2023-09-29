import '../models/language_model.dart';

class AppConstants {
  static const String COUNTRY_CODE = 'country_code';
  static const String LANGUAGE_CODE = 'language_code';

  static List<LanguageModel> languages = [
    LanguageModel(
        imageUrl: "en.png",
        languageName: 'English',
        languageCode: 'en',
        countryCode: 'US'),
    LanguageModel(
        imageUrl: "hy.png",
        languageName: 'Հայերեն',
        languageCode: 'hy',
        countryCode: 'AM'),
  ];
}
