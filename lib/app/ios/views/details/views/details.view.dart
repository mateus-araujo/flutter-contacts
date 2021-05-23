import 'package:flutter/cupertino.dart';

import 'package:flutter_mobx/flutter_mobx.dart';

import 'package:contacts/app/ios/views/details/widgets/contact_details_actions_row.widget.dart';
import 'package:contacts/app/ios/views/details/widgets/contact_details_address_info.widget.dart';
import 'package:contacts/app/ios/views/loading/loading.view.dart';
import 'package:contacts/app/shared/controllers/contact/contact_controller.dart';
import 'package:contacts/app/shared/controllers/home/home_controller.dart';
import 'package:contacts/app/shared/modules/navigation/routes.dart';
import 'package:contacts/app/shared/utils/services/binding_service.dart';
import 'package:contacts/app/shared/utils/services/navigation_service.dart';
import 'package:contacts/app/shared/widgets/contact_details_description.widget.dart';
import 'package:contacts/app/shared/widgets/contact_details_image.widget.dart';
import 'package:contacts/domain/entities/contact.dart';

class DetailsView extends StatefulWidget {
  final int id;

  const DetailsView({
    Key? key,
    required this.id,
  }) : super(key: key);

  @override
  _DetailsViewState createState() => _DetailsViewState();
}

class _DetailsViewState extends State<DetailsView> {
  final _homeController = BindingService.get<HomeController>();
  final _contactController = BindingService.get<ContactController>();

  @override
  void initState() {
    super.initState();
    _contactController.getContact(widget.id);
  }

  @override
  Widget build(BuildContext context) {
    return Observer(builder: (context) {
      final contact = _contactController.contact;
      if (contact.id != null) {
        return _buildPage(context, contact);
      } else {
        return LoadingIOSView();
      }
    });
  }

  Widget _buildPage(BuildContext context, Contact contact) {
    return WillPopScope(
      onWillPop: () async {
        _homeController.search("");
        return true;
      },
      child: CupertinoPageScaffold(
        child: CustomScrollView(
          slivers: <Widget>[
            CupertinoSliverNavigationBar(
              largeTitle: Text("Contato"),
              trailing: CupertinoButton(
                child: Icon(
                  CupertinoIcons.pen,
                ),
                onPressed: () {
                  NavigationService.pushNamed(
                    Routes.contactForm,
                    arguments: {'contact': contact},
                  );
                },
              ),
            ),
            SliverFillRemaining(
              child: Column(
                children: <Widget>[
                  SizedBox(
                    height: 10,
                    width: double.infinity,
                  ),
                  ContactDetailsImage(image: contact.image ?? ''),
                  SizedBox(
                    height: 10,
                  ),
                  ContactDetailsDescription(
                    name: contact.name ?? '',
                    phone: contact.phone ?? '',
                    email: contact.email ?? '',
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  ContactDetailsActionsRow(
                    contact: contact,
                    onUpdate: () {
                      _contactController.getContact(contact.id!);
                    },
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  ContactDetailsAddressInfo(contact: contact),
                  SizedBox(height: 20),
                  CupertinoButton.filled(
                    child: Text('Excluir contato'),
                    onPressed: () => _contactController.onDelete(context),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
