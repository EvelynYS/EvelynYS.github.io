import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:my_app/components/my_button.dart';
import 'package:my_app/models/factory.dart';
import 'package:my_app/models/product.dart';
import 'package:provider/provider.dart';

class ProductPage extends StatefulWidget {
  final Product product;
  final Map<Addon, bool> selectAddons = {};

  ProductPage({
    super.key,
    required this.product,
  }) {
    for (Addon addon in product.availableAddons) {
      selectAddons[addon] = false;
    }
  }
  @override
  State<ProductPage> createState() => _ProductPage();
}

class _ProductPage extends State<ProductPage> {
//method of addToCart
  void addToCart(Product product, Map<Addon, bool> selectAddons) {
//close the current food page back to menu
    Navigator.pop(context);
    //format the selected addons
    List<Addon> currentSelectAddons = [];
    for (Addon addon in widget.product.availableAddons) {
      if (widget.selectAddons[addon] == true) {
        currentSelectAddons.add(addon);
      }
    }
//add to cart
    context.read<Factory>().addToCart(product, currentSelectAddons);
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
//
        Scaffold(
          body: SingleChildScrollView(
            child: Column(
              children: [
                //Product image
                Image.asset(widget.product.imagePath,
                    height: 280, width: 450, fit: BoxFit.cover),
                Padding(
                  padding: const EdgeInsets.all(25.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      //Product name
                      Text(widget.product.name,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          )),

                      //product price
                      Text(
                        'TWD\$${widget.product.price.round()}',
                        style: TextStyle(
                          fontSize: 16,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                      ),

                      const SizedBox(height: 10),

                      //Product description
                      Text(widget.product.description),

                      const SizedBox(height: 10),
                      Divider(color: Theme.of(context).colorScheme.secondary),
                      //addons
                      const SizedBox(height: 10),

                      Text(
                        "Add-ons",
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.inversePrimary,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 10),

                      Container(
                        decoration: BoxDecoration(
                            border: Border.all(
                                color: Theme.of(context).colorScheme.secondary),
                            borderRadius: BorderRadius.circular(8)),
                        child: ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          padding: EdgeInsets.zero,
                          itemCount: widget.product.availableAddons.length,
                          itemBuilder: (context, index) {
                            Addon addon = widget.product.availableAddons[index];

                            return CheckboxListTile(
                                title: Text(addon.name),
                                subtitle: Text(
                                  'TWD\$${addon.price.round()}',
                                  style: TextStyle(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .primary),
                                ),
                                value: widget.selectAddons[addon],
                                onChanged: (bool? value) {
                                  setState(() {
                                    widget.selectAddons[addon] = value!;
                                  });
                                });
                          },
                        ),
                      )
                    ],
                  ),
                ),
                MyButton(
                  text: "Add to cart",
                  onTap: () => addToCart(widget.product, widget.selectAddons),
                ),
                const SizedBox(height: 25),
              ],
            ),
          ),
        ),
//back button
        SafeArea(
          child: Opacity(
            opacity: 0.9,
            child: Container(
                margin: const EdgeInsets.only(left: 15),
                decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.secondary,
                    shape: BoxShape.circle),
                child: IconButton(
                  icon: Icon(Icons.arrow_back_ios_rounded),
                  onPressed: () => Navigator.pop(context),
                )),
          ),
        ),
      ],
    );
  }
}
