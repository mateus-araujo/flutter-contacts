import 'package:contacts/core/interfaces/database/database_service.dart';
import 'package:contacts/core/models/contact.model.dart';

abstract class ContactRepository {
  Future createContact(ContactModel model);
  Future<List<ContactModel>?> getContacts();
  Future<List<ContactModel>?> searchByName(String term);
  Future<ContactModel?> getContactById(int id);
  Future updateContact(ContactModel model);
  Future deleteContact(int id);
  Future updateImage(int id, String imagePath);
  Future updateAddress(
    int id,
    String addressLine1,
    String addressLine2,
    String latLng,
  );
}

class ContactRepositoryImpl implements ContactRepository {
  DatabaseService service;
  ContactRepositoryImpl(this.service);

  @override
  Future createContact(ContactModel model) async {
    try {
      await service.insert(model.toMap());
    } catch (e) {
      print(e);
    }
  }

  @override
  Future<List<ContactModel>?> getContacts() async {
    try {
      final maps = await service.getList();

      return List.generate(
        maps.length,
        (index) => ContactModel.fromMap(maps[index]),
      );
    } catch (e) {
      print(e);
    }
  }

  @override
  Future<List<ContactModel>?> searchByName(String term) async {
    try {
      final maps = await service.searchTextByField('name', term);

      return List.generate(
        maps.length,
        (index) => ContactModel.fromMap(maps[index]),
      );
    } catch (e) {
      print(e);
    }
  }

  @override
  Future<ContactModel?> getContactById(int id) async {
    try {
      final map = await service.getFirstById(id);

      return ContactModel.fromMap(map);
    } catch (e) {
      print(e);
    }
  }

  @override
  Future updateContact(ContactModel model) async {
    try {
      await service.update(model.id!, model.toMap());
    } catch (e) {
      print(e);
    }
  }

  @override
  Future deleteContact(int id) async {
    try {
      await service.delete(id);
    } catch (e) {
      print(e);
    }
  }

  @override
  Future updateImage(int id, String imagePath) async {
    try {
      final contact = await getContactById(id);

      contact!.image = imagePath;

      service.update(id, contact.toMap());
    } catch (e) {
      print(e);
    }
  }

  @override
  Future updateAddress(
      int id, String addressLine1, String addressLine2, String latLng) async {
    try {
      final contact = await getContactById(id);

      contact!.addressLine1 = addressLine1;
      contact.addressLine2 = addressLine2;
      contact.latLng = latLng;

      service.update(id, contact.toMap());
    } catch (e) {
      print(e);
    }
  }
}
