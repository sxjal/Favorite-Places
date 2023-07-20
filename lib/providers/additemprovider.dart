// ignore_for_file: file_names

import "package:favorite_places/models/place.dart";

import "package:flutter_riverpod/flutter_riverpod.dart";

class AddItemNotifier extends StateNotifier<List<Place>> {
  AddItemNotifier() : super([]);
  //initialstate

  void addplace(Place place) {
    state = [...state, place];
  }

  void initplace(List<Place> place) {
    state = place;
  }
}

final placesProvider =
    StateNotifierProvider<AddItemNotifier, List<Place>>((ref) {
  return AddItemNotifier();
});
