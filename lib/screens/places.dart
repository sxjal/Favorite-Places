import 'package:favorite_places/screens/add_place.dart';
import 'package:favorite_places/widgets/places_list.dart';
import 'package:flutter/material.dart';
import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:favorite_places/providers/additemProvider.dart";

class PlacesScreen extends ConsumerStatefulWidget {
  const PlacesScreen({super.key});

  ConsumerState<PlacesScreen> createState() => _PlacesScreenState();
}

class _PlacesScreenState extends ConsumerState<PlacesScreen> {
  late Future<void> _placesfuture;

  @override
  void initState() {
    super.initState();
    _placesfuture = ref.read(placesProvider.notifier).loadplaces();
  }

  void addItem(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const AddPlacesScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final addedplaces = ref.watch(placesProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Places'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              addItem(context);
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: FutureBuilder(
          future: _placesfuture,
          builder: (context, snapshot) =>
              snapshot.connectionState == ConnectionState.waiting
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : PlacesList(
                      places: addedplaces,
                    ),
        ),
      ),
    );
  }
}
