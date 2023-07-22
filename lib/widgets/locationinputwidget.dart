import 'dart:convert';
import 'package:favorite_places/widgets/apikey.dart';
import 'package:favorite_places/models/place.dart';
import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:http/http.dart' as http;

class LocationInput extends StatefulWidget {
  const LocationInput({super.key});

  @override
  State<LocationInput> createState() {
    return _LocationInputState();
  }
}

class _LocationInputState extends State<LocationInput> {
  PlaceLocation? _pickedlocation;
  var _isgettinglocation = false;

  String get LocationImage {
    return "https://maps.googleapis.com/maps/api/staticmap?center=Brooklyn+Bridge,New+York,NY&zoom=13&size=600x300&maptype=roadmap&markers=color:blue%7Clabel:S%7C40.702147,-74.015794&markers=color:green%7Clabel:G%7C40.711614,-74.012318&markers=color:red%7Clabel:C%7C40.718217,-73.998284&key=YOUR_API_KEY&signature=YOUR_SIGNATURE";
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

    final key = ApiKey().getkey();

    final lat = locationData.latitude;
    final lang = locationData.longitude;

    final url = Uri.parse(
        "https://maps.googleapis.com/maps/api/geocode/json?latlng=$lat,$lang&key=$key");

    if (lat == null || lang == null) {
      return;
    }

    final locationresponse = await http.get(url);

    final String address =
        json.decode(locationresponse.body)['results'][0]['formatted_address'];

    setState(() {
      _pickedlocation = PlaceLocation(
        latitude: lat,
        longitude: lang,
        address: address,
      );
      print(address);
      _isgettinglocation = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget previewcontent = Text(
      "No location choosen",
      style: Theme.of(context).textTheme.bodyLarge!.copyWith(
            color: Theme.of(context).colorScheme.onBackground,
          ),
    );

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
              onPressed: () {},
              label: const Text(
                "Select Location Manually",
              ),
            ),
          ],
        ),
      ],
    );
  }
}
