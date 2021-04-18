import 'package:flutter/material.dart';

import 'package:contacts/shared/styles.dart';

class ContactDetailsImage extends StatelessWidget {
  final String image;

  const ContactDetailsImage({
    Key? key,
    required this.image,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      height: 200,
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: basePrimaryColor.withOpacity(0.1),
        borderRadius: BorderRadius.circular(200),
      ),
      child: Container(
        width: 100,
        height: 100,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100),
          image: DecorationImage(
            fit: BoxFit.cover,
            image: image == ''
                ? AssetImage("assets/images/profile-picture.png")
                : AssetImage(image),
          ),
        ),
      ),
    );
  }
}
