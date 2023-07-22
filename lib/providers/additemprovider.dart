// ignore_for_file: file_names
import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:favorite_places/models/place.dart";
import "package:path_provider/path_provider.dart" as syspath;
import "package:path/path.dart" as path;
import "package:sqflite/sqflite.dart" as sql;
import "package:sqflite/sqlite_api.dart";

class AddItemNotifier extends StateNotifier<List<Place>> {
  AddItemNotifier() : super([]);
  //initialstate

  void addplace(Place place) async {
    final appDir = await syspath.getApplicationDocumentsDirectory();
    final filename = path.basename(place.image.path);
    final copiedimage = await place.image.copy('${appDir.path}/$filename');
    print(copiedimage);

    final dbpath = await sql.getDatabasesPath();
    final db = await sql.openDatabase(
      path.join(dbpath, 'places.db'),
      onCreate: (db, version) {
        return db.execute(
          'CREATE TABLE user_places(id TEXT PRIMARY KEY, title TEXT, image TEXT, lat REAL, lng REAL, address TEXT)',
        );
      },
      version: 1,
    );

    db.insert(
      "user_places",
      {
        "id": place.id,
        "title": place.title,
        "image": place.image.path,
        "lat": place.location.latitude,
        "lng": place.location.longitude,
        "address": place.location.address,
      },
    );
    
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
