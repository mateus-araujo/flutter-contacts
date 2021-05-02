import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:local_auth/error_codes.dart' as auth_error;
import 'package:local_auth/local_auth.dart';

import 'package:contacts/app/android/utils/services/ui_service.dart';

class AuthController {
  final _auth = LocalAuthentication();
  late final BuildContext _context;

  AuthController({required BuildContext context}) {
    _context = context;
  }

  Future<bool> authenticate() async {
    final isBiometricAvailable = await _isBiometricAvailable();

    if (isBiometricAvailable) {
      await _getListOfBiometrictTypes();
      return await _authenticateUser();
    }

    return false;
  }

  Future<bool> _isBiometricAvailable() async {
    try {
      bool isAvailable = await _auth.canCheckBiometrics;
      return isAvailable;
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future _getListOfBiometrictTypes() async {
    try {
      await _auth.getAvailableBiometrics();
    } catch (e) {
      print(e);
    }
  }

  Future<bool> _authenticateUser() async {
    try {
      bool isAuthenticated = await _auth.authenticate(
        localizedReason: 'Autentique-se para prosseguir',
        useErrorDialogs: true,
        stickyAuth: true,
      );

      return isAuthenticated;
    } on PlatformException catch (e) {
      if (e.code == auth_error.notAvailable) {
        UIService.displaySnackBar(
            context: _context,
            message: 'Biometria não disponível neste dispositivo...',
            type: SnackBarType.error);
        return true;
      }

      return false;
    }
  }
}
