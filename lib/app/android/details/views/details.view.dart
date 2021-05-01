import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import 'package:contacts/app/android/contact_form/contact_form.view.dart';
import 'package:contacts/app/android/loading/loading.view.dart';
import 'package:contacts/app/shared/controllers/home_controller.dart';
import 'package:contacts/app/shared/widgets/contact_details_description.widget.dart';
import 'package:contacts/app/shared/widgets/contact_details_image.widget.dart';
import 'package:contacts/data/repositories/contact_repository.dart';
import 'package:contacts/domain/entities/contact.dart';

import '../widgets/contact_details_actions_row.widget.dart';
import 'address.view.dart';

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

  Widget _buildPage(BuildContext context, Contact model) {
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
            ContactDetailsActionsRow(
              contact: model,
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
      ),
    );
  }
}
