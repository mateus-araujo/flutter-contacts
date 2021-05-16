import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_multi_formatter/flutter_multi_formatter.dart';
import 'package:form_validator/form_validator.dart';

import 'package:contacts/app/android/utils/services/ui_service.dart';
import 'package:contacts/app/shared/modules/navigation/routes.dart';
import 'package:contacts/app/shared/utils/services/binding_service.dart';
import 'package:contacts/app/shared/utils/services/navigation_service.dart';
import 'package:contacts/data/repositories/contact_repository.dart';
import 'package:contacts/domain/entities/contact.dart';

class ContactFormView extends StatefulWidget {
  final Contact? contact;

  ContactFormView({this.contact});

  @override
  _ContactFormViewState createState() => _ContactFormViewState();
}

class _ContactFormViewState extends State<ContactFormView> {
  final _scaffoldKey = new GlobalKey<ScaffoldState>();
  final _formKey = new GlobalKey<FormState>();

  final _repository = BindingService.get<ContactRepository>();

  final validatorName = ValidationBuilder().minLength(3).build();
  final validatorPhone =
      ValidationBuilder().minLength(15, 'Telefone inválido').build();
  final validatorEmail = ValidationBuilder().email().build();

  final phoneInputFormatter = MaskedInputFormatter('(00) 00000-0000');

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

  onSuccess() {
    UIService.displaySnackBar(
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
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: widget.contact!.id == 0
            ? Text("Novo Contato")
            : Text("Editar Contato"),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              TextFormField(
                decoration: InputDecoration(labelText: "Nome"),
                keyboardType: TextInputType.text,
                textCapitalization: TextCapitalization.words,
                initialValue: widget.contact?.name,
                onChanged: (value) {
                  widget.contact?.name = value;
                },
                validator: validatorName,
                // initialValue: wi,
              ),
              TextFormField(
                decoration: InputDecoration(labelText: "Telefone"),
                keyboardType: TextInputType.phone,
                inputFormatters: [phoneInputFormatter],
                initialValue: widget.contact?.phone,
                onChanged: (value) {
                  widget.contact?.phone = value;
                },
                validator: validatorPhone,
              ),
              TextFormField(
                decoration: InputDecoration(labelText: "E-mail"),
                keyboardType: TextInputType.emailAddress,
                initialValue: widget.contact?.email,
                onChanged: (value) {
                  widget.contact?.email = value;
                },
                validator: validatorEmail,
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: onSubmit,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.save,
                        color: Theme.of(context).accentColor,
                      ),
                      SizedBox(width: 10),
                      Text(
                        "Salvar",
                        style: TextStyle(color: Theme.of(context).accentColor),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
