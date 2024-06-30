import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:my_app/components/my_quantity_selector.dart';
import 'package:my_app/models/cart_item.dart';
import 'package:my_app/models/factory.dart' as MyAppFactory;

import 'package:provider/provider.dart';

class MyCartTile extends StatelessWidget {
  final CartItem cartItem;
  const MyCartTile({super.key, required this.cartItem});

  @override
  Widget build(BuildContext context) {
    return Consumer<MyAppFactory.Factory>(
        builder: (context, factory, child) => Container(
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.secondary,
              borderRadius: BorderRadius.circular(8),
            ),
            margin: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      //food image
                      ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.asset(
                          cartItem.product.imagePath,
                          height: 90,
                          width: 90,
                          fit: BoxFit.cover,
                        ),
                      ),
                      const SizedBox(width: 10),
                      //name&price
                      Padding(
                        padding: const EdgeInsets.only(left:5),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            //food name
                            Text(
                              cartItem.product.name,
                              style: const TextStyle(fontSize: 15),
                            ),
                            Text('TWD\$${cartItem.product.price.round()}',
                                style: TextStyle(
                                    color:
                                        Theme.of(context).colorScheme.primary)),
                        
                                        const SizedBox(height:10),
                                        //increment or decrement of quantity
                                         QuantitySelector(
                            quantity: cartItem.quantity,
                            product: cartItem.product,
                            onIncrement: () {
                              factory.addToCart(
                                  cartItem.product, cartItem.selectAddons);
                            },
                            onDecrement: () {
                              factory.removeFromCart(cartItem);
                            })
                          ],
                        ),
                      ),
                      const Spacer(),
                     
                    ],
                  ),
                ),
                //addons
                SizedBox(
                  height: cartItem.selectAddons.isEmpty ? 0 : 45,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    padding:
                        const EdgeInsets.only(left: 10, bottom: 10, right: 10),
                    children: cartItem.selectAddons
                        .map(
                          (addon) => Padding(
                            padding: const EdgeInsets.only(right: 5.0),
                            child: FilterChip(
                              label: Row(
                                children: [
                                  Text(addon.name),
                                  Text(' TWD\$${addon.price.round()}')
                                ],
                              ),
                              shape: StadiumBorder(
                                  side: BorderSide(
                                color: Theme.of(context).colorScheme.primary,
                              )),
                              onSelected: (value) {},
                              backgroundColor:
                                  Theme.of(context).colorScheme.secondary,
                              labelStyle: TextStyle(
                                color: Theme.of(context)
                                    .colorScheme
                                    .inversePrimary,
                                fontSize: 12,
                              ),
                            ),
                          ),
                        )
                        .toList(),
                  ),
                )
              ],
            )));
  }
}
