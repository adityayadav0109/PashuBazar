class Animal {
  final String name;
  final int price;
  final String description;
  final String? imageUrl;
  final String state;

  Animal({
    required this.name,
    required this.price,
    required this.description,
    required this.imageUrl,
    required this.state,
  });

  factory Animal.fromJson(Map<String, dynamic> json) {
    return Animal(
      name: json['name'],
      price: json['price'],
      description: json['description'],
      imageUrl: json['imageUrl'],
      state: json['state'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'price': price,
      'description': description,
      'imageUrl': imageUrl,
      'state': state,
    };
  }
}
