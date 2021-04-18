import 'package:flutter/material.dart';

import 'package:contacts/android/views/address.view.dart';
import 'package:contacts/android/views/contact_form.view.dart';
import 'package:contacts/android/views/loading.view.dart';
import 'package:contacts/core/models/contact.model.dart';
import 'package:contacts/core/repositories/contact_repository.dart';

class DetailsView extends StatefulWidget {
  final int id;

  const DetailsView({Key? key, required this.id}) : super(key: key);

  @override
  _DetailsViewState createState() => _DetailsViewState();
}

class _DetailsViewState extends State<DetailsView> {
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
          Container(
            width: 200,
            height: 200,
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(200),
            ),
            child: Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100),
                  image: DecorationImage(
                    image: model.image == null
                        ? AssetImage("assets/images/profile-picture.png")
                        : AssetImage(model.image!),
                  )),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            model.name!,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            "11 98741-2282",
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w400,
            ),
          ),
          Text(
            "andre@balta.io",
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w400,
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              FlatButton(
                onPressed: () {},
                color: Theme.of(context).primaryColor,
                shape: CircleBorder(
                  side: BorderSide.none,
                ),
                child: Icon(
                  Icons.phone,
                  color: Theme.of(context).accentColor,
                ),
              ),
              FlatButton(
                onPressed: () {},
                color: Theme.of(context).primaryColor,
                shape: CircleBorder(
                  side: BorderSide.none,
                ),
                child: Icon(
                  Icons.email,
                  color: Theme.of(context).accentColor,
                ),
              ),
              FlatButton(
                onPressed: () {},
                color: Theme.of(context).primaryColor,
                shape: CircleBorder(
                  side: BorderSide.none,
                ),
                child: Icon(
                  Icons.camera_enhance,
                  color: Theme.of(context).accentColor,
                ),
              ),
            ],
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
            trailing: FlatButton(
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
