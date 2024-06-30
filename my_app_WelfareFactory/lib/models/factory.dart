import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:my_app/models/cart_item.dart';
import 'package:intl/intl.dart';

import 'product.dart';

class Factory extends ChangeNotifier {
// list of product menu
  final List<Product> _menu = [
//bakery
    Product(
      name: "Croissant",
      description:
          "A French pastry with many thin layers.It is crispy outside with soft texture inside, goes well with a espressso.",
      imagePath: "lib/images/bakery/croissant.jpg",
      price: 25,
      category: ProductCategory.Bakery,
      availableAddons: [
        Addon(name: "Chocolate", price: 10),
        Addon(name: "Raisin", price: 15),
        Addon(name: "Cinnamon powder", price: 5),
      ],
    ),
    Product(
      name: "Garlic Bread",
      description: "A Baguette slice toasted with garlic sauce.",
      imagePath: "lib/images/bakery/garlic.jpg",
      price: 20,
      category: ProductCategory.Bakery,
      availableAddons: [
        Addon(name: "Parmesan cheese", price: 15),
        Addon(name: "Spring Onion", price: 5),
        Addon(name: "Pepper", price: 2),
      ],
    ),
    Product(
      name: "Multigrain Bread",
      description: "A European Boule mixed with various grains.",
      imagePath: "lib/images/bakery/multigrain.jpg",
      price: 30,
      category: ProductCategory.Bakery,
      availableAddons: [
        Addon(name: "Bacon", price: 10),
        Addon(name: "Spring Onion", price: 5),
        Addon(name: "Egg", price: 10),
      ],
    ),
    Product(
      name: "Pizza",
      description: "A Italian homemade pizza slice.",
      imagePath: "lib/images/bakery/pizza.jpg",
      price: 20,
      category: ProductCategory.Bakery,
      availableAddons: [
        Addon(name: "Bacon", price: 10),
        Addon(name: "Mozzarella Cheese", price: 25),
        Addon(name: "Tomato", price: 10),
      ],
    ),
    Product(
      name: "Sour Dough",
      description: "A European bread mixed with sour cream.",
      imagePath: "lib/images/bakery/sourDough.jpg",
      price: 15,
      category: ProductCategory.Bakery,
      availableAddons: [
        Addon(name: "Bacon", price: 10),
        Addon(name: "Mozzarella Cheese", price: 25),
        Addon(name: "Tomato", price: 10),
      ],
    ),
//beverages
    Product(
      name: "Black Tea",
      description: "A black ceylon tea slowly marinated over times.",
      imagePath: "lib/images/beverages/blackTea.jpg",
      price: 10,
      category: ProductCategory.Beverages,
      availableAddons: [
        Addon(name: "Lemon slice", price: 5),
        Addon(name: "Cream", price: 5),
        Addon(name: "Milk", price: 10),
      ],
    ),
    Product(
      name: "Bubble Tea",
      description:
          "Bubble tea most commonly consists of tea accompanied by chewy tapioca balls (or pearls).",
      imagePath: "lib/images/beverages/bubbleTea.jpg",
      price: 25,
      category: ProductCategory.Beverages,
      availableAddons: [
        Addon(name: "Grass Jelly", price: 5),
        Addon(name: "Aloe Vera", price: 5),
        Addon(name: "Cheese", price: 10),
      ],
    ),
    Product(
      name: "Coffee",
      description: "Americano made of Honduras arabic beans.",
      imagePath: "lib/images/beverages/coffee.jpg",
      price: 25,
      category: ProductCategory.Beverages,
      availableAddons: [
        Addon(name: "Lemon slice", price: 5),
        Addon(name: "Cream", price: 5),
        Addon(name: "Milk", price: 10),
      ],
    ),
    Product(
      name: "Lemonade",
      description: "A iced tea mixed with lemon, orange juice, and peppermint.",
      imagePath: "lib/images/beverages/iceLemonade.jpg",
      price: 25,
      category: ProductCategory.Beverages,
      availableAddons: [
        Addon(name: "Lemon slice", price: 5),
        Addon(name: "Honey", price: 5),
        Addon(name: "Soda", price: 10),
      ],
    ),
    Product(
      name: "Matcha Tea",
      description: "A tea made of Japanese green tea powder.",
      imagePath: "lib/images/beverages/matchaTea.jpg",
      price: 15,
      category: ProductCategory.Beverages,
      availableAddons: [
        Addon(name: "Chocolate", price: 5),
        Addon(name: "Cream", price: 5),
        Addon(name: "Milk", price: 10),
      ],
    ),
//salad
    Product(
      name: "Caesar Salad",
      description:
          "A green salad of romaine lettuce and croutons dressed with lemon juice (or lime juice), olive oil, eggs or egg yolks, Worcestershire sauce, anchovies, garlic, Dijon mustard, Parmesan cheese, and black pepper.",
      imagePath: "lib/images/salad/caesar.jpg",
      price: 35,
      category: ProductCategory.Salad,
      availableAddons: [
        Addon(name: "Black olive", price: 15),
        Addon(name: "Pepper slice", price: 15),
        Addon(name: "Mozzarella cheese", price: 30),
      ],
    ),
    Product(
      name: "Fruit Salad",
      description: "A  salad consisting of various seasonal fruits.",
      imagePath: "lib/images/salad/fruits.jpg",
      price: 35,
      category: ProductCategory.Salad,
      availableAddons: [
        Addon(name: "Black olive", price: 15),
        Addon(name: "Tomato", price: 10),
        Addon(name: "Orange dressing", price: 10),
      ],
    ),
    Product(
      name: "Greek Salad",
      description:
          "A popular salad in Greek cuisine generally made with pieces of tomatoes, cucumbers, onion, feta cheese, olives and dressed with salt, Greek oregano, lemon juice and olive oil. ",
      imagePath: "lib/images/salad/greek.jpg",
      price: 35,
      category: ProductCategory.Salad,
      availableAddons: [
        Addon(name: "Garlic", price: 15),
        Addon(name: "Pepper slice", price: 15),
        Addon(name: "Mozzarella cheese", price: 30),
      ],
    ),
    Product(
      name: "Hipster Salad",
      description:
          "Simply Salad Mix – Romaine, grilled chicken, goat cheese, dried cherries, candied walnuts, and granny smith apples.",
      imagePath: "lib/images/salad/hipster.jpg",
      price: 35,
      category: ProductCategory.Salad,
      availableAddons: [
        Addon(name: "Garlic", price: 15),
        Addon(name: "Black olives", price: 15),
        Addon(name: "Mozzarella cheese", price: 30),
      ],
    ),
    Product(
      name: "Italian Salad",
      description:
          "A classic Italian Mixed Salad features mixed greens, tomatoes, carrots, cucumbers and shaved Parmigiano Reggiano cheese.",
      imagePath: "lib/images/salad/italian.jpg",
      price: 35,
      category: ProductCategory.Salad,
      availableAddons: [
        Addon(name: "Garlic", price: 15),
        Addon(name: "Black olives", price: 15),
        Addon(name: "Mozzarella cheese", price: 30),
      ],
    ),
//saltySnacks
    Product(
      name: "Chips",
      description: "Freshly made potato chips.",
      imagePath: "lib/images/saltySnacks/chips.jpg",
      price: 15,
      category: ProductCategory.Snacks,
      availableAddons: [
        Addon(name: "Garlic powder", price: 5),
        Addon(name: "Pepper powder", price: 5),
        Addon(name: "Ketchup", price: 5),
      ],
    ),
    Product(
      name: "Popcorns",
      description: "Popcorn with various flavors.",
      imagePath: "lib/images/saltySnacks/popcorn.jpg",
      price: 15,
      category: ProductCategory.Snacks,
      availableAddons: [
        Addon(name: "Cheese syrup", price: 5),
        Addon(name: "Mustard syrup", price: 5),
        Addon(name: "Garlic syrup", price: 5),
      ],
    ),
    Product(
      name: "Rice Cracker",
      description: "Cracker made of rice flour with various toppings.",
      imagePath: "lib/images/saltySnacks/riceCracker.jpg",
      price: 15,
      category: ProductCategory.Snacks,
      availableAddons: [
        Addon(name: "Seaweed", price: 5),
        Addon(name: "Sesame", price: 5),
        Addon(name: "Soybean", price: 5),
      ],
    ),
    Product(
      name: "Salty Mix Cracker",
      description: "Cracker with various shapes.",
      imagePath: "lib/images/saltySnacks/saltyMix.jpg",
      price: 15,
      category: ProductCategory.Snacks,
      availableAddons: [
        Addon(name: "Seaweed", price: 5),
        Addon(name: "Sesame", price: 5),
        Addon(name: "Dried garlic", price: 15),
      ],
    ),
    Product(
      name: "Sorted Nuts",
      description:
          "A bowl consisting of almonds, cashew, chestnuts, brazilian nuts.",
      imagePath: "lib/images/saltySnacks/sortedNuts.png",
      price: 15,
      category: ProductCategory.Snacks,
      availableAddons: [
        Addon(name: "Seaweed", price: 5),
        Addon(name: "Sesame", price: 5),
        Addon(name: "Garlic salt", price: 1),
      ],
    ),
//sweets
    Product(
      name: "Brownie",
      description:
          "A chocolate pastry.It is famous for the fragrance of the chocolate and syrup-like chocolate bean baked inside the pastry.",
      imagePath: "lib/images/sweets/Browie.jpg",
      price: 15,
      category: ProductCategory.Sweets,
      availableAddons: [
        Addon(name: "Cream", price: 5),
        Addon(name: "Raspberries", price: 15),
        Addon(name: "Raisin", price: 15),
      ],
    ),
    Product(
      name: "Cinnamon",
      description: "A Cinnamon Roll are common pastry made of cinnamon syrup.",
      imagePath: "lib/images/sweets/Cinnamon.jpg",
      price: 15,
      category: ProductCategory.Sweets,
      availableAddons: [
        Addon(name: "Cream", price: 5),
        Addon(name: "Raspberries", price: 15),
        Addon(name: "Raisin", price: 15),
      ],
    ),
    Product(
      name: "Macarons",
      description:
          "French macaroon is a sweet meringue-based confection made with egg white, icing sugar, granulated sugar, almond meal, and often food colouring.",
      imagePath: "lib/images/sweets/Macarons.jpg",
      price: 15,
      category: ProductCategory.Sweets,
      availableAddons: [
        Addon(name: "Cream", price: 5),
        Addon(name: "Raspberries", price: 15),
        Addon(name: "Raisin", price: 15),
      ],
    ),
    Product(
      name: "Matcha Donut",
      description: "Donut made of matcha tea powder.",
      imagePath: "lib/images/sweets/MatchaDonuts.jpg",
      price: 15,
      category: ProductCategory.Sweets,
      availableAddons: [
        Addon(name: "Cream", price: 5),
        Addon(name: "Raspberries", price: 15),
        Addon(name: "Raisin", price: 15),
      ],
    ),
    Product(
      name: "Trufas De Chocolate",
      description:
          "A chocolate truffle is a French chocolate made with a chocolate ganache centre and coated in cocoa powder, coconut, or chopped nuts.",
      imagePath: "lib/images/sweets/TrufasDeChocolate.jpg",
      price: 15,
      category: ProductCategory.Sweets,
      availableAddons: [
        Addon(name: "Cream", price: 5),
        Addon(name: "Raspberries", price: 15),
        Addon(name: "Raisin", price: 15),
      ],
    ),
  ];

//user cart
final List<CartItem> _cart = [];
//customer address
String _deliveryAddress = 'Delivery Address';
int _itemCount = 0;

//(A)GETTERS
  List<Product> get menu => _menu;
  List<CartItem> get cart => _cart;
  String get deliveryAddress => _deliveryAddress;
  int get itemCount => _itemCount;

//(B)OPERATIONS
  
//add to cart
  void addToCart(Product product, List<Addon> selectAddons) {
    CartItem? cartItem = _cart.firstWhereOrNull((item) {
      //check if the items are same
      bool isSameProduct = item.product == product;
      //check if the list of addons are the same
      bool isSameAddon = ListEquality().equals(item.selectAddons, selectAddons);

      return isSameProduct && isSameAddon;
    });
    if (cartItem != null) {
      cartItem.quantity++;
    } else {
      _cart.add(CartItem(
        product: product,
        selectAddons: selectAddons,
      ));
    }
     updateItemCount();
    notifyListeners();
  }

//remove from cart
  void removeFromCart(CartItem cartItem) {
    int cartIndex = _cart.indexOf(cartItem);
    if (cartIndex != -1) {
      if (_cart[cartIndex].quantity > 1) {
        _cart[cartIndex].quantity--;
      } else {
        _cart.removeAt(cartIndex);
      }
    }
     updateItemCount();
    notifyListeners();
  }

//get total price
  double getTotalPrice() {
    double total = 0.0;

    for (CartItem cartItem in _cart) {
      double itemTotal = cartItem.product.price;
      for (Addon addon in cartItem.selectAddons) {
        itemTotal += addon.price;
      }
      total += itemTotal * cartItem.quantity;
    }
    return total;
  }

//get total number of items
  int getTotalItemCount() {
    int totalItemCount = 0;
    for (CartItem cartItem in _cart) {
      totalItemCount += cartItem.quantity;
    }
    return totalItemCount;    
  }

  void updateItemCount() {
    int totalItemCount = 0;
    for (CartItem cartItem in _cart) {
      totalItemCount += cartItem.quantity;
    }
    _itemCount = totalItemCount;
    notifyListeners();
  }

//clear cart
  void clearCart() {
    _cart.clear();
    _itemCount= 0 ;
    notifyListeners();
  }

//Update delivery address
void updateDeliveryAddress(String newAddress){
  _deliveryAddress = newAddress;
  notifyListeners();
}


//(C)HELPERS

//generate a receipt
  String displayCartReceipt() {
    final receipt = StringBuffer();
    receipt.writeln("Here is your recceipt.");
    receipt.writeln();
    // format the date to include up to seconds only
    String formattedDate =
        DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.now());
    receipt.writeln(formattedDate);
    receipt.writeln();
    receipt.writeln("--------------");
    receipt.writeln();


    for(final cartItem in _cart){
      receipt.writeln(
        "${cartItem.quantity} x ${cartItem.product.name} - ${_formatPrice(cartItem.product.price)}");
    if (cartItem.selectAddons.isNotEmpty){
      receipt.writeln("  Add-ons: ${_formatAddons(cartItem.selectAddons)}");
    }
    receipt.writeln();
    }

    receipt.writeln("-----------");
    receipt.writeln();
    receipt.writeln("Total Items: ${getTotalItemCount()}");
    receipt.writeln("Total Price: ${_formatPrice(getTotalPrice())}");
    receipt.writeln();
    receipt.writeln("-----------");
    receipt.writeln();
    receipt.writeln("Delivery Address: ${deliveryAddress}");
    
    return receipt.toString();

  }

//format double vlaue into money
  String _formatPrice(double price) {
    return "TWD\$${price.toStringAsFixed(1)}";
  }

//format list of addons into  string summary
  String _formatAddons(List<Addon> addons) {
    return addons
        .map((addon) => "${addon.name} (${_formatPrice(addon.price)})")
        .join(', ');
  }
}
