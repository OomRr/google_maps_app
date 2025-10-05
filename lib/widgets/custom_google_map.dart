import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class CustomGoogleMap extends StatefulWidget {
  const CustomGoogleMap({super.key});

  @override
  State<CustomGoogleMap> createState() => _CustomGoogleMapState();
}

class _CustomGoogleMapState extends State<CustomGoogleMap> {
  late CameraPosition initialCameraPosition;

  @override
  void initState() {
    initialCameraPosition = const CameraPosition(
      target: LatLng(31.198166190837064, 29.917136444493792),
      zoom: 13,
    );
    super.initState();
  }

  late GoogleMapController googleMapController;

  @override
  Widget build(BuildContext context) {
    return
       Stack(
        alignment: AlignmentGeometry.bottomCenter,
        children: [
          GoogleMap(
            onMapCreated: (controller) {
              googleMapController = controller;
            },
            initialCameraPosition: initialCameraPosition,
          ),
         IconButton(onPressed: (){}, icon: Icon(Icons.dark_mode_rounded)),
          Positioned(
            left: 16,
            right: 16,
            bottom: 16,
            child: ElevatedButton(onPressed: () {}, child: const Text('data')),
          ),
        ],
      );

  }
}
