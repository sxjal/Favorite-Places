// ignore_for_file: file_names

import "package:favorite_places/models/place.dart";

import "package:flutter_riverpod/flutter_riverpod.dart";

class AddItemProvider extends StateNotifier<List<Place>> {
  AddItemProvider() : super([]);

  void setplace(Place place) {
    state = [...state, place];
  }

  void initplace(List<Place> place) {
    state = place;
  }
}

final itemsProvider =
    StateNotifierProvider<AddItemProvider, List<Place>>((ref) {
  return AddItemProvider();
});
