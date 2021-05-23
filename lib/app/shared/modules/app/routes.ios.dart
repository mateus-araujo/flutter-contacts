import 'package:flutter_modular/flutter_modular.dart';

import 'package:contacts/app/ios/views/contact_form/contact_form.view.dart';
import 'package:contacts/app/shared/modules/navigation/routes.dart';

class AppRoutesIOS {
  static List<ModularRoute> routes = [
    ChildRoute(
      Routes.contactForm,
      child: (_, args) => ContactFormView(contact: args.data['contact']),
    ),
  ];
}
