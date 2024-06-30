class Product {
  final String name;
  final String description;
  final String imagePath;
  final double price;
  final ProductCategory category;
  List<Addon> availableAddons;

  Product({
    required this.name,
    required this.description,
    required this.imagePath,
    required this.price,
    required this.category,
    required this.availableAddons,
  });
}

//product categories
enum ProductCategory {
  Bakery,
  Beverages,
  Salad,
  Snacks,
  Sweets,
}

class Addon {
  String name;
  double price;

  Addon({
    required this.name,
    required this.price,
  });
}
