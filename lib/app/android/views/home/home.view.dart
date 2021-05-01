import 'package:contacts/app/android/widgets/loading.widget.dart';
import 'package:contacts/app/navigation/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';

import 'package:contacts/app/shared/controllers/home_controller.dart';
import 'package:contacts/domain/entities/contact.dart';

import 'widgets/contact_list_item.widget.dart';
import 'widgets/search_appbar.widget.dart';

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
      body: Observer(builder: (_) {
        if (_controller.loading) {
          return Loading();
        } else {
          return ListView.builder(
            itemCount: _controller.contacts.length,
            itemBuilder: (context, index) => ContactListItem(
              model: _controller.contacts[index],
            ),
          );
        }
      }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(
            context,
            Routes.contactForm,
            arguments: {'model': Contact(id: 0)},
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
