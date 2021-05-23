import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DialogService {
  static Future<void> displayAndroidDialog({
    required BuildContext context,
    required String title,
    required String content,
    List<DialogAction>? actions,
  }) async {
    return await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(title),
        content: Text(content),
        actions: actions != null
            ? actions.map((action) {
                return TextButton(
                  onPressed: action.onPressed,
                  child: Text(action.label),
                );
              }).toList()
            : [],
      ),
    );
  }

  static Future<void> displayIOSDialog({
    required BuildContext context,
    required String title,
    required String content,
    List<DialogAction>? actions,
  }) async {
    await showCupertinoDialog(
      context: context,
      builder: (context) {
        return CupertinoAlertDialog(
          title: Text(title),
          content: Text(content),
          actions: actions != null
              ? actions.map((action) {
                  return TextButton(
                    onPressed: action.onPressed,
                    child: Text(action.label),
                  );
                }).toList()
              : [],
        );
      },
    );
  }
}

class DialogAction {
  String label;
  VoidCallback onPressed;

  DialogAction({
    required this.label,
    required this.onPressed,
  });
}
