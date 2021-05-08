import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import 'package:contacts/app/android/utils/services/ui_service.dart';
import 'package:contacts/app/android/views/loading/loading.view.dart';
import 'package:contacts/app/navigation/routes.dart';
import 'package:contacts/app/shared/controllers/home/home_controller.dart';
import 'package:contacts/app/shared/widgets/contact_details_description.widget.dart';
import 'package:contacts/app/shared/widgets/contact_details_image.widget.dart';
import 'package:contacts/data/repositories/contact_repository.dart';
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
  final _repository = GetIt.instance.get<ContactRepository>();
  final _controller = GetIt.instance.get<HomeController>();

  final circleBorderShape = ElevatedButton.styleFrom(
    shape: CircleBorder(
      side: BorderSide.none,
    ),
  );

  Future<Contact?> getContact() async {
    final data = await _repository.getContactById(widget.id);
    final contact = data.fold((_) => null, (r) => r);

    return contact;
  }

  deleteContact() async {
    final result = await _repository.deleteContact(widget.id);

    result.fold((_) {
      UIService.displaySnackBar(
        context: context,
        message: 'Houve um erro excluir o contato',
        type: SnackBarType.error,
      );
    }, (r) {
      Navigator.pushNamed(context, Routes.home);

      UIService.displaySnackBar(
        context: context,
        message: 'Contato excluído',
        type: SnackBarType.success,
      );
    });
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
          onPressed: deleteContact,
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getContact(),
      builder: (context, snapshot) {
        if (snapshot.data is Contact) {
          final contact = snapshot.data as Contact;

          return _buildPage(context, contact);
        } else {
          return LoadingView();
        }
      },
    );
  }

  Widget _buildPage(BuildContext context, Contact contact) {
    return WillPopScope(
      onWillPop: () async {
        _controller.search("");
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
                setState(() {});
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
                    "Rua do Desenvolvedor, 256",
                    style: TextStyle(
                      fontSize: 12,
                    ),
                  ),
                  Text(
                    "Piracicaba/SP",
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
