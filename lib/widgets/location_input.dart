import 'package:flutter/material.dart';
import 'package:location/location.dart';

class LocationInput extends StatefulWidget {
  const LocationInput({Key? key}) : super(key: key);

  @override
  _LocationInputState createState() => _LocationInputState();
}

class _LocationInputState extends State<LocationInput> {
  String? _previewImageUrl = null;

  Future<void> _getCurrentUserLocation() async{
    final locData = await Location().getLocation();
    print(locData.latitude);
    print(locData.longitude);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
            height: 170,
            width: double.infinity,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              border: Border.all(width: 1, color: Colors.grey)
            ),
            child: _previewImageUrl == null
                ? Text(
                    "No location chosen",
                    textAlign: TextAlign.center,
                  )
                : Image.network(
                    _previewImageUrl!,
                    fit: BoxFit.cover,
                    width: double.infinity,
                  )),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextButton.icon(
                onPressed: _getCurrentUserLocation,
                icon: Icon(Icons.location_on),
                style: TextButton.styleFrom(textStyle: TextStyle(color: Theme.of(context).primaryColor)),
                label: Text("Current location")),
            TextButton.icon(
                onPressed: () {},
                icon: Icon(Icons.map),
                style: TextButton.styleFrom(textStyle: TextStyle(color: Theme.of(context).primaryColor)),
                label: Text("Select on map"))
          ],
        )
      ],
    );
  }
}
