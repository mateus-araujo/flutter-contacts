import 'package:flutter/material.dart';

import 'package:contacts/android/views/contact_form.view.dart';
import 'package:contacts/android/views/details.view.dart';
import 'package:contacts/core/models/contact.model.dart';

class HomeView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text("Meus Contatos"),
        centerTitle: true,
        leading: FlatButton(
          onPressed: () {},
          child: Icon(
            Icons.search,
            color: Theme.of(context).primaryColor,
          ),
        ),
      ),
      body: ListView(
        children: <Widget>[
          ListTile(
            leading: Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(48),
                image: DecorationImage(
                  image: NetworkImage(
                      "https://media-exp1.licdn.com/dms/image/C4D03AQHT446c1pOc_Q/profile-displayphoto-shrink_800_800/0/1589576908763?e=1623888000&v=beta&t=AP2WY5dN0rVAQ3bsBLhjOnrUh7xlHAE24yRZ3V5Gvdc"),
                ),
              ),
            ),
            title: Text("André Baltieri"),
            subtitle: Text("11 97222-7742"),
            trailing: FlatButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DetailsView(),
                  ),
                );
              },
              child: Icon(
                Icons.chat,
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
                model: ContactModel(id: 0),
              ),
            ),
          );
        },
        backgroundColor: Theme.of(context).primaryColor,
        child: Icon(
          Icons.add,
          color: Theme.of(context).accentColor,
        ),
      ),
    );
  }
}
