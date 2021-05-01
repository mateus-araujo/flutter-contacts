class ContactsDatabase {
  static const String DATABASE_NAME = "contacts.db";
  static const String TABLE_NAME = "contacts";
  static const String CREATE_CONTACTS_TABLE_SCRIPT =
      "CREATE TABLE contacts(id INTEGER PRIMARY KEY, [name] TEXT, email TEXT, phone TEXT, [image] TEXT, addressLine1 TEXT, addressLine2 TEXT, latLng TEXT)";
}
