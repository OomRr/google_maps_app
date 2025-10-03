import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mapsapp/widgets/custom_google_map.dart';

void main() {
  runApp(const MapsApp());
}

class MapsApp extends StatelessWidget {
  const MapsApp({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomGoogleMap();
  }
}

///apiKeys=https://console.cloud.google.com/apis/credentials?project=maps-for-app-472216
