import 'package:flutter/material.dart';

import 'package:contacts/app/navigation/routes.dart';

class SplashView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration(seconds: 1)).then(
      (_) => Navigator.pushReplacementNamed(
        context,
        Routes.home,
      ),
    );

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
