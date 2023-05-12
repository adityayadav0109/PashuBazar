import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:pashubazar/models/animal.dart';

class SellPage extends StatefulWidget {
  @override
  _SellPageState createState() => _SellPageState();
}

class _SellPageState extends State<SellPage> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _priceController = TextEditingController();
  final _descriptionController = TextEditingController();
  File? _image;
  String? _selectedState;
  List<String> _stateNames = [    'Andhra Pradesh',    'Arunachal Pradesh',    'Assam',    'Bihar',    'Chhattisgarh',    'Goa',    'Gujarat',    'Haryana',    'Himachal Pradesh',    'Jharkhand',    'Karnataka',    'Kerala',    'Madhya Pradesh',    'Maharashtra',    'Manipur',    'Meghalaya',    'Mizoram',    'Nagaland',    'Odisha',    'Punjab',    'Rajasthan',    'Sikkim',    'Tamil Nadu',    'Telangana',    'Tripura',    'Uttar Pradesh',    'Uttarakhand',    'West Bengal'  ];

  void _pickImage(ImageSource source) async {
    final pickedFile = await ImagePicker().pickImage(source: source);
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  void _post() async {
    if (_formKey.currentState!.validate() && _selectedState != null) {
      final animal = Animal(
        name: _nameController.text.trim(),
        price: int.parse(_priceController.text.trim()),
        description: _descriptionController.text.trim(),
        state: _selectedState!,
        image: _image?.readAsBytesSync()?.toList(),
      );

      final prefs = await SharedPreferences.getInstance();
      final animalsJson = prefs.getString('animals') ?? '[]';
      final List<dynamic> animalsData = json.decode(animalsJson);
      final List<Animal> animals =
      animalsData.map((data) => Animal.fromJson(data)).toList();
      animals.add(animal);
      final updatedAnimalsJson =
      json.encode(animals.map((animal) => animal.toJson()).toList());
      await prefs.setString('animals', updatedAnimalsJson);

      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Posted!'),
        duration: Duration(seconds: 2),
      ));

      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Sell Animal'),
        ),
        body: SingleChildScrollView(
        child: Padding(
        padding: const EdgeInsets.all(16),
    child: Form(
    key: _formKey,
    child: Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: [
    if (_image != null)
    Image.memory(
    _image!.readAsBytesSync(),
    fit: BoxFit.cover,
    height: 200,
    ),
    ElevatedButton(
    onPressed: () => _pickImage(ImageSource.gallery),
    child: Text('Pick Image'),
    ),
    TextFormField(
    controller: _nameController,
    decoration: InputDecoration(labelText: 'Name'),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter a name';
        }
        return null;
      },
    ),
      SizedBox(height: 16),
      TextFormField(
        controller: _priceController,
        decoration: InputDecoration(labelText: 'Price'),
        keyboardType: TextInputType.number,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter a price';
          }
          if (int.tryParse(value) == null) {
            return 'Please enter a valid number';
          }
          return null;
        },
      ),
      SizedBox(height: 16),
      TextFormField(
        controller: _descriptionController,
        decoration: InputDecoration(labelText: 'Description'),
        maxLines: null,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter a description';
          }
          return null;
        },
      ),
      SizedBox(height: 16),
      DropdownButtonFormField<String>(
        value: _selectedState,
        decoration: InputDecoration(
          labelText: 'State',
          border: OutlineInputBorder(),
        ),
        items: _stateNames.map((stateName) {
          return DropdownMenuItem<String>(
            value: stateName,
            child: Text(stateName),
          );
        }).toList(),
        onChanged: (value) {
          setState(() {
            _selectedState = value;
          });
        },
        validator: (value) {
          if (value == null) {
            return 'Please select a state';
          }
          return null;
        },
      ),
      SizedBox(height: 16),
      ElevatedButton(
        onPressed: _post,
        child: Text('Post'),
      ),
    ],
    ),
    ),
        ),
        ),
    );
  }
}







