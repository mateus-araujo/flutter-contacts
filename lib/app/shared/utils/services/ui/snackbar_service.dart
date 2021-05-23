import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SnackbarService {
  static void displayAndroidSnackBar({
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

  static Future<void> displayIOSSnackBar({
    required BuildContext context,
    required String message,
    SnackBarType? type,
  }) async {
    await showCupertinoModalPopup(
      context: context,
      semanticsDismissible: true,
      useRootNavigator: false,
      builder: (context) => SafeArea(
        child: CupertinoPopupSurface(
          child: Container(
            margin: EdgeInsets.only(bottom: 16, left: 16, right: 16),
            padding: const EdgeInsets.symmetric(horizontal: 24),
            decoration: BoxDecoration(
              color: CupertinoColors.darkBackgroundGray,
              borderRadius: BorderRadius.circular(14),
            ),
            alignment: Alignment.centerLeft,
            width: double.maxFinite,
            height: 56,
            child: Text(
              message,
              style: TextStyle(color: CupertinoColors.white),
            ),
          ),
          isSurfacePainted: false,
        ),
      ),
    );
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

enum SnackBarType {
  alert,
  error,
  success,
}
