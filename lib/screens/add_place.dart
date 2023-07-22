import "package:favorite_places/widgets/imageinput.dart";
import "package:favorite_places/widgets/locationinputwidget.dart";
import 'package:flutter/material.dart';
import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:favorite_places/providers/additemProvider.dart";
import "dart:io";
import "package:favorite_places/models/place.dart";

class AddPlacesScreen extends ConsumerStatefulWidget {
  const AddPlacesScreen({super.key});

  @override
  ConsumerState<AddPlacesScreen> createState() => _AddPlacesScreenState();
}

class _AddPlacesScreenState extends ConsumerState<AddPlacesScreen> {
  File? selectedimage;
  PlaceLocation? selectedlocation;
  var text = '';
  final _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _saveplace() {
    if (_controller.text.isEmpty ||
        selectedimage == null ||
        selectedlocation == null) {
      return;
    }

    ref.read(placesProvider.notifier).addplace(
          Place(
              title: _controller.text,
              image: selectedimage!,
              location: selectedlocation!),
        );
    //read meaning giving data to provider

    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    //ref.watch();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add New Place'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Form(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Title',
                  fillColor: Colors.white,
                ),
                controller: _controller,
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onBackground,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              ImageInput(onimageadd: (addedimage) {
                selectedimage = addedimage;
              }),
              const SizedBox(
                height: 20,
              ),
              LocationInput(
                onselectlocation: (location) {
                  selectedlocation = location;
                },
              ),
              const SizedBox(
                height: 20,
              ),
              ElevatedButton.icon(
                onPressed: _saveplace,
                icon: const Icon(
                  Icons.add,
                ),
                label: const Text('Add Place'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
