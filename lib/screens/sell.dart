import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:pashubazar/models/animal.dart';
import 'package:http/http.dart' as http;

class SellPage extends StatefulWidget {
  @override
  _SellPageState createState() => _SellPageState();
}

class _SellPageState extends State<SellPage> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _priceController = TextEditingController();
  final _descriptionController = TextEditingController();
  String? _imageUrl;
  String? _selectedState;
  List<String> _stateNames = [
    'Andhra Pradesh',
    'Arunachal Pradesh',
    'Assam',
    'Bihar',
    'Chhattisgarh',
    'Goa',
    'Gujarat',
    'Haryana',
    'Himachal Pradesh',
    'Jharkhand',
    'Karnataka',
    'Kerala',
    'Madhya Pradesh',
    'Maharashtra',
    'Manipur',
    'Meghalaya',
    'Mizoram',
    'Nagaland',
    'Odisha',
    'Punjab',
    'Rajasthan',
    'Sikkim',
    'Tamil Nadu',
    'Telangana',
    'Tripura',
    'Uttar Pradesh',
    'Uttarakhand',
    'West Bengal'
  ];

  void _pickImage(ImageSource source) async {
    final pickedFile = await ImagePicker().pickImage(source: source);
    if (pickedFile != null) {
      final response = await http.post(
        Uri.parse('https://api.imgbb.com/1/upload'),
        body: {
          'key': 'YOUR_API_KEY',
          'image': base64Encode(File(pickedFile.path).readAsBytesSync())
        },
      );
      final data = json.decode(response.body);
      if (data['status_code'] == 200) {
        setState(() {
          _imageUrl = data['data']['url'];
        });
      }
    }
  }

  void _post() async {
    if (_formKey.currentState!.validate() && _selectedState != null) {
      final animal = Animal(
        name: _nameController.text.trim(),
        price: int.parse(_priceController.text.trim()),
        description: _descriptionController.text.trim(),
        state: _selectedState!,
        imageUrl: _imageUrl,
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
           TextFormField(
      controller: _nameController,
      decoration: InputDecoration(
        labelText: 'Animal Name',
      ),
      validator: (value) {
        if (value!.isEmpty) {
          return 'Please enter a name';
        }
        return null;
      },
    ),
    SizedBox(height: 16),
      TextFormField(
        controller: _priceController,
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
          labelText: 'Price',
        ),
        validator: (value) {
          if (value!.isEmpty) {
            return 'Please enter a price';
          }
          if (int.tryParse(value) == null) {
            return 'Please enter a valid price';
          }
          return null;
        },
      ),
      SizedBox(height: 16),
      TextFormField(
        controller: _descriptionController,
        maxLines: 3,
        decoration: InputDecoration(
          labelText: 'Description',
        ),
        validator: (value) {
          if (value!.isEmpty) {
            return 'Please enter a description';
          }
          return null;
        },
      ),
      SizedBox(height: 16),
      DropdownButtonFormField(
        value: _selectedState,
        decoration: InputDecoration(
          labelText: 'State',
        ),
        items: _stateNames
            .map((stateName) => DropdownMenuItem(
          value: stateName,
          child: Text(stateName),
        ))
            .toList(),
        onChanged: (value) {
          setState(() {
            _selectedState = value as String?;
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
      if (_imageUrl != null)
        SizedBox(
          height: 200,
          child: Image.network(_imageUrl!),
        ),
      ElevatedButton(
        onPressed: () => _pickImage(ImageSource.gallery),
        child: Text('Pick Image'),
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
