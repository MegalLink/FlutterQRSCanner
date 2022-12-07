import 'package:flutter/material.dart';
import '../models/scan_model.dart';

class MapScreen extends StatelessWidget {
  const MapScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final scan = ModalRoute.of(context)!.settings.arguments as ScanModel;
    return Scaffold(
      appBar: AppBar(title: Text('Map')),
      body: Center(child: Text(scan.value)),
    );
  }
}
