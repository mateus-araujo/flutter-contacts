import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import 'package:contacts/data/services/http_service.dart';
import 'package:contacts/data/utils/constants.dart';
import 'package:contacts/domain/errors/errors.dart';
import 'package:contacts/domain/repositories/address_repository.dart';

class AddressRepository implements IAddressRepository {
  late HttpService _service;

  String _mapboxAccessToken = Constants.mapboxAccessToken;

  AddressRepository() {
    _service = HttpService(
      baseUrl: 'https://api.mapbox.com/geocoding/v5',
      queryParameters: {
        'access_token': _mapboxAccessToken,
      },
    );
  }

  @override
  Future<Either<Failure, dynamic>> searchAddress(String address) async {
    try {
      Response response = await _service.get('/mapbox.places/$address.json');
      dynamic data = jsonDecode(response.data);

      List features = data['features'];
      Map feature = features.first;

      String number = feature['address'];
      String street = feature['text'];

      List context = feature['context'];

      Map place = context
          .firstWhere((element) => (element['id'] as String).contains('place'));
      String city = place['text'];

      Map region = context.firstWhere(
          (element) => (element['id'] as String).contains('region'));
      String state = (region['short_code'] as String).replaceAll('BR-', '');

      List center = feature['center'];

      return Right({
        'addressLine1': "$street, $number",
        'addressLine2': "$city - $state",
        'lat': center.last,
        'lng': center.first,
      });
    } catch (e) {
      return Left(HttpError());
    }
  }
}
