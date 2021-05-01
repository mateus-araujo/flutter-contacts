import 'package:flutter/material.dart';

import 'package:contacts/app/android/styles.dart';

class Loading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: CircularProgressIndicator(
        backgroundColor: primaryColor,
      ),
    );
  }
}
