import 'package:flutter/cupertino.dart';

import 'package:mapbox_gl/mapbox_gl.dart';

import 'package:contacts/app/ios/styles.dart';
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
    return CupertinoPageScaffold(
      child: CustomScrollView(
        slivers: <Widget>[
          CupertinoSliverNavigationBar(
            largeTitle: Text("Endereço"),
            trailing: CupertinoButton(
              child: Icon(
                CupertinoIcons.location,
              ),
              onPressed: () {
                _addressController.updateContactAddress(context);
              },
            ),
          ),
          SliverFillRemaining(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                SizedBox(
                  width: double.infinity,
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Text(
                    "Endereço atual",
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Text(
                    _addressController.contact.addressLine1 ?? "",
                    style: TextStyle(
                      fontSize: 12,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Text(
                    _addressController.contact.addressLine2 ?? "",
                    style: TextStyle(
                      fontSize: 12,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: CupertinoTextField(
                    placeholder: "Pesquisar...",
                    onSubmitted: (value) => handleSearch(value),
                  ),
                ),
                Expanded(
                  child: Container(
                    color: primaryColor.withOpacity(0.2),
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
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void onStyleLoadedCallback() {}
}
