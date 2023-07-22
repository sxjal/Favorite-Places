import 'package:favorite_places/models/place.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({
    super.key,
    this.location =
        const PlaceLocation(latitude: 37.42, longitude: -122.08, address: ""),
    this.isselecting = true,
  });

  final PlaceLocation location;
  final bool isselecting;
  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  LatLng? _pickedlocation;

  @override
  Widget build(context) {
    return Scaffold(
      appBar: AppBar(
        title:
            Text(widget.isselecting ? 'Pick Your Location' : "Your Location"),
        actions: [
          if (widget.isselecting)
            IconButton(
              onPressed: () {
                Navigator.of(context).pop(_pickedlocation);
              },
              icon: const Icon(
                Icons.save,
              ),
            ),
        ],
      ),
      body: GoogleMap(
        onTap: !widget.isselecting
            ? null
            : (position) {
                setState(
                  () {
                    _pickedlocation = position;
                  },
                );
              },
        initialCameraPosition: CameraPosition(
          target: LatLng(
            widget.location.latitude,
            widget.location.longitude,
          ),
          zoom: 16,
        ),
        markers: (_pickedlocation == null && widget.isselecting)
            ? {}
            : {
                Marker(
                  markerId: const MarkerId("m1"),
                  position: _pickedlocation ??
                      LatLng(
                        widget.location.latitude,
                        widget.location.longitude,
                      ),
                ),
              },
      ),
    );
  }
}
