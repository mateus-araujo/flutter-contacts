import 'dart:convert';

class ContactModel {
  int? id = 0;
  String? name = "";
  String? email = "";
  String? phone = "";
  String? image = "assets/images/profile-picture.png";
  String? addressLine1 = "";
  String? addressLine2 = "";
  String? latLng = "";

  ContactModel({
    this.id,
    this.name,
    this.email,
    this.phone,
    this.image,
    this.addressLine1,
    this.addressLine2,
    this.latLng,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'phone': phone,
      'image': image,
      'addressLine1': addressLine1,
      'addressLine2': addressLine2,
      'latLng': latLng,
    };
  }

  factory ContactModel.fromMap(Map<String, dynamic> map) {
    return ContactModel(
      id: map['id'],
      name: map['name'],
      email: map['email'],
      phone: map['phone'],
      image: map['image'],
      addressLine1: map['addressLine1'],
      addressLine2: map['addressLine2'],
      latLng: map['latLng'],
    );
  }

  String toJson() => json.encode(toMap());

  factory ContactModel.fromJson(String source) =>
      ContactModel.fromMap(json.decode(source));
}
