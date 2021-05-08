import 'dart:typed_data';

import 'package:contacts/data/services/http_service.dart';
import 'package:dio/dio.dart';
import 'package:flutter/services.dart';
import 'package:get_it/get_it.dart';
import 'package:location/location.dart';
import 'package:mapbox_gl/mapbox_gl.dart';

LatLng mapLocationToLatLng(LocationData locationData) {
  return LatLng(locationData.latitude!, locationData.longitude!);
}

LatLng mapUserLocationToLatLng(UserLocation userLocation) {
  return LatLng(
    userLocation.position.latitude,
    userLocation.position.longitude,
  );
}

List<LatLng> mapLocationListToLatLngList(List<LocationData> locationList) {
  return locationList.map((location) => mapLocationToLatLng(location)).toList();
}

Future<Uint8List> getImageFromAsset(String path) async {
  final ByteData byteData = await rootBundle.load(path);
  final Uint8List bytes = byteData.buffer.asUint8List();

  return bytes;
}

Future<Uint8List> getImageFromUrl(String url) async {
  final service = GetIt.instance.get<HttpService>();
  final response = await service.get(
    url,
    options: Options(responseType: ResponseType.bytes),
  );

  return response.data;
}
