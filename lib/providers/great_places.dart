import 'dart:io';
import 'package:flutter/foundation.dart';

import '../helpers/db_helper.dart';
import '../models/place.dart';

class GreatPlaces with ChangeNotifier{
  List<Place> _places = [];

  List<Place> get places {
    return [..._places];
  }

  void addPlace(String name, File image) async{
    final newPlace = Place(id: DateTime.now().toString(), name: name, location: null, image: image);
    _places.add(newPlace);
    notifyListeners();
    await DBHelper.insertPlace({
      "id": newPlace.id,
      "name": newPlace.name,
      "image": newPlace.image.path
    });
  }

  Future<void> fetchAndSetPlaces() async{
    try{
      final dataList = await DBHelper.getPlaces();
      _places = dataList.map((item) => Place(
          id: item["id"],
          name: item["name"],
          image: File(item["image"]),
          location: null
      )).toList();
      notifyListeners();
    }catch(error){
      throw error.toString();
    }
  }
}