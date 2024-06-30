import 'package:my_app/models/product.dart';

class CartItem {
  Product product;
  List<Addon> selectAddons;
  int quantity;

  CartItem(
      {required this.product, required this.selectAddons, this.quantity = 1});

  double get totalPrice {
    double addonsPrice =
        selectAddons.fold(0, (sum, addon) => sum + addon.price);
    return (product.price + addonsPrice) * quantity;
  }
}
