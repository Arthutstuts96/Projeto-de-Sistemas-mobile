import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';

class LocationService {
  final LocationSettings _defaultLocationSettings = const LocationSettings(
    accuracy:
        LocationAccuracy.high,
    distanceFilter: 0, 
  );

  Future<Position> getCurrentLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Serviços de localização desabilitados.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Permissões de localização negadas.');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
        'Permissões de localização negadas permanentemente. Não podemos solicitar permissões.',
      );
    }

    return await Geolocator.getCurrentPosition(
      locationSettings:
          _defaultLocationSettings,
    );
  }

  Future<Position?> getLastKnownLocation() async {
    return await Geolocator.getLastKnownPosition();
  }
}
