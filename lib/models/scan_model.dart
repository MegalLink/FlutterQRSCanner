import 'dart:convert';

import 'package:google_maps_flutter/google_maps_flutter.dart' show LatLng;
import 'package:qr_reader/constants/scan_type_enum.dart';

class ScanModel {
  int? id;
  String? type;
  String value;

  ScanModel({
    this.id,
    this.type,
    required this.value,
  }) {
    if (value.contains(ScanTypeEnum.http.value)) {
      type = ScanTypeEnum.http.value;
    } else {
      type = ScanTypeEnum.geo.value;
    }
  }

  LatLng getLatLng() {
    final latLng = value.substring(4).split('?')[0].split(',');
    final lat = double.parse(latLng[0]);
    final lng = double.parse(latLng[1]);

    return LatLng(lat, lng);
  }

  factory ScanModel.fromJson(String str) => ScanModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ScanModel.fromMap(Map<String, dynamic> json) => ScanModel(
        id: json["id"],
        type: json["type"],
        value: json["value"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "type": type,
        "value": value,
      };
}
