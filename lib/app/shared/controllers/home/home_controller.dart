import 'package:mobx/mobx.dart';

import 'package:contacts/data/repositories/contact_repository.dart';
import 'package:contacts/domain/entities/contact.dart';

import 'home_state.dart';

part 'home_controller.g.dart';

class HomeController = _HomeController with _$HomeController;

abstract class _HomeController with Store {
  final ContactRepository repository;

  _HomeController(this.repository);

  @observable
  HomeState state = HomeState.empty;

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
    state = HomeState.loading;

    final result = await repository.searchByName(name);

    if (contacts.isNotEmpty) {
      contacts.clear();
    }

    await Future.delayed(Duration(milliseconds: 300));

    result.fold(
      (_) => state = HomeState.error,
      (list) {
        if (list.isEmpty) {
          state = HomeState.empty;
        } else {
          contacts.addAll(list);
          state = HomeState.success;
        }
      },
    );
  }
}
