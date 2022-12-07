import 'dart:convert';

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
