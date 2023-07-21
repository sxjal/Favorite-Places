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
  Location? _pickedlocation;
  var _isgettinglocation = false;

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
    final api_key = "AIzaSyDIAkaMMSpUkM5WM1U32tFm-90E7er4rWY";
    final url = Uri.parse(
        "https://maps.googleapis.com/maps/api/geocode/json?latlng=${locationData.latitude},${locationData.latitude}&key=$api_key");
    print(locationData.latitude);
    print(locationData.longitude);

    setState(() {
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
