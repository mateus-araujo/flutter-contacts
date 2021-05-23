import 'package:location/location.dart';

import 'package:contacts/domain/repositories/location_repository.dart';

class LocationRepository implements ILocationRepository {
  final Location _location;

  LocationRepository() : _location = Location();

  @override
  Future<LocationData> getLocation() async {
    try {
      LocationData location = await _location.getLocation();

      return location;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Stream<LocationData> onLocationChanged() {
    return _location.onLocationChanged;
  }

  @override
  Future<void> requestLocationPermissions() async {
    bool serviceEnabled = await _location.serviceEnabled();
    PermissionStatus permissionStatus = await _location.hasPermission();

    if (!serviceEnabled) {
      serviceEnabled = await _location.requestService();
    }

    if (permissionStatus == PermissionStatus.denied) {
      permissionStatus = await _location.requestPermission();
    }
  }
}
