import 'package:flutter/material.dart';
import 'package:pashubazar/models/animal.dart';

class AnimalDetailPage extends StatefulWidget {
  final Animal animal;

  const AnimalDetailPage({Key? key, required this.animal}) : super(key: key);

  @override
  _AnimalDetailPageState createState() => _AnimalDetailPageState();
}

class _AnimalDetailPageState extends State<AnimalDetailPage> {
  double _selectedPrice = 0;

  @override
  Widget build(BuildContext context) {
    final double _itemHeight = MediaQuery.of(context).size.height * 0.06;
    final double _itemWidth = MediaQuery.of(context).size.width * 0.8;

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.animal.name),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 300,
              child: Image.network(
                widget.animal.imageUrl ??
                    'https://www.cabq.gov/pets/news/before-you-surrender-your-pet/@@images/91c70fd1-adb1-44f8-9f58-8e16bcf64fdc.jpeg',
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Price: ₹${widget.animal.price}',
                    style: TextStyle(fontSize: 20),
                  ),
                  SizedBox(height: 16),
                  Text(
                    widget.animal.description,
                    style: TextStyle(fontSize: 16),
                  ),
                  SizedBox(height: 16),
                  Text(
                    'Select price to offer',
                    style: TextStyle(fontSize: 20),
                  ),
                  SizedBox(height: 16),
                  Slider(
                    value: _selectedPrice,
                    min: 0,
                    max: widget.animal.price.toDouble(),
                    divisions: 40,
                    label: '₹${_selectedPrice.toStringAsFixed(2)}',
                    onChanged: (value) {
                      setState(() {
                        _selectedPrice = value;
                      });
                    },
                  ),
                  SizedBox(height: 32),
                  Center(
                    child: ElevatedButton(
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: Text('Offer made'),
                              content: Text(
                                  'Your offer of ₹ ${_selectedPrice.toStringAsFixed(2)} has been made.'),
                              actions: <Widget>[
                                TextButton(
                                  child: Text('OK'),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                ),
                              ],
                            );
                          },
                        );
                      },
                      child: Text('Make offer'),
                    ),
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
