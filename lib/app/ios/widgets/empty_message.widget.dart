import 'package:flutter/cupertino.dart';

class EmptyMessage extends StatelessWidget {
  final IconData icon;
  final String message;

  const EmptyMessage({
    Key? key,
    required this.icon,
    required this.message,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 200,
        padding: EdgeInsets.only(top: 200),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Icon(
              icon,
              size: 100,
              color: CupertinoColors.systemGrey,
            ),
            SizedBox(height: 20),
            Text(
              message,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
