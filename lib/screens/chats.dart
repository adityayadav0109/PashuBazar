import 'package:flutter/material.dart';
import 'animal_detail.dart';
import 'offerchat.dart';

class ChatsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chats'),
      ),
      body: ListView.builder(
        itemCount: dummyChats.length,
        itemBuilder: (BuildContext context, int index) {
          final chat = dummyChats[index];
          return ListTile(
            leading: CircleAvatar(
              backgroundImage: AssetImage(chat.animal.imageUrl),
            ),
            title: Text(chat.name),
            subtitle: Text(chat.lastMessage),
            trailing: Text(chat.time),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AnimalChatPage(
                    selectedPrice: chat.selectedPrice,
                    initialMessage: chat.initialMessage,
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

class AnimalChatPage extends StatefulWidget {
  final double selectedPrice;
  final String initialMessage;

  const AnimalChatPage({
    Key? key,
    required this.selectedPrice,
    required this.initialMessage,
  }) : super(key: key);

  @override
  _AnimalChatPageState createState() => _AnimalChatPageState();
}

class _AnimalChatPageState extends State<AnimalChatPage> {
  TextEditingController _messageController = TextEditingController();
  List<String> _messages = [];

  @override
  void initState() {
    super.initState();
    _messages.add(widget.initialMessage);
  }

  void _sendMessage() {
    if (_messageController.text.isNotEmpty) {
      setState(() {
        _messages.add(_messageController.text);
        _messageController.clear();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chat Page'),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              reverse: true,
              itemCount: _messages.length,
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  title: Container(
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    padding: EdgeInsets.all(10.0),
                    child: Text(
                      _messages[index],
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  tileColor: Colors.transparent,
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _messageController,
                    decoration: InputDecoration(
                      hintText: 'Type your message...',
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.send),
                  onPressed: _sendMessage,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class Chat {
  final String name;
  final String lastMessage;
  final String time;
  final Animal animal;
  final double selectedPrice;
  final String initialMessage;

  Chat({
  required this.name,
    required this.lastMessage,
    required this.time,
    required this.animal,
    required this.selectedPrice,
    required this.initialMessage,
  });
}

List<Chat> dummyChats = [
  Chat(
    name: 'John Doe',
    lastMessage: 'Hi, I am interested in your animal. Can we negotiate the price?',
    time: '10:30 AM',
    animal: Animal(
      name: 'Dog',
      price: 5000,
      description: 'Friendly and playful dog.',
      imageUrl: 'https://unsplash.com/photos/8g0D8ZfFXyA',
    ),
    selectedPrice: 5000,
    initialMessage: 'Hi, I am interested in your animal. Can we negotiate the price?',
  ),
  Chat(
    name: 'Jane Smith',
    lastMessage: 'Do you have any more pictures of the cat?',
    time: '11:45 AM',
    animal: Animal(
      name: 'Cat',
      price: 3000,
      description: 'Adorable and independent cat.',
      imageUrl: 'https://example.com/cat.jpg',
    ),
    selectedPrice: 3000,
    initialMessage: 'Do you have any more pictures of the cat?',
  ),
  Chat(
    name: 'Michael Johnson',
    lastMessage: 'Can I come and see the rabbit in person?',
    time: '2:15 PM',
    animal: Animal(
      name: 'Rabbit',
      price: 2000,
      description: 'Cute and fluffy rabbit.',
      imageUrl: 'https://www.cabq.gov/pets/news/before-you-surrender-your-pet/@@images/91c70fd1-adb1-44f8-9f58-8e16bcf64fdc.jpeg',
    ),
    selectedPrice: 2000,
    initialMessage: 'Can I come and see the rabbit in person?',
  ),
  Chat(
    name: 'Emily Davis',
    lastMessage: 'What type of food does the bird prefer?',
    time: '4:30 PM',
    animal: Animal(
      name: 'Bird',
      price: 1500,
      description: 'Beautiful and chirpy bird.',
      imageUrl: 'https://example.com/bird.jpg',
    ),
    selectedPrice: 1500,
    initialMessage: 'What type of food does the bird prefer?',
  ),
];


class Animal {
  final String name;
  final double price;
  final String description;
  final String imageUrl;

  Animal({
    required this.name,
    required this.price,
    required this.description,
    required this.imageUrl,
  });
}
