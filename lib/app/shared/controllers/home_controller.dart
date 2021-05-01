import 'package:get_it/get_it.dart';
import 'package:mobx/mobx.dart';

import 'package:contacts/domain/entities/contact.dart';
import 'package:contacts/data/repositories/contact_repository.dart';

part 'home_controller.g.dart';

class HomeController = _HomeController with _$HomeController;

abstract class _HomeController with Store {
  @observable
  bool loading = false;

  @observable
  bool showSearch = false;

  @observable
  ObservableList<Contact> contacts = new ObservableList<Contact>();

  @action
  toggleSearch() {
    showSearch = !showSearch;
  }

  @action
  search(String name) async {
    loading = true;
    final repository = GetIt.instance.get<ContactRepository>();

    final data = await repository.searchByName(name);

    if (contacts.isNotEmpty) {
      contacts.clear();
    }

    await Future.delayed(Duration(milliseconds: 300));

    data.fold((l) => null, (r) => contacts.addAll(r));
    loading = false;
  }
}
