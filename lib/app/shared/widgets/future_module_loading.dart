import 'package:flutter/material.dart';

import 'package:contacts/app/android/views/loading/loading.view.dart';
import 'package:contacts/app/shared/utils/services/binding_service.dart';

class FutureModuleLoading<Module> extends StatelessWidget {
  final Widget child;

  const FutureModuleLoading({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: BindingService.isReady<Module>(),
      builder: (context, snapshot) {
        final connectionState = snapshot.connectionState;

        if (connectionState == ConnectionState.done) {
          return child;
        } else {
          return LoadingView();
        }
      },
    );
  }
}
