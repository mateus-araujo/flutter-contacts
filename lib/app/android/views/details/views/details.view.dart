import 'package:flutter/material.dart';

import 'package:flutter_mobx/flutter_mobx.dart';

import 'package:contacts/app/android/views/details/widgets/contact_details_address_info.widget.dart';
import 'package:contacts/app/android/views/loading/loading.view.dart';
import 'package:contacts/app/shared/controllers/contact/contact_controller.dart';
import 'package:contacts/app/shared/controllers/home/home_controller.dart';
import 'package:contacts/app/shared/modules/navigation/routes.dart';
import 'package:contacts/app/shared/utils/services/binding_service.dart';
import 'package:contacts/app/shared/utils/services/navigation_service.dart';
import 'package:contacts/app/shared/widgets/contact_details_description.widget.dart';
import 'package:contacts/app/shared/widgets/contact_details_image.widget.dart';
import 'package:contacts/domain/entities/contact.dart';
import '../widgets/contact_details_actions_row.widget.dart';

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

  final circleBorderShape = ElevatedButton.styleFrom(
    shape: CircleBorder(
      side: BorderSide.none,
    ),
  );

  @override
  void initState() {
    super.initState();
    _contactController.getContact(widget.id);
  }

  @override
  Widget build(BuildContext context) {
    return Observer(builder: (_) {
      final contact = _contactController.contact;
      if (contact.id != null) {
        return _buildPage(context, contact);
      } else {
        return LoadingAndroidView();
      }
    });
  }

  Widget _buildPage(BuildContext context, Contact contact) {
    return WillPopScope(
      onWillPop: () async {
        _homeController.search("");
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text("Contato"),
        ),
        body: Column(
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
              height: 40,
            ),
            ContactDetailsAddressInfo(contact: contact),
            SizedBox(height: 10),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: Container(
                width: double.infinity,
                height: 50,
                child: TextButton(
                  onPressed: () => _contactController.onDelete(context),
                  child: Text(
                    "Excluir Contato",
                  ),
                ),
              ),
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            NavigationService.pushNamed(
              Routes.contactForm,
              arguments: {'contact': contact},
            );
          },
          backgroundColor: Theme.of(context).primaryColor,
          child: Icon(
            Icons.edit,
            color: Theme.of(context).accentColor,
          ),
        ),
      ),
    );
  }
}
