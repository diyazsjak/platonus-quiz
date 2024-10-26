import 'package:flutter/material.dart';

class Loading {
  static void show(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return Container(
          color: Theme.of(context).colorScheme.surface.withOpacity(0.4),
          child: Center(
            child: Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
              ),
              child: const SizedBox(
                height: 24,
                width: 24,
                child: CircularProgressIndicator(
                  strokeWidth: 3,
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  static void remove(BuildContext context) {
    if (Navigator.canPop(context)) Navigator.pop(context);
  }
}
