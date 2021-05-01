import 'package:form_validator/form_validator.dart';

class ValidationLocale extends FormValidatorLocale {
  @override
  String email(String v) {
    return 'E-mail inválido';
  }

  @override
  String ip(String v) {
    return 'IPv4 inválido';
  }

  @override
  String ipv6(String v) {
    return 'IPv6 inválido';
  }

  @override
  String maxLength(String v, int n) {
    return 'Máximo de $n caracteres';
  }

  @override
  String minLength(String v, int n) {
    return 'Mínimo de $n caracteres';
  }

  @override
  String name() {
    return 'validation_locale';
  }

  @override
  String phoneNumber(String v) {
    return 'Nṹmero de telefone inválido';
  }

  @override
  String required() {
    return 'Campo obrigatório';
  }

  @override
  String url(String v) {
    return 'Url inválida';
  }
}
