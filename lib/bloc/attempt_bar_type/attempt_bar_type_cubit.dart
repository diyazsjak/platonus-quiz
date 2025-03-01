import 'package:flutter_bloc/flutter_bloc.dart';

import '../../services/settings_service.dart';

enum AttemptBarType { withBackground, withoutBackground }

sealed class AttemptBarTypeState {}

final class AttemptBarTypeInitial extends AttemptBarTypeState {}

final class AttemptBarTypeLoadSuccess extends AttemptBarTypeState {
  final AttemptBarType type;

  AttemptBarTypeLoadSuccess(this.type);
}

class AttemptBarTypeCubit extends Cubit<AttemptBarTypeState> {
  final _settingsService = SettingsService();
  late AttemptBarType? currentType;

  AttemptBarTypeCubit() : super(AttemptBarTypeInitial());

  void changeType(AttemptBarType type) async {
    await _settingsService
        .setAttemptBarType(type == AttemptBarType.withBackground);

    currentType = type;
    emit(AttemptBarTypeLoadSuccess(type));
  }

  void getType() {
    final type = (_settingsService.attemptBarType)
        ? AttemptBarType.withBackground
        : AttemptBarType.withoutBackground;

    currentType = type;
    emit(AttemptBarTypeLoadSuccess(type));
  }
}
