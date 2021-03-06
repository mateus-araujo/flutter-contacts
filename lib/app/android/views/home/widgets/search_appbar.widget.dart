import 'package:flutter/material.dart';

import 'package:flutter_mobx/flutter_mobx.dart';

import 'package:contacts/app/shared/controllers/home/home_controller.dart';
import 'package:contacts/app/shared/utils/services/binding_service.dart';

class SearchAppBar extends StatelessWidget {
  final _controller = BindingService.get<HomeController>();

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Observer(
        builder: (_) {
          return _controller.showSearch
              ? TextField(
                  autofocus: true,
                  decoration: InputDecoration(labelText: "Pesquisar..."),
                  onSubmitted: (value) {
                    _controller.search(value);
                  },
                )
              : Text('Meus Contatos');
        },
      ),
      leading: TextButton(
        onPressed: () {
          if (_controller.showSearch) _controller.search("");
          _controller.toggleSearch();
        },
        child: Observer(
          builder: (_) => Icon(
            _controller.showSearch ? Icons.close : Icons.search,
            color: Theme.of(context).primaryColor,
          ),
        ),
      ),
    );
  }
}
