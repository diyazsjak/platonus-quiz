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

  double getQuestionLimit() {
    return _prefs.getDouble(Constants.questionLimitKey) ?? 25;
  }

  Future<void> setQuestionLimit(double value) async {
    await _prefs.setDouble(Constants.questionLimitKey, value);
  }
}
