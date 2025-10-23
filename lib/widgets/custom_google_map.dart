import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:mapsapp/models/placeModel.dart';

class CustomGoogleMap extends StatefulWidget {
  const CustomGoogleMap({super.key});

  @override
  State<CustomGoogleMap> createState() => _CustomGoogleMapState();
}

class _CustomGoogleMapState extends State<CustomGoogleMap> {
  late CameraPosition initialCameraPosition;
  late String nightMode;
  GoogleMapController? googleMapController;
  Location location = Location();
  Set<Marker> markers = {};
  Set<Polyline> polyLines = {};
  Set<Polygon> polygons = {};

  @override
  void initState() {
    inquireAndEnableLocationService();
    intMapPolyLines();
    intMapPolygon();
    initialCameraPosition = const CameraPosition(
      target: LatLng(31.198166190837064, 29.917136444493792),
      zoom: 12,
    );
    initMarker();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: AlignmentGeometry.bottomCenter,
      children: [
        GoogleMap(
          //to add شكل مقفول
          // polygons: polygons,
          //شكل مفتوح
          //   polylines: polyLines,
          zoomControlsEnabled: false,
          markers: markers,
          //   mapType: MapType.satellite,
          onMapCreated: (controller) async {
            googleMapController = controller;
            //   intMapStyle();
          },
          initialCameraPosition: initialCameraPosition,
        ),
        //   IconButton(onPressed: (){}, icon: Icon(Icons.dark_mode_rounded)),
        Positioned(
          left: 16,
          right: 16,
          bottom: 16,
          child: ElevatedButton(
            onPressed: () async {/*
              LocationData currentLocationData = await location.getLocation();
              //change location of the map
              googleMapController!.animateCamera(
                CameraUpdate.newLatLng(
                  LatLng(
                    currentLocationData.latitude!,
                    currentLocationData.longitude!,
                  ),
                ),
              );
              Marker myLocationMarker = Marker(
                markerId: MarkerId('myLocation'),
                position: LatLng(currentLocationData.latitude!, currentLocationData.longitude!),
              );
              markers.add(myLocationMarker);
              setState(() {});*/
              await updateMyLocation();
            },
            child: const Text('live tracking'),
          ),
        ),
      ],
    );
  }

  void intMapStyle() async {
    nightMode = await rootBundle.loadString(
      'assets/googleMapsStyles/night_style.json',
    );
    googleMapController!.setMapStyle(nightMode);
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
    //markers.addAll(myMarkers);
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
  }

  void intMapPolygon() {
    var polygon = Polygon(
      fillColor: Colors.black38,
      strokeWidth: 0,
      //specify which line draw first
      zIndex: 1,
      //decide if the curve of the earth show or just a straight line
      geodesic: true,
      polygonId: PolygonId('1'),
      points: [
        LatLng(31.197361489921132, 29.904919533877298),
        LatLng(31.209142831933246, 29.909801147072955),
        LatLng(31.199674145961918, 29.91856661402628),
        LatLng(31.209768411289144, 29.927106767373314),
      ],
    );
    polygons.add(polygon);
  }

  Future<void> inquireAndEnableLocationService() async {
    var isLocationEnabled = await location.serviceEnabled();
    if (!isLocationEnabled) {
      isLocationEnabled = await location.requestService();
    }
    if (!isLocationEnabled) {
      ///Todo:pop-up error
    }
    inquireAndEnableLocationPermission();
  }

  Future<bool> inquireAndEnableLocationPermission() async {
    var permissionStatus = await location.hasPermission();
    if (permissionStatus == PermissionStatus.deniedForever) {
      return false;

      ///Todo:pop-up error
    }
    if (permissionStatus == PermissionStatus.denied) {
      permissionStatus = await location.requestPermission();
    }

    if (permissionStatus != PermissionStatus.granted) {
      return false;

      ///Todo:pop-up error
    }

    return true;
  }

  void getCurrentLocation() async {
location.changeSettings(distanceFilter: 1);
    location.onLocationChanged.listen((event) {
      googleMapController?.animateCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(target: LatLng(event.latitude!, event.longitude!),zoom: 16),
        ),
      );
      Marker myLocationMarker = Marker(
        markerId: MarkerId('myLocation'),
        position: LatLng(event.latitude!, event.longitude!),

      );
      markers.add(myLocationMarker);
      setState(() {});
    });
  }

  Future<void> updateMyLocation() async {
    await inquireAndEnableLocationService();
    await inquireAndEnableLocationPermission();
    getCurrentLocation();
  }
}
