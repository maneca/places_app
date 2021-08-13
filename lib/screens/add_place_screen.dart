import 'dart:io';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/great_places.dart';
import '../widgets/image_input.dart';

class AddPlaceScreen extends StatefulWidget {
  const AddPlaceScreen({Key? key}) : super(key: key);
  static const routeName = "/add-place";

  @override
  _AddPlaceScreenState createState() => _AddPlaceScreenState();
}

class _AddPlaceScreenState extends State<AddPlaceScreen> {
  final _form = GlobalKey<FormState>();
  var _isLoading = false;
  var _placeName = "";
  File? _pickedImage;

  void _selectImage(File pickedImage){
    _pickedImage = pickedImage;
  }

  void _saveForm(){
    if(_form.currentState!.validate() || _pickedImage != null){
      setState(() {
        _isLoading = true;
      });

      _form.currentState!.save();

      Provider.of<GreatPlaces>(context, listen: false).addPlace(_placeName, _pickedImage!);

      setState(() {
        _isLoading = false;
      });
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add a new place")
      ),
      body: _isLoading
      ? Center(child: CircularProgressIndicator(),)
      : Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: Form(
              key: _form,
              child: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Column(
                    children: [
                       TextFormField(
                         initialValue: _placeName,
                         decoration: InputDecoration(labelText: "Name"),
                         validator: (value){
                           if(value!.isEmpty){
                             return "Please insert a name";
                           }

                           return null;
                         },
                         onSaved: (value){
                           _placeName = value!;
                         },
                       ),
                      SizedBox(height: 10,),
                      ImageInput(_selectImage)
                    ],
                  ),
                ),
              ),
            ),
          ),
          ElevatedButton.icon(
            onPressed: _saveForm,
            icon: Icon(Icons.add),
            label: Text("Add place"),
            style: ElevatedButton.styleFrom(
              fixedSize: Size(double.infinity, 50.0),
                primary: Theme.of(context).accentColor),
          )
        ],
      ),
    );
  }
}
