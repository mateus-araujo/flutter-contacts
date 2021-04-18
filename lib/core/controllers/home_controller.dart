import 'package:mobx/mobx.dart';

import 'package:contacts/core/models/contact.model.dart';
import 'package:contacts/core/repositories/contact_repository.dart';

part 'home_controller.g.dart';

class HomeController = _HomeController with _$HomeController;

abstract class _HomeController with Store {
  @observable
  bool showSearch = false;

  @observable
  ObservableList<ContactModel> contacts = new ObservableList<ContactModel>();

  @action
  toggleSearch() {
    showSearch = !showSearch;
  }

  @action
  search(String name) async {
    final repository = await ContactRepository.repository;
    final data = await repository.searchByName(name);

    if (contacts.isNotEmpty) {
      contacts.clear();
    }

    contacts.addAll(data!);
  }
}
