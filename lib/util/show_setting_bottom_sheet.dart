import 'package:flutter/material.dart';

import '../widgets/settings.dart';

void showSettingsBottomSheet(BuildContext context) {
  showModalBottomSheet(
    context: context,
    builder: (context) {
      return const Settings();
    },
  );
}
