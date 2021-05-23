import 'dart:io';

import 'package:flutter/material.dart';

import 'package:location/location.dart';
import 'package:mapbox_gl/mapbox_gl.dart';

import 'package:contacts/app/shared/controllers/contact/contact_controller.dart';
import 'package:contacts/app/shared/utils/helpers/mapbox_helpers.dart';
import 'package:contacts/app/shared/utils/services/binding_service.dart';
import 'package:contacts/app/shared/utils/services/navigation_service.dart';
import 'package:contacts/app/shared/utils/services/ui/ui_service.dart';
import 'package:contacts/data/repositories/address_repository.dart';
import 'package:contacts/data/repositories/contact_repository.dart';
import 'package:contacts/device/repositories/location_repository.dart';
import 'package:contacts/domain/entities/contact.dart';

class AddressController {
  final Contact contact;
  late MapboxMapController _mapController;

  final _addressRepository = BindingService.get<AddressRepository>();
  final _contactController = BindingService.get<ContactController>();
  final _contactRepository = BindingService.get<ContactRepository>();
  final _locationRepository = BindingService.get<LocationRepository>();

  late Symbol _symbol;

  AddressController({
    required this.contact,
  });

  Future<dynamic> onSearch(BuildContext context, String address) async {
    final result = await _addressRepository.searchAddress(address);

    final data = result.fold(
      (_) {
        UIService.displaySnackBar(
          context: context,
          message: 'Houve um erro na pesquisa',
          type: SnackBarType.alert,
        );

        return null;
      },
      (data) async {
        final latLng = LatLng(data['lat'], data['lng']);

        contact.addressLine1 = data['addressLine1'];
        contact.addressLine2 = data['addressLine2'];
        contact.latLng = '${data['lat']},${data['lng']}';

        await updateSymbolLocation(latLng);

        return data;
      },
    );

    return data;
  }

  Future updateContactAddress(BuildContext context) async {
    final latLng = await _mapController.getSymbolLatLng(_symbol);

    final result = await _contactRepository.updateAddress(
      contact.id!,
      contact.addressLine1!,
      contact.addressLine2!,
      "${latLng.latitude},${latLng.longitude}",
    );

    result.fold(
      (l) => UIService.displaySnackBar(
        context: context,
        message: 'Houve um erro ao salvar o contato',
        type: SnackBarType.error,
      ),
      (id) async {
        await UIService.displaySnackBar(
          context: context,
          message: 'Endereço atualizado',
        );

        _contactController.getContact(contact.id!);
        NavigationService.pop();
      },
    );
  }

  void onMapCreated(MapboxMapController controller) async {
    _mapController = controller;

    late LatLng latLng;

    if (this.contact.latLng == null || this.contact.latLng == '') {
      latLng = await _getLatLng();
    } else {
      List<String> location = contact.latLng!.split(',');

      latLng = LatLng(
        double.parse(location.first),
        double.parse(location.last),
      );
    }

    await _addMarker(latLng);
    await _mapController.animateCamera(CameraUpdate.newLatLng(latLng));
  }

  Future<LatLng> _getLatLng() async {
    await _locationRepository.requestLocationPermissions();

    final location = await _locationRepository.getLocation();
    final latLng = mapLocationToLatLng(location);

    return latLng;
  }

  Future<Symbol?> _addMarker(LatLng latLng) async {
    final image = await getImageFromAsset('assets/images/marker.png');

    await _mapController.addImage('asset-marker', image);

    _symbol = await _mapController.addSymbol(SymbolOptions(
      iconImage: 'asset-marker',
      geometry: latLng,
      iconSize: Platform.isIOS ? 0.1 : 0.25,
      iconAnchor: 'bottom',
      draggable: true,
    ));

    return _symbol;
  }

  Future onLocationChanged(LocationData location) async {
    final latLng = mapLocationToLatLng(location);

    await updateSymbolLocation(latLng);
  }

  Future<void> updateSymbolLocation(LatLng latLng,
      {bool animate = true}) async {
    await _mapController.updateSymbol(
      _symbol,
      SymbolOptions(geometry: latLng),
    );

    if (animate) {
      await _mapController.animateCamera(CameraUpdate.newLatLng(latLng));
    }
  }
}
