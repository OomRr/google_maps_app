import 'package:google_maps_flutter/google_maps_flutter.dart';

class PlaceModel {
  final int id;
  final String name;
  final LatLng latLng;

  PlaceModel(this.id, this.name, this.latLng);

}
List<PlaceModel>places=[
  PlaceModel(1, 'وسط البلد',LatLng(31.197962210776197,29.90064583025169)),
  PlaceModel(1, 'اولاد عبدة',LatLng(31.192743698111578, 29.89970214266466)),
  PlaceModel(1, 'فندق برج الثغر',LatLng(31.197134606308843, 29.90485563794949)),
];