import 'dart:io';

import 'package:flutter/foundation.dart';

import '../models/place.dart';

class GreatPlaces with ChangeNotifier{
  List<Place> _places = [];

  List<Place> get places {
    return [..._places];
  }

  void addPlace(String name, File image){
    final newPlace = Place(id: DateTime.now().toString(), name: name, location: null, image: image);
    _places.add(newPlace);
    notifyListeners();
  }
}