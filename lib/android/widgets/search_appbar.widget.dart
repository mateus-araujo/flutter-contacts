import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import 'package:contacts/core/controllers/home_controller.dart';

class SearchAppBar extends StatelessWidget {
  final HomeController controller;

  const SearchAppBar({Key? key, required this.controller}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Observer(
        builder: (_) {
          return controller.showSearch
              ? TextField(
                  autofocus: true,
                  decoration: InputDecoration(labelText: "Pesquisar..."),
                  onSubmitted: (value) {
                    controller.search(value);
                  },
                )
              : Text('Meus Contatos');
        },
      ),
      leading: TextButton(
        onPressed: () {
          if (controller.showSearch) controller.search("");
          controller.toggleSearch();
        },
        child: Observer(
          builder: (_) => Icon(
            controller.showSearch ? Icons.close : Icons.search,
            color: Theme.of(context).primaryColor,
          ),
        ),
      ),
    );
  }
}
