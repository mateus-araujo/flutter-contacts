import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_multi_formatter/flutter_multi_formatter.dart';
import 'package:form_validator/form_validator.dart';

import 'package:contacts/android/views/home.view.dart';

import 'package:contacts/core/models/contact.model.dart';
import 'package:contacts/core/repositories/contact_repository.dart';

class ContactFormView extends StatefulWidget {
  final ContactModel? model;

  ContactFormView({this.model});

  @override
  _ContactFormViewState createState() => _ContactFormViewState();
}

class _ContactFormViewState extends State<ContactFormView> {
  final _scaffoldKey = new GlobalKey<ScaffoldState>();
  final _formKey = new GlobalKey<FormState>();

  late final ContactRepository _repository;

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

    if (widget.model!.id == 0)
      createContact(widget.model!);
    else
      updateContact();
  }

  createContact(ContactModel model) {
    widget.model!.id = null;
    widget.model!.image = null;

    _repository
        .createContact(model)
        .then((_) => onSuccess())
        .catchError((_) => onError());
  }

  updateContact() {
    _repository
        .updateContact(widget.model!)
        .then((_) => onSuccess())
        .catchError((_) => onError());
  }

  onSuccess() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => HomeView(),
      ),
    );
  }

  onError() {
    final snackBar = SnackBar(
      content: Text('Ops, algo deu errado!'),
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  void initContactRepository() async {
    _repository = await ContactRepository.repository;

    final contacts = await _repository.getContacts();
    print('contacts.length: ${contacts!.length}');
  }

  @override
  void initState() {
    super.initState();
    initContactRepository();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: widget.model!.id == 0
            ? Text("Novo Contato")
            : Text("Editar Contato"),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
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
                initialValue: widget.model?.name,
                onChanged: (value) {
                  widget.model?.name = value;
                },
                validator: validatorName,
                // initialValue: wi,
              ),
              TextFormField(
                decoration: InputDecoration(labelText: "Telefone"),
                keyboardType: TextInputType.phone,
                inputFormatters: [phoneInputFormatter],
                initialValue: widget.model?.phone,
                onChanged: (value) {
                  widget.model?.phone = value;
                },
                validator: validatorPhone,
              ),
              TextFormField(
                decoration: InputDecoration(labelText: "E-mail"),
                keyboardType: TextInputType.emailAddress,
                initialValue: widget.model?.email,
                onChanged: (value) {
                  widget.model?.email = value;
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
