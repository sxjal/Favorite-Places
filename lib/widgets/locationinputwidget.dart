import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class LocationInput extends StatefulWidget {
  const LocationInput({super.key});

  @override
  State<LocationInput> createState() {
    return _LocationInputState();
  }
}

class _LocationInputState extends State<LocationInput> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            //one to get automatically the location
            TextButton.icon(
              icon: const Icon(
                Icons.location_on,
              ),
              onPressed: () {},
              label: const Text(
                "Get Current Location",
              ),
            ),
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
