class Product {
  final String id;
  final String name;
  final double price;
  final int stock;
  final String description;
  final String category;
  final String? imagePath; // make it nullable

  Product({
    required this.id,
    required this.name,
    required this.price,
    required this.stock,
    required this.description,
    required this.category,
    this.imagePath, // nullable
  });
}
