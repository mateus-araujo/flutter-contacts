import 'package:flutter/material.dart';

import 'package:contacts/android/views/address.view.dart';
import 'package:contacts/android/views/contact_form.view.dart';
import 'package:contacts/android/views/loading.view.dart';
import 'package:contacts/android/widgets/contact_details_actions_row.widget.dart';
import 'package:contacts/core/models/contact.model.dart';
import 'package:contacts/core/repositories/contact_repository.dart';
import 'package:contacts/shared/widgets/contact_details_description.widget.dart';
import 'package:contacts/shared/widgets/contact_details_image.widget.dart';

class DetailsView extends StatefulWidget {
  final int id;

  const DetailsView({Key? key, required this.id}) : super(key: key);

  @override
  _DetailsViewState createState() => _DetailsViewState();
}

class _DetailsViewState extends State<DetailsView> {
  final circleBorderShape = ElevatedButton.styleFrom(
    shape: CircleBorder(
      side: BorderSide.none,
    ),
  );

  Future<ContactModel?> getContact() async {
    final repository = await ContactRepository.repository;

    final contact = await repository.getContactById(widget.id);

    return contact;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getContact(),
      builder: (context, snapshot) {
        if (snapshot.data is ContactModel) {
          final contact = snapshot.data as ContactModel;

          return _buildPage(context, contact);
        } else {
          return LoadingView();
        }
      },
    );
  }

  Widget _buildPage(BuildContext context, ContactModel model) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Contato"),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Column(
        children: <Widget>[
          SizedBox(
            height: 10,
            width: double.infinity,
          ),
          ContactDetailsImage(image: model.image ?? ''),
          SizedBox(
            height: 10,
          ),
          ContactDetailsDescription(
            name: model.name ?? '',
            phone: model.phone ?? '',
            email: model.email ?? '',
          ),
          SizedBox(
            height: 20,
          ),
          ContactDetailsActionsRow(contact: model),
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
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AddressView(),
                  ),
                );
              },
              child: Icon(
                Icons.pin_drop,
                color: Theme.of(context).primaryColor,
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ContactFormView(
                model: model,
              ),
            ),
          );
        },
        backgroundColor: Theme.of(context).primaryColor,
        child: Icon(
          Icons.edit,
          color: Theme.of(context).accentColor,
        ),
      ),
    );
  }
}
