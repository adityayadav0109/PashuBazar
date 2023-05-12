class Animal {
  final String name;
  final int price;
  final String description;
  final List<int>? image;
  final String state;

  Animal({
    required this.name,
    required this.price,
    required this.description,
    this.image,
    required this.state,
  });

  factory Animal.fromJson(Map<String, dynamic> json) {
    return Animal(
      name: json['name'],
      price: json['price'],
      description: json['description'],
      image: json['image'] != null ? List<int>.from(json['image']) : null,
      state: json['state'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'price': price,
      'description': description,
      'image': image,
      'state': state,
    };
  }
}
