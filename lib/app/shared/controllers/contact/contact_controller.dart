import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';

import 'package:contacts/app/android/utils/services/ui_service.dart';
import 'package:contacts/app/shared/modules/navigation/routes.dart';
import 'package:contacts/app/shared/utils/services/binding_service.dart';
import 'package:contacts/app/shared/utils/services/navigation_service.dart';
import 'package:contacts/data/repositories/contact_repository.dart';
import 'package:contacts/domain/entities/contact.dart';

part 'contact_controller.g.dart';

class ContactController = _ContactController with _$ContactController;

abstract class _ContactController with Store {
  final _repository = BindingService.get<ContactRepository>();

  @observable
  Contact contact = Contact();

  @action
  getContact(int id) async {
    final result = await _repository.getContactById(id);

    result.fold((_) => null, (r) {
      contact = r;
    });
  }

  @action
  deleteContact(BuildContext context) async {
    final result = await _repository.deleteContact(contact.id!);

    result.fold((_) {
      UIService.displaySnackBar(
        context: context,
        message: 'Houve um erro excluir o contato',
        type: SnackBarType.error,
      );
    }, (_) {
      NavigationService.pushNamed(Routes.home);

      UIService.displaySnackBar(
        context: context,
        message: 'Contato excluído',
        type: SnackBarType.success,
      );
    });
  }
}
