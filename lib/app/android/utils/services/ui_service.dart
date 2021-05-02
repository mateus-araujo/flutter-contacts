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
    SnackBarType? type,
  }) {
    final snackBar = SnackBar(
      content: Text(message),
      backgroundColor: _getSnackBarColor(type),
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  static Color? _getSnackBarColor(SnackBarType? type) {
    switch (type) {
      case SnackBarType.alert:
        return Colors.orange;
      case SnackBarType.error:
        return Colors.red;
      case SnackBarType.success:
        return Colors.green;
      default:
        return null;
    }
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

enum SnackBarType {
  alert,
  error,
  success,
}
