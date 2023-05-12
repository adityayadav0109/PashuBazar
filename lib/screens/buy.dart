import 'package:flutter/material.dart';
import 'package:pashubazar/models/animal.dart';
import 'package:pashubazar/screens/animal_detail.dart';
import 'package:pashubazar/screens/sell.dart';

class BuyPage extends StatefulWidget {
  const BuyPage({Key? key}) : super(key: key);

  @override
  _BuyPageState createState() => _BuyPageState();
}

class _BuyPageState extends State<BuyPage> {
  final List<Animal> _animalList = [
    Animal(
        name: 'Holstein Friesian Cow',
        state: 'Andhra Pradesh',
        price: 1200,
        description:
        'Healthy and good milk yield, highly recommended for dairy farming.',
         imageUrl: 'https://encrypted-tbn1.gstatic.com/licensed-image?q=tbn:ANd9GcR0sbAMUjKGBTfes5pT4vQkIbvJn_LBAbHEjwYEUs0jhTciy3oMfguZmUYFVMNfrIwfzzyT9DTSFVZB91Q',),



    Animal(
        name: 'Nellore Bull',
        state: 'Andhra Pradesh',
        price: 1500,
        description:
        'One of the best breeds for meat production, highly recommended for beef production.',
        imageUrl: 'https://diligentias.com/wp-content/uploads/2019/05/ongoel_bull.jpg',),
    Animal(
        name: 'Murrah Buffalo',
        state: 'Haryana',
        price: 2200,
        description:
        'Healthy and good milk yield, highly recommended for dairy farming.',
        imageUrl: 'https://encrypted-tbn2.gstatic.com/licensed-image?q=tbn:ANd9GcSFshILfHTKgo7xaAOMzEjQKWZGwZeTOAM-z9zXf7nsMPOPiPloMbwFoN3c5uZDyph1hiFyjuwQPPtmj8w',),
    Animal(
        name: 'Gir Cow',
        state: 'Gujarat',
        price: 1700,
        description:
        'Healthy and good milk yield, highly recommended for dairy farming.',
          imageUrl: 'https://encrypted-tbn3.gstatic.com/licensed-image?q=tbn:ANd9GcQIeDGmAMfnvj14SFputrVh914xOhNvoKIeb-MjPCw4TGlzQLtNsNoLcNDpmBuaiSXstyh80LKlw0z1R0k',),
    Animal(
        name: 'Osmanabadi Goat',
        state: 'Maharashtra',
        price: 500,
        description:
        'Good for meat and milk, highly recommended for small scale farming.',
        imageUrl: 'https://www.goatfarming.in/wp-content/uploads/2016/04/Osmanabadi-Goat-Male.jpg',),
    Animal(
        name: 'Kangayam Cow',
        state: 'Tamil Nadu',
        price: 2000,
        description:
        'Healthy and good milk yield, highly recommended for dairy farming.',
        imageUrl: 'https://encrypted-tbn1.gstatic.com/licensed-image?q=tbn:ANd9GcSwjsFlY_gQdsUQbnbGUBfSZHcnfgdegVA2vR3a7Y91z24QtJzfee--e_MEnj_tgwdd7DYX89yBxxQnFbI',),
    Animal(
        name: 'Murciana Goat',
        state: 'Uttar Pradesh',
        price: 800,
        description:
        'Good for meat and milk, highly recommended for small scale farming.',
        imageUrl: 'https://encrypted-tbn3.gstatic.com/licensed-image?q=tbn:ANd9GcSvzuQrQnEZ8v7Aco8TM70vZ4zvyqwXtA-PGc0NAfJHmJbYe6oRl-oHQDPz1nzlyD5xnyYFW69uwUlq2T0',),
    Animal(
        name: 'Kundhi Buffalo',
        state: 'Odisha',
        price: 2500,
        description:
        'Healthy and good milk yield, highly recommended for dairy farming.',
        imageUrl: 'https://i.ytimg.com/vi/_LdwZ4D_rzY/maxresdefault.jpg',),
    Animal(
        name: 'Kankrej Cow',
        state: 'Rajasthan',
        price: 1800,
        description:
        'Healthy and good milk yield, highly recommended for dairy farming.',
        imageUrl: 'https://cpimg.tistatic.com/05213154/b/4/Kankrej-Cow.jpg',),
    Animal(
        name: 'Jersey Cow',
        state: 'Uttar Pradesh',
        price: 10000,
        description:
        'Known for its ability to mimic human speech, highly recommended for pet lovers.',
        imageUrl: "https://cpimg.tistatic.com/05847268/b/4/Desi-Jersey-Cow.jpg",),
  ];

  String _selectedState = 'All';

  void _onAddNewAnimal() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => SellPage()),
    ).then((result) {
      if (result != null) {
        print(result);
        setState(() {
          _animalList.add(result);
        });
      }
    });
  }

  void _onAnimalTap(Animal animal) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => AnimalDetailPage(animal: animal)),
    );
  }

  List<String> _getStates() {
    final states = _animalList.map((animal) => animal.state).toSet().toList();
    states.sort();
    return ['All'] + states;
  }

  List<Animal> _getFilteredAnimalList() {
    if (_selectedState == 'All') {
      return _animalList;
    }
    return _animalList.where((animal)=> animal.state == _selectedState).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Buy'),
        actions: [
          IconButton(
            onPressed: _onAddNewAnimal,
            icon: Icon(Icons.add),
          )
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: DropdownButtonFormField(
              value: _selectedState,
              items: _getStates()
                  .map((state) => DropdownMenuItem(value: state, child: Text(state)))
                  .toList(),
              onChanged: (value) {
                setState(() {
                  _selectedState = value.toString();
                });
              },
              decoration: InputDecoration(
                labelText: 'Filter by State',
                border: OutlineInputBorder(),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _getFilteredAnimalList().length,
              itemBuilder: (BuildContext context, int index) {
                final animal = _getFilteredAnimalList()[index];
                return Card(
                  child: ListTile(
                    leading: Icon(Icons.pets),
                    title: Text(animal.name),
                    subtitle: Text('${animal.state} - ${animal.price} INR'),
                    onTap: () => _onAnimalTap(animal),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
