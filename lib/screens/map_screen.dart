import 'dart:async';

import 'package:flutter/material.dart';
import '../models/scan_model.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  Completer<GoogleMapController> _controller = Completer();
  MapType mapType = MapType.normal;

  @override
  Widget build(BuildContext context) {
    final scan = ModalRoute.of(context)!.settings.arguments as ScanModel;
    final latLng = scan.getLatLng();

    final CameraPosition initialCamera = CameraPosition(
      target: latLng,
      zoom: 17.0,
      tilt: 50,
    );

    //Markers
    Set<Marker> markers = <Marker>{};
    markers.add(
        Marker(markerId: const MarkerId('geo-location'), position: latLng));

    return Scaffold(
      appBar: AppBar(
        title: const Text('Map'),
        actions: [
          IconButton(
              onPressed: () async {
                _goToCameraPosition(initialCamera);
              },
              icon: const Icon(Icons.location_disabled))
        ],
      ),
      body: GoogleMap(
        mapType: mapType,
        initialCameraPosition: initialCamera,
        markers: markers,
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (mapType == MapType.normal) {
            mapType = MapType.satellite;
          } else {
            mapType = MapType.normal;
          }
          setState(() {}); // redibuja el widget cuando se cambio la propiedad
        },
        child: const Icon(Icons.layers),
      ),
    );
  }

  Future<void> _goToCameraPosition(CameraPosition position) async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(position));
  }
}
