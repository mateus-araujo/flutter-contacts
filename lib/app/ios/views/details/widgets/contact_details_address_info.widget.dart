import 'package:flutter/cupertino.dart';

import 'package:contacts/app/shared/modules/navigation/routes.dart';
import 'package:contacts/app/shared/utils/services/navigation_service.dart';
import 'package:contacts/domain/entities/contact.dart';

class ContactDetailsAddressInfo extends StatelessWidget {
  final Contact contact;

  const ContactDetailsAddressInfo({Key? key, required this.contact})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Row(
        children: <Widget>[
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(
                  width: double.infinity,
                ),
                Text(
                  "Endereço",
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                  ),
                ),
                Text(
                  contact.addressLine1 ?? 'Nenhum endereço cadastrado',
                  style: TextStyle(
                    fontSize: 12,
                  ),
                ),
                Text(
                  contact.addressLine2 ?? '',
                  style: TextStyle(
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
          CupertinoButton(
            onPressed: () {
              NavigationService.pushNamed(Routes.address,
                  arguments: {'contact': contact});
            },
            child: Icon(
              CupertinoIcons.location,
            ),
          ),
        ],
      ),
    );
  }
}
