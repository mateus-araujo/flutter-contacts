import 'package:form_validator/form_validator.dart';

class ContactValidations {
  static Map<String, String? Function(String?)> validations = {
    'name': ValidationBuilder().minLength(3).build(),
    'phone': ValidationBuilder().minLength(15, 'Telefone inválido').build(),
    'email': ValidationBuilder().email().build()
  };
}
