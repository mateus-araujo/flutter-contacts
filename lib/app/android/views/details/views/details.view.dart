import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';

import 'package:contacts/app/android/utils/services/ui_service.dart';
import 'package:contacts/app/android/views/loading/loading.view.dart';
import 'package:contacts/app/navigation/routes.dart';
import 'package:contacts/app/shared/controllers/contact/contact_controller.dart';
import 'package:contacts/app/shared/controllers/home/home_controller.dart';
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
  final _homeController = GetIt.instance.get<HomeController>();
  final _contactController = GetIt.instance.get<ContactController>();

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

  onDelete() {
    UIService.displayDialog(
      context: context,
      title: 'Exclusão de Contato',
      content: 'Deseja mesmo excluir este contato?',
      actions: [
        DialogAction(
          label: 'Cancelar',
          onPressed: () => Navigator.pop(context),
        ),
        DialogAction(
          label: 'Excluir',
          onPressed: () => _contactController.deleteContact(context),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Observer(builder: (_) {
      final contact = _contactController.contact;
      if (contact.id != null) {
        return _buildPage(context, contact);
      } else {
        return LoadingView();
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
            ListTile(
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
                  Navigator.pushNamed(context, Routes.address,
                      arguments: {'contact': contact});
                },
                child: Icon(
                  Icons.pin_drop,
                  color: Theme.of(context).primaryColor,
                ),
              ),
            ),
            SizedBox(height: 10),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: Container(
                width: double.infinity,
                height: 50,
                child: TextButton(
                  onPressed: onDelete,
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
            Navigator.pushNamed(
              context,
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
