import 'package:flutter/material.dart';
import 'package:pashubazar/models/animal.dart';

class AnimalDetailPage extends StatelessWidget {
  final Animal animal;

  const AnimalDetailPage({Key? key, required this.animal}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(animal.name),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 300,
              child: Image.network(
                animal.imageUrl ??"https://www.cabq.gov/pets/news/before-you-surrender-your-pet/@@images/91c70fd1-adb1-44f8-9f58-8e16bcf64fdc.jpeg",
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Price: ${animal.price}',
                    style: TextStyle(fontSize: 20),
                  ),
                  SizedBox(height: 16),
                  Text(
                    animal.description,
                    style: TextStyle(fontSize: 16),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
