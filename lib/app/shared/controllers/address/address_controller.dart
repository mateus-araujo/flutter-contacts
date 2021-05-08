import 'package:contacts/domain/entities/contact.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:location/location.dart';
import 'package:mapbox_gl/mapbox_gl.dart';

import 'package:contacts/app/android/utils/helpers/mapbox_helpers.dart';
import 'package:contacts/app/android/utils/services/ui_service.dart';
import 'package:contacts/data/repositories/address_repository.dart';
import 'package:contacts/device/repositories/location_repository.dart';

class AddressController {
  final Contact contact;
  final ValueNotifier<Contact> contactNotifier =
      ValueNotifier<Contact>(Contact());
  late MapboxMapController? _mapController;

  final _addressRepository = GetIt.instance.get<AddressRepository>();
  final _locationRepository = GetIt.instance.get<LocationRepository>();

  Symbol? _symbol;

  AddressController({required this.contact});

  Future<dynamic> onSearch(BuildContext context, String address) async {
    final result = await _addressRepository.searchAddress(address);

    final data = result.fold(
      (_) {
        UIService.displaySnackBar(
          context: context,
          message: 'Houve um erro na pesquisa',
        );

        return null;
      },
      (data) async {
        final latLng = LatLng(data['lat'], data['lng']);

        contact.addressLine1 = data['addressLine1'];
        contact.addressLine2 = data['addressLine2'];

        contactNotifier.value = contact;

        await updateSymbolLocation(latLng);

        return data;
      },
    );

    return data;
  }

  void onMapCreated(MapboxMapController controller) async {
    _mapController = controller;
    final latLng = await _getLatLng();

    await _addMarker(latLng);
    // final symbol = await _addMarker(latLng);

    // _locationRepository.onLocationChanged().listen((location) async {
    //   _onLocationChanged(location, symbol!);
    // });

    await _mapController!.animateCamera(CameraUpdate.newLatLng(latLng));
  }

  Future<LatLng> _getLatLng() async {
    await _locationRepository.requestLocationPermissions();

    final location = await _locationRepository.getLocation();
    final latLng = mapLocationToLatLng(location);

    return latLng;
  }

  Future<Symbol?> _addMarker(LatLng latLng) async {
    final image = await getImageFromAsset('assets/images/marker.png');

    await _mapController!.addImage('asset-marker', image);

    _symbol = await _mapController!.addSymbol(SymbolOptions(
      iconImage: 'asset-marker',
      geometry: latLng,
      iconSize: 0.25,
      iconAnchor: 'bottom',
    ));

    return _symbol;
  }

  Future _onLocationChanged(LocationData location) async {
    final latLng = mapLocationToLatLng(location);

    await updateSymbolLocation(latLng);
  }

  Future<void> updateSymbolLocation(LatLng latLng) async {
    await _mapController!.updateSymbol(
      _symbol!,
      SymbolOptions(geometry: latLng),
    );

    await _mapController!.animateCamera(CameraUpdate.newLatLng(latLng));
  }
}
