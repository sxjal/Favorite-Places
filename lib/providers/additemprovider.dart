// ignore_for_file: file_names

import "package:favorite_places/models/place.dart";
import "package:path_provider/path_provider.dart" as syspath;
import "package:path/path.dart" as path;
import "package:flutter_riverpod/flutter_riverpod.dart";

class AddItemNotifier extends StateNotifier<List<Place>> {
  AddItemNotifier() : super([]);
  //initialstate

  void addplace(Place place) async {
    final appDir = await syspath.getApplicationDocumentsDirectory();
    final filename = path.basename(place.image.path);
    final copiedimage = await place.image.copy('${appDir.path}/$filename');
    print(copiedimage);
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
