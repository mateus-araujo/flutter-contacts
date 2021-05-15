import 'package:flutter/material.dart';
import 'package:mapbox_gl/mapbox_gl.dart';

import 'package:contacts/app/shared/controllers/address/address_controller.dart';
import 'package:contacts/data/utils/constants.dart';
import 'package:contacts/domain/entities/contact.dart';

class AddressView extends StatefulWidget {
  final Contact contact;

  const AddressView({Key? key, required this.contact}) : super(key: key);

  @override
  _AddressViewState createState() => _AddressViewState();
}

class _AddressViewState extends State<AddressView> {
  late final _addressController = AddressController(contact: widget.contact);

  handleSearch(String address) async {
    await _addressController.onSearch(context, address);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Endereço do Contato"),
        actions: [
          TextButton(
            child: Icon(Icons.save),
            onPressed: () {
              _addressController.updateContactAddress(context);
            },
          ),
        ],
      ),
      body: Column(
        children: <Widget>[
          Container(
            height: 80,
            child: ListTile(
              title: Text(
                "Endereço atual",
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                ),
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    _addressController.contact.addressLine1 ?? "",
                    style: TextStyle(
                      fontSize: 12,
                    ),
                  ),
                  Text(
                    _addressController.contact.addressLine2 ?? "",
                    style: TextStyle(
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
              isThreeLine: true,
            ),
          ),
          Container(
            height: 80,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: TextFormField(
                decoration: InputDecoration(
                  labelText: "Pesquisar...",
                ),
                onFieldSubmitted: (value) => handleSearch(value),
              ),
            ),
          ),
          Expanded(
            child: MapboxMap(
              accessToken: Constants.mapboxAccessToken,
              onMapCreated: _addressController.onMapCreated,
              initialCameraPosition: CameraPosition(
                target: LatLng(-3.74182, -38.50227),
                zoom: 16,
              ),
              onStyleLoadedCallback: onStyleLoadedCallback,
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Icon(Icons.my_location),
      ),
    );
  }

  void onStyleLoadedCallback() {}
}
