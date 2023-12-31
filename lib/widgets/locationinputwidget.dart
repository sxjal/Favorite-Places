import 'dart:convert';
import 'package:favorite_places/screens/map.dart';
import 'package:favorite_places/widgets/apikey.dart';
import 'package:favorite_places/models/place.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:http/http.dart' as http;

class LocationInput extends StatefulWidget {
  const LocationInput({super.key, required this.onselectlocation});

  final void Function(PlaceLocation location) onselectlocation;
  @override
  State<LocationInput> createState() {
    return _LocationInputState();
  }
}

class _LocationInputState extends State<LocationInput> {
  PlaceLocation? _pickedlocation;
  var _isgettinglocation = false;

  String get locationimage {
    if (_pickedlocation == null) {
      return "";
    }
    final key = ApiKey().getkey();
    final lat = _pickedlocation!.latitude;
    final lang = _pickedlocation!.longitude;

    return "https://maps.googleapis.com/maps/api/staticmap?center=$lat,$lang&zoom=16&size=600x300&maptype=roadmap&markers=color:blueA%7Clabel:S%7C$lat,$lang&key=$key";
  }

  Future<void> _saveplace(double lat, double lng) async {
    final key = ApiKey().getkey();
    final url = Uri.parse(
        "https://maps.googleapis.com/maps/api/geocode/json?latlng=$lat,$lng&key=$key");

    final locationresponse = await http.get(url);

    final String address =
        json.decode(locationresponse.body)['results'][0]['formatted_address'];

    setState(() {
      _pickedlocation = PlaceLocation(
        latitude: lat,
        longitude: lng,
        address: address,
      );
      print(address);
      _isgettinglocation = false;
    });

    widget.onselectlocation(_pickedlocation!);
  }

  void _getcurrentLocation() async {
    Location location = Location();

    bool serviceEnabled;
    PermissionStatus permissionGranted;
    LocationData locationData;

    serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) {
        return;
      }
    }

    permissionGranted = await location.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await location.requestPermission();
      if (permissionGranted != PermissionStatus.granted) {
        return;
      }
    }

    setState(() {
      _isgettinglocation = true;
    });

    locationData = await location.getLocation();

    _saveplace(locationData.latitude!, locationData.longitude!);
  }

  void _selectonmap() async {
    final pickedlocation = await Navigator.of(context).push<LatLng>(
      MaterialPageRoute(
        builder: (ctx) => const MapScreen(),
      ),
    );

    if (pickedlocation == null) {
      return;
    } else {
      _saveplace(pickedlocation.latitude, pickedlocation.longitude);
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget previewcontent = Text(
      "No location choosen",
      style: Theme.of(context).textTheme.bodyLarge!.copyWith(
            color: Theme.of(context).colorScheme.onBackground,
          ),
    );

    if (_pickedlocation != null) {
      previewcontent = Image.network(
        locationimage,
        fit: BoxFit.cover,
        width: double.infinity,
      );
    }

    if (_isgettinglocation) {
      previewcontent = CircularProgressIndicator(
        color: Theme.of(context).colorScheme.onBackground,
      );
    }
    return Column(
      children: [
        const SizedBox(
          height: 10,
        ),
        Container(
          height: 170,
          width: double.infinity,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            border: Border.all(
              width: 1,
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
          child: previewcontent,
        ),
        const SizedBox(
          height: 10,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            //one to get automatically the location
            TextButton.icon(
              icon: const Icon(
                Icons.location_on,
              ),
              onPressed: _getcurrentLocation,
              label: const Text(
                "Get Current Location",
              ),
            ),
            const Spacer(),
            //one to get the map
            TextButton.icon(
              icon: const Icon(
                Icons.map,
              ),
              onPressed: _selectonmap,
              label: const Text(
                "Select Location on Map",
              ),
            ),
          ],
        ),
      ],
    );
  }
}
