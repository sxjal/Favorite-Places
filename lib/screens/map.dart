import 'package:favorite_places/models/place.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

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
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  @override
  Widget build(context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Map'),
      ),
    );
  }
}
