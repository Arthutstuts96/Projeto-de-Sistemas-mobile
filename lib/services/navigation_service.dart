import 'dart:io' show Platform;
import 'package:url_launcher/url_launcher.dart';

class NavigationService {
  String _buildWazeUrl(double endLatitude, double endLongitude) {
    return 'waze://?ll=$endLatitude,$endLongitude&navigate=yes';
  }

  String _buildGoogleMapsUrl(
    double startLatitude,
    double startLongitude,
    double endLatitude,
    double endLongitude,
  ) {
    return 'https://www.google.com/maps/dir/?api=1&origin=$startLatitude,$startLongitude&destination=$endLatitude,$endLongitude&travelmode=driving';
  }

  Future<bool> navigateTo({
    required double startLatitude,
    required double startLongitude,
    required double endLatitude,
    required double endLongitude,
    bool isToMercado = true,
  }) async {
    final wazeUrl = Uri.parse(_buildWazeUrl(endLatitude, endLongitude));
    final googleMapsUrl = Uri.parse(
      _buildGoogleMapsUrl(
        startLatitude,
        startLongitude,
        endLatitude,
        endLongitude,
      ),
    );

    try {
      if (Platform.isAndroid) {
        if (await canLaunchUrl(wazeUrl)) {
          await launchUrl(wazeUrl, mode: LaunchMode.externalApplication);
          return true;
        } else if (await canLaunchUrl(googleMapsUrl)) {
          await launchUrl(googleMapsUrl, mode: LaunchMode.externalApplication);
          return true;
        } else {
          print(
            'Waze e Google Maps apps não encontrados. Tentando abrir Google Maps no navegador.',
          );
          if (await canLaunchUrl(googleMapsUrl)) {
            await launchUrl(
              googleMapsUrl,
              mode: LaunchMode.externalApplication,
            );
            return true;
          } else {
            print('Não foi possível abrir o Google Maps no navegador.');
            return false;
          }
        }
      }
      return false;
    } catch (e) {
      print('Erro ao tentar iniciar navegação: $e');
      return false;
    }
  }
}
