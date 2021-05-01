import 'package:flutter/material.dart';

class UIService {
  static void displayDialog({
    required BuildContext context,
    required String title,
    required String content,
    List<DialogAction>? actions,
  }) {
    showDialog(
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

  static void displaySnackBar({
    required BuildContext context,
    required String message,
  }) {
    final snackBar = SnackBar(
      content: Text(message),
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
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
