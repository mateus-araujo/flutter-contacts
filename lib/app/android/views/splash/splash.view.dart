import 'package:flutter/material.dart';

import 'package:contacts/app/android/utils/services/ui_service.dart';
import 'package:contacts/app/navigation/routes.dart';
import 'package:contacts/app/shared/controllers/auth/auth_controller.dart';

class SplashView extends StatefulWidget {
  @override
  _SplashViewState createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  late final AuthController controller;

  @override
  void initState() {
    super.initState();
    controller = AuthController(context: context);
    controller.authenticate().then((isAuthenticated) {
      if (isAuthenticated) {
        Navigator.pushReplacementNamed(
          context,
          Routes.home,
        );
      } else {
        UIService.displaySnackBar(
            context: context, message: 'Usuário não autenticado');
      }
    }).catchError((_) {
      UIService.displaySnackBar(
          context: context, message: 'Erro ao autenticar');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          SizedBox(
            width: double.infinity,
          ),
          Icon(
            Icons.fingerprint,
            size: 72,
            color: Theme.of(context).accentColor,
          ),
          SizedBox(
            height: 20,
          ),
          Text(
            "Meus Contatos",
            style: TextStyle(
              fontSize: 24,
              color: Theme.of(context).accentColor,
            ),
          ),
        ],
      ),
    );
  }
}
