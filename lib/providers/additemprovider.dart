// ignore_for_file: file_names
import "dart:io";

import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:favorite_places/models/place.dart";
import "package:path_provider/path_provider.dart" as syspath;
import "package:path/path.dart" as path;
import "package:sqflite/sqflite.dart" as sql;
import "package:sqflite/sqlite_api.dart";

Future<Database> _getdb() async {
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

  return db;
}

class AddItemNotifier extends StateNotifier<List<Place>> {
  AddItemNotifier() : super([]);
  //initialstate

  void loadplaces() async {
    final db = await _getdb();
    final data = await db.query('user_places');

    data.map(
      (row) {
        return Place(
          id: row['id'] as String,
          title: row['title'] as String,
          image: File(row['image'] as String),
          location: PlaceLocation(
            latitude: row['lat'] as double,
            longitude: row['lng'] as double,
            address: row['address'] as String,
          ),
        );
      },
    ).toList();
  }

  void addplace(Place place) async {
    final appDir = await syspath.getApplicationDocumentsDirectory();
    final filename = path.basename(place.image.path);
    final copiedimage = await place.image.copy('${appDir.path}/$filename');
    print(copiedimage);

    final db = await _getdb();

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
