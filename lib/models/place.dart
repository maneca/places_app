import 'dart:io';
import './place_location.dart';

class Place{
  final String id;
  final String name;
  final PlaceLocation location;
  final File image;

  Place({
    required this.id,
    required this.name,
    required this.location,
    required this.image
  });
}