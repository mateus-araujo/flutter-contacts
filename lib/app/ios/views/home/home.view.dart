import 'package:flutter/cupertino.dart';

import 'package:flutter_mobx/flutter_mobx.dart';

import 'package:contacts/app/ios/views/home/widgets/contact_list_item.widget.dart';
import 'package:contacts/app/ios/widgets/empty_message.widget.dart';
import 'package:contacts/app/ios/widgets/loading.widget.dart';
import 'package:contacts/app/shared/controllers/home/home_controller.dart';
import 'package:contacts/app/shared/controllers/home/home_state.dart';
import 'package:contacts/app/shared/modules/navigation/routes.dart';
import 'package:contacts/app/shared/utils/services/binding_service.dart';
import 'package:contacts/app/shared/utils/services/navigation_service.dart';
import 'package:contacts/domain/entities/contact.dart';

class HomeView extends StatefulWidget {
  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final _controller = BindingService.get<HomeController>();

  @override
  void initState() {
    super.initState();
    _controller.search('');
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: _buildNavigationBar(),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Observer(builder: (_) {
          switch (_controller.state) {
            case HomeState.loading:
              return Loading();
            case HomeState.empty:
              return EmptyMessage(
                  icon: CupertinoIcons.doc_person,
                  message: 'Não foram encontrados contatos cadastrados');
            default:
              return ListView.builder(
                itemCount: _controller.contacts.length,
                itemBuilder: (context, index) => ContactListItem(
                  contact: _controller.contacts[index],
                ),
              );
          }
        }),
      ),
    );
  }

  CupertinoNavigationBar _buildNavigationBar() {
    return CupertinoNavigationBar(
      middle: Observer(
        builder: (_) => _controller.showSearch
            ? CupertinoTextField(
                autofocus: true,
                placeholder: "Pesquisar...",
                onSubmitted: (value) => _controller.search(value),
              )
            : Text('Meus contatos'),
      ),
      leading: GestureDetector(
        onTap: () {
          if (_controller.showSearch) _controller.search('');
          _controller.toggleSearch();
        },
        child: Observer(
          builder: (_) => Icon(
            _controller.showSearch
                ? CupertinoIcons.clear
                : CupertinoIcons.search,
          ),
        ),
      ),
      trailing: GestureDetector(
        child: Icon(
          CupertinoIcons.add,
        ),
        onTap: () {
          NavigationService.pushNamed(
            Routes.contactForm,
            arguments: {'contact': Contact(id: 0)},
          );
        },
      ),
    );
  }
}
