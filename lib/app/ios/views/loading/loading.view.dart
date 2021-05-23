import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:contacts/app/ios/widgets/loading.widget.dart';

class LoadingIOSView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(child: Loading());
  }
}
