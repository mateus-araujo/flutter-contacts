import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import 'package:contacts/android/views/contact_form.view.dart';
import 'package:contacts/android/widgets/contact_list_item.widget.dart';
import 'package:contacts/android/widgets/search_appbar.widget.dart';
import 'package:contacts/core/controllers/home_controller.dart';
import 'package:contacts/core/models/contact.model.dart';

class HomeView extends StatefulWidget {
  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final controller = HomeController();

  @override
  void initState() {
    super.initState();
    controller.search("");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        child: SearchAppBar(
          controller: controller,
        ),
        preferredSize: Size.fromHeight(kToolbarHeight),
      ),
      body: Observer(
        builder: (_) => ListView.builder(
          itemCount: controller.contacts.length,
          itemBuilder: (context, index) => ContactListItem(
            model: controller.contacts[index],
            controller: controller,
          ),
        ),
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
