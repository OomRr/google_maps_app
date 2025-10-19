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
  late GoogleMapController googleMapController;

  Set<Marker> markers = {};
  Set<Polyline> polyLines = {};

  @override
  void initState() {
    intMapPolyLines();
    initialCameraPosition = const CameraPosition(
      target: LatLng(31.198166190837064, 29.917136444493792),
      zoom: 12,
    );
    intMapStyle();

    initMarker();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: AlignmentGeometry.bottomCenter,
      children: [
        GoogleMap(
          polylines: polyLines,
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
    setState(() {});
  }

  void intMapPolyLines() {
    var polyLine = Polyline(
      //specify which line draw first
      zIndex: 1,
      //decide if the curve of the earth show or just a straight line
      geodesic: true,
      polylineId: PolylineId('1'),
      points: [
        LatLng(31.197361489921132, 29.904919533877298),
        LatLng(31.209142831933246, 29.909801147072955),
        LatLng(31.199674145961918, 29.91856661402628),
        LatLng(31.209768411289144, 29.927106767373314),
      ],
      color: Colors.black,
    );
    polyLines.add(polyLine);
    setState(() {});
  }
}
