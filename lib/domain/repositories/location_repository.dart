import 'package:location/location.dart';

abstract class ILocationRepository {
  Future<LocationData> getLocation();
  Stream<LocationData> onLocationChanged();
  Future<void> requestLocationPermissions();
}
