import 'dart:io';

import 'package:flutter/material.dart';

import 'package:contacts/app/shared/utils/services/ui/dialog_service.dart';
import 'package:contacts/app/shared/utils/services/ui/snackbar_service.dart';

export './snackbar_service.dart';
export './dialog_service.dart';

class UIService {
  static Future<void> displayDialog({
    required BuildContext context,
    required String title,
    required String content,
    List<DialogAction>? actions,
  }) async {
    if (Platform.isIOS) {
      await DialogService.displayIOSDialog(
          context: context, title: title, content: content, actions: actions);
    } else {
      await DialogService.displayAndroidDialog(
          context: context, title: title, content: content, actions: actions);
    }
  }

  static Future<void> displaySnackBar({
    required BuildContext context,
    required String message,
    SnackBarType? type,
  }) async {
    if (Platform.isIOS) {
      await SnackbarService.displayIOSSnackBar(
          context: context, message: message, type: type);
    } else {
      SnackbarService.displayAndroidSnackBar(
          context: context, message: message, type: type);
    }
  }
}
