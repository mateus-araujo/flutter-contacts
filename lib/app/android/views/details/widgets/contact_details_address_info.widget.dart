import 'package:flutter/material.dart';

import 'package:contacts/app/shared/modules/navigation/routes.dart';
import 'package:contacts/app/shared/utils/services/navigation_service.dart';
import 'package:contacts/domain/entities/contact.dart';

class ContactDetailsAddressInfo extends StatelessWidget {
  final Contact contact;

  const ContactDetailsAddressInfo({
    Key? key,
    required this.contact,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        "Endereço",
        style: TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: 16,
        ),
      ),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
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
      isThreeLine: true,
      trailing: TextButton(
        onPressed: () {
          NavigationService.pushNamed(
            Routes.address,
            arguments: {'contact': contact},
          );
        },
        child: Icon(
          Icons.pin_drop,
          color: Theme.of(context).primaryColor,
        ),
      ),
    );
  }
}
