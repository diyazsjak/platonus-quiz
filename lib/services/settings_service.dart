import 'package:shared_preferences/shared_preferences.dart';

import '../core/constants.dart';

class SettingsService {
  late final SharedPreferencesWithCache _prefs;

  static final SettingsService _shared = SettingsService._sharedInstance();

  SettingsService._sharedInstance();

  factory SettingsService() => _shared;

  void init() async {
    _prefs = await SharedPreferencesWithCache.create(
      cacheOptions: const SharedPreferencesWithCacheOptions(),
    );
  }

  double get questionLimit {
    return _prefs.getDouble(Constants.questionLimitKey) ?? 25;
  }

  Future<void> setQuestionLimit(double value) async {
    await _prefs.setDouble(Constants.questionLimitKey, value);
  }

  bool get attemptBarType {
    return _prefs.getBool(Constants.attemptBarTypeKey) ?? false;
  }

  Future<void> setAttemptBarType(bool barType) async {
    await _prefs.setBool(Constants.attemptBarTypeKey, barType);
  }

  bool get shuffleAttemptQuestions {
    return _prefs.getBool(Constants.shuffleAttemptQuestionsKey) ?? true;
  }

  Future<void> setshuffleAttemptQuestions(bool shuffle) async {
    await _prefs.setBool(Constants.shuffleAttemptQuestionsKey, shuffle);
  }
}
