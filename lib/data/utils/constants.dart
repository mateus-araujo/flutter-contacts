import 'package:flutter_dotenv/flutter_dotenv.dart';

class Constants {
  static String mapboxAccessToken = env['MAPBOX_ACCESS_TOKEN'] as String;
}
