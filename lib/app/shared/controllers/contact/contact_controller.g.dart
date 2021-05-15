// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'contact_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$ContactController on _ContactController, Store {
  final _$contactAtom = Atom(name: '_ContactController.contact');

  @override
  Contact get contact {
    _$contactAtom.reportRead();
    return super.contact;
  }

  @override
  set contact(Contact value) {
    _$contactAtom.reportWrite(value, super.contact, () {
      super.contact = value;
    });
  }

  final _$getContactAsyncAction = AsyncAction('_ContactController.getContact');

  @override
  Future getContact(int id) {
    return _$getContactAsyncAction.run(() => super.getContact(id));
  }

  final _$deleteContactAsyncAction =
      AsyncAction('_ContactController.deleteContact');

  @override
  Future deleteContact(BuildContext context) {
    return _$deleteContactAsyncAction.run(() => super.deleteContact(context));
  }

  @override
  String toString() {
    return '''
contact: ${contact}
    ''';
  }
}
