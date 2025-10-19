import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mapsapp/models/placeModel.dart';

class CustomGoogleMap extends StatefulWidget {
  const CustomGoogleMap({super.key});

  @override
  State<CustomGoogleMap> createState() => _CustomGoogleMapState();
}

class _CustomGoogleMapState extends State<CustomGoogleMap> {
  late CameraPosition initialCameraPosition;
  late String nightMode;

  @override
  void initState() {
    initialCameraPosition = const CameraPosition(
      target: LatLng(31.198166190837064, 29.917136444493792),
      zoom: 13,
    );
    intMapStyle();
    initMarker();
    super.initState();
  }

  Set<Marker> markers = {};

  late GoogleMapController googleMapController;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: AlignmentGeometry.bottomCenter,
      children: [
        GoogleMap(
          zoomControlsEnabled: false,
          markers: markers,
          //   mapType: MapType.satellite,
          onMapCreated: (controller) async {
            googleMapController = controller;
          },
          initialCameraPosition: initialCameraPosition,
        ),
        //   IconButton(onPressed: (){}, icon: Icon(Icons.dark_mode_rounded)),
        Positioned(
          left: 16,
          right: 16,
          bottom: 16,
          child: ElevatedButton(
            onPressed: () {
              //change location of the map
              googleMapController.animateCamera(
                CameraUpdate.newLatLng(
                  LatLng(31.109060583785695, 30.120639261499885),
                ),
              );
            },
            child: const Text('click me'),
          ),
        ),
      ],
    );
  }

  void intMapStyle() async {
    nightMode = await rootBundle.loadString(
      'assets/googleMapsStyles/night_style.json',
    );
    googleMapController.setMapStyle(nightMode);
  }

  void initMarker() {
    var myMarkers = places
        .map(
          (e) => Marker(
            icon: BitmapDescriptor.defaultMarkerWithHue(100),
            markerId: MarkerId(e.id.toString()),
            position: e.latLng,
            infoWindow: InfoWindow(title: e.name),
          ),
        )
        .toSet();
    markers.addAll(myMarkers);
    setState(() {

    });
  }
}
