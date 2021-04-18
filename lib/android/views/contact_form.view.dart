import 'package:contacts/core/models/contact.model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_multi_formatter/flutter_multi_formatter.dart';
import 'package:form_validator/form_validator.dart';

class ContactFormView extends StatefulWidget {
  final ContactModel? model;

  ContactFormView({this.model});

  @override
  _ContactFormViewState createState() => _ContactFormViewState();
}

class _ContactFormViewState extends State<ContactFormView> {
  final _formKey = new GlobalKey<FormState>();

  final phoneInputFormatter = MaskedInputFormatter('(00) 00000-0000');

  onSubmit() {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    _formKey.currentState!.save();
  }

  final validatorName =
      ValidationBuilder().minLength(3, 'Mínimo de 3 caracteres').build();
  final validatorPhone =
      ValidationBuilder().minLength(15, 'Telefone inválido').build();
  final validatorEmail = ValidationBuilder().email('E-mail inválido').build();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: widget.model == null
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
                  onChanged: (value) {
                    widget.model?.phone = value;
                  },
                  validator: validatorPhone),
              TextFormField(
                decoration: InputDecoration(labelText: "E-mail"),
                keyboardType: TextInputType.emailAddress,
                initialValue: widget.model?.email,
                onChanged: (value) {
                  widget.model!.email = value;
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
