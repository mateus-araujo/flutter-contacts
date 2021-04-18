import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';

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
  final _controller = GetIt.instance.get<HomeController>();

  @override
  void initState() {
    super.initState();
    _controller.search("");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        child: SearchAppBar(),
        preferredSize: Size.fromHeight(kToolbarHeight),
      ),
      body: Observer(
        builder: (_) => ListView.builder(
          itemCount: _controller.contacts.length,
          itemBuilder: (context, index) => ContactListItem(
            model: _controller.contacts[index],
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
