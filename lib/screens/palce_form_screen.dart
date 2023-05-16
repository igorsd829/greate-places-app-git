import 'dart:io';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:greatplaces/providers/great_places.dart';
import 'package:greatplaces/widgets/image_input.dart';
import 'package:provider/provider.dart';

import '../widgets/location_input.dart';

class PlaceFormScreen extends StatefulWidget {
  const PlaceFormScreen({super.key});

  @override
  State<PlaceFormScreen> createState() => _PlaceFormScreenState();
}

class _PlaceFormScreenState extends State<PlaceFormScreen> {
  final TextEditingController _titleController = TextEditingController();
  File? _pickedImage;
  LatLng? _pickedPosition;

  void _selectImage(File pickedImage) {
    setState(() {
      _pickedImage = pickedImage;
    });
  }

  void _selectPosition(LatLng position) {
    setState(() {
      _pickedPosition = position;
    });
  }

  bool _isValidForm() {
    return _titleController.text.isNotEmpty ||
        _pickedImage != null ||
        _pickedPosition != null;
  }

  void _submitForm() {
    if (!_isValidForm()) {
      return;
    }
    Provider.of<GreatPlaces>(context, listen: false)
        .addPlace(_titleController.text, _pickedImage!, _pickedPosition!);
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('Novo Lugar')),
        body: Column(
          children: [
            Expanded(
                child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  children: [
                    TextField(
                      controller: _titleController,
                      decoration: const InputDecoration(
                        labelText: 'Título',
                      ),
                      onChanged: (text) {
                        setState(() {});
                      },
                    ),
                    // TextField(
                    //   controller: _titleController,
                    //   decoration: const InputDecoration(label: Text('Título')),
                    // ),
                    const SizedBox(height: 10),
                    ImageInput(_selectImage),
                    const SizedBox(height: 10),
                    LocationInput(this._selectPosition),
                  ],
                ),
              ),
            )),
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                TextButton.icon(
                  style: ButtonStyle(
                      elevation: MaterialStateProperty.all(0),
                      tapTargetSize:
                          MaterialTapTargetSize.shrinkWrap, // usar no bolt
                      backgroundColor: _isValidForm()
                          ? MaterialStateProperty.all(Colors.amber)
                          : MaterialStateProperty.all(Colors.grey)),
                  icon: const Icon(Icons.add),
                  onPressed: _isValidForm() ? _submitForm : null,
                  label: const Text('Adicionar'),
                ),
              ],
            ),
          ],
        ));
  }
}
