class Product {
  String? id;
  String? name;
  String? description;
  double? price;
  int? stock;
  String? color;

  Product({
    required this.id,
    required this.description,
    required this.price,
    required this.color,
    required this.stock,
    required this.name,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      name: json['name'],
      description: json["details"]['description'],
      price: double.tryParse(json["details"]['price']),
      stock: json['stock'],
      color: json["details"]['color'],
    );
  }
}
