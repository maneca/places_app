import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../screens/add_place_screen.dart';
import '../providers/great_places.dart';

class PlacesListScreen extends StatelessWidget {
  const PlacesListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Your places"),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.of(context).pushNamed(AddPlaceScreen.routeName);
              },
              icon: Icon(Icons.add))
        ],
      ),
      body: FutureBuilder(
        future: Provider.of<GreatPlaces>(context, listen: false)
            .fetchAndSetPlaces(),
        builder: (builder, snapshot) => snapshot.connectionState ==
                ConnectionState.waiting
            ? Center(child: CircularProgressIndicator())
            : snapshot.hasError
                ? Center(
                    child: Text(snapshot.error.toString()),
                  )
                : Consumer<GreatPlaces>(
                    child: Center(
                      child: Text("There are no places added"),
                    ),
                    builder: (ctx, greatPlaces, ch) =>
                        greatPlaces.places.length == 0
                            ? ch!
                            : ListView.builder(
                                itemCount: greatPlaces.places.length,
                                itemBuilder: (ctx, i) => ListTile(
                                      leading: CircleAvatar(
                                        backgroundImage: FileImage(
                                            greatPlaces.places[i].image),
                                      ),
                                      title: Text(greatPlaces.places[i].name),
                                      onTap: () {},
                                    )),
                  ),
      ),
    );
  }
}
