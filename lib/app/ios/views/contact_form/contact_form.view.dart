import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:contacts/app/shared/modules/navigation/routes.dart';
import 'package:contacts/app/shared/utils/input_formatters.dart';
import 'package:contacts/app/shared/utils/services/binding_service.dart';
import 'package:contacts/app/shared/utils/services/navigation_service.dart';
import 'package:contacts/app/shared/utils/services/ui/ui_service.dart';
import 'package:contacts/app/shared/utils/validations/contact.dart';
import 'package:contacts/data/repositories/contact_repository.dart';
import 'package:contacts/domain/entities/contact.dart';

class ContactFormView extends StatefulWidget {
  final Contact? contact;

  ContactFormView({this.contact});

  @override
  _ContactFormViewState createState() => _ContactFormViewState();
}

class _ContactFormViewState extends State<ContactFormView> {
  final _repository = BindingService.get<ContactRepository>();

  final _scaffoldKey = new GlobalKey<ScaffoldState>();
  final _formKey = new GlobalKey<FormState>();

  final _validations = ContactValidations.validations;

  onSubmit() {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    _formKey.currentState!.save();

    if (widget.contact!.id == 0)
      createContact(widget.contact!);
    else
      updateContact();
  }

  createContact(Contact contact) {
    widget.contact!.id = null;
    widget.contact!.image = null;

    _repository
        .createContact(contact)
        .then((_) => onSuccess())
        .catchError((_) => onError());
  }

  updateContact() {
    _repository
        .updateContact(widget.contact!)
        .then((_) => onSuccess())
        .catchError((_) => onError());
  }

  onSuccess() async {
    await UIService.displaySnackBar(
      context: context,
      message:
          widget.contact!.id == 0 ? 'Contato criado' : 'Alterações salvas!',
      type: SnackBarType.success,
    );

    NavigationService.pushNamed(Routes.home);
  }

  onError() {
    UIService.displaySnackBar(
      context: context,
      message: 'Ops, algo deu errado!',
    );
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      key: _scaffoldKey,
      child: CustomScrollView(
        slivers: <Widget>[
          CupertinoSliverNavigationBar(
            largeTitle: widget.contact!.id == 0
                ? Text("Novo Contato")
                : Text("Editar Contato"),
          ),
          SliverFillRemaining(
            child: Padding(
              padding: EdgeInsets.only(top: 20, left: 10, right: 10),
              child: Form(
                key: _formKey,
                child: CupertinoFormSection(
                  children: <Widget>[
                    CupertinoFormRow(
                      prefix: Text('Nome'),
                      child: CupertinoTextFormFieldRow(
                        placeholder: widget.contact?.email ?? "Nome do contato",
                        keyboardType: TextInputType.text,
                        textCapitalization: TextCapitalization.words,
                        initialValue: widget.contact?.name,
                        onChanged: (value) {
                          widget.contact!.name = value;
                        },
                        validator: _validations['name'],
                      ),
                    ),
                    CupertinoFormRow(
                      prefix: Text('Telefone'),
                      child: CupertinoTextFormFieldRow(
                        placeholder: widget.contact?.phone ?? "(99) 99999-9999",
                        keyboardType: TextInputType.phone,
                        inputFormatters: [InputFormatters.phone],
                        initialValue: widget.contact?.phone,
                        onChanged: (value) {
                          widget.contact?.phone = value;
                        },
                        validator: _validations['phone'],
                      ),
                    ),
                    CupertinoFormRow(
                      prefix: Text('E-mail'),
                      child: CupertinoTextFormFieldRow(
                        placeholder:
                            widget.contact?.email ?? "E-mail do contato",
                        keyboardType: TextInputType.emailAddress,
                        initialValue: widget.contact?.email,
                        onChanged: (value) {
                          widget.contact?.email = value;
                        },
                        validator: _validations['email'],
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      width: double.infinity,
                      height: 50,
                      child: CupertinoButton.filled(
                        onPressed: onSubmit,
                        child: Text(
                          "Salvar",
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
