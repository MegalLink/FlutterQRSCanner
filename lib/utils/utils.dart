import 'package:flutter/cupertino.dart';
import 'package:qr_reader/constants/scan_type_enum.dart';
import 'package:qr_reader/models/scan_model.dart';
import 'package:url_launcher/url_launcher.dart';

Future<void> launchURL(BuildContext context, ScanModel scan) async {
  final Uri url = Uri.parse(scan.value);
  if (scan.type == ScanTypeEnum.http.value) {
    if (!await launchUrl(url)) {
      throw 'Could not launch $url';
    }
  } else {
    Navigator.pushNamed(context, 'map', arguments: scan);
  }
}
