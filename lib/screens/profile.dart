import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfilePage extends StatefulWidget {
  final SharedPreferences preferences;

  const ProfilePage({required this.preferences});

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  late String _userName;
  late String _email;
  late String _contact;
  File? _profileImage;

  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _contactController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  void _loadUserData() {
    setState(() {
      _userName = widget.preferences.getString('name') ?? '';
      _email = widget.preferences.getString('email') ?? '';
      _contact = widget.preferences.getString('contact') ?? '';
    });
  }

  void _updateUserData() async {
    await widget.preferences.setString('name', _nameController.text);
    await widget.preferences.setString('email', _emailController.text);
    await widget.preferences.setString('contact', _contactController.text);
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text('Profile updated!'),
      duration: Duration(seconds: 2),
    ));
  }

  Future<void> _pickImage(ImageSource source) async {
    final pickedImage = await ImagePicker().pickImage(source: source);
    if (pickedImage != null) {
      setState(() {
        _profileImage = File(pickedImage.path);
      });
    }
  }

  Widget _buildProfileImage() {
    if (_profileImage != null) {
      return CircleAvatar(
        backgroundImage: FileImage(_profileImage!),
        radius: 50,
      );
    } else {
      return CircleAvatar(
        child: Text(
          _userName.isNotEmpty ? _userName[0].toUpperCase() : '',
          style: TextStyle(fontSize: 24),
        ),
        backgroundColor: Colors.grey[300],
        radius: 50,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
        title: Text('Profile'),
    ),
    body: Padding(
    padding: const EdgeInsets.all(16),
    child: Form(
    key: _formKey,
    child: ListView(
    children: [
    Center(
    child: GestureDetector(
    onTap: () {
    showDialog(
    context: context,
    builder: (context) => AlertDialog(
    title: Text('Choose an option'),
    actions: [
    TextButton.icon(
    onPressed: () {
    Navigator.pop(context);
    _pickImage(ImageSource.camera);
    },
    icon: Icon(Icons.camera_alt),
    label: Text('Camera'),
    ),
    TextButton.icon(
    onPressed: () {
    Navigator.pop(context);
    _pickImage(ImageSource.gallery);
    },
    icon: Icon(Icons.image),
    label: Text('Gallery'),
    ),
    ],
    ),
    );
    },
    child: _buildProfileImage(),
    ),
    ),
    SizedBox(height: 16),
    TextFormField(
    controller: _nameController..text = _userName,
    decoration: InputDecoration(
    labelText: 'Name',
    ),
    validator: (value) {
    if (value!.isEmpty) {
    return 'Name cannot be empty';
    }
    return null;
    },
    ),
    SizedBox(height: 16),
    TextFormField(
    controller: _emailController..text =_email,
      decoration: InputDecoration(
        labelText: 'Email',
      ),
      validator: (value) {
        if (value!.isEmpty) {
          return 'Email cannot be empty';
        }
        return null;
      },
    ),
      SizedBox(height: 16),
      TextFormField(
        controller: _contactController..text = _contact,
        decoration: InputDecoration(
          labelText: 'Contact',
        ),
        validator: (value) {
          if (value!.isEmpty) {
            return 'Contact cannot be empty';
          }
          return null;
        },
      ),
      SizedBox(height: 32),
      ElevatedButton(
        onPressed: () {
          if (_formKey.currentState!.validate()) {
            _updateUserData();
          }
        },
        child: Text('Update'),
      ),
    ],
    ),
    ),
    ),
    );
  }
}
