import 'package:flutter/material.dart';
import 'package:my_app/pages/cart_page.dart';
import 'package:my_app/models/factory.dart' as MyAppFactory;
import 'package:provider/provider.dart';

class MySliverAppBar extends StatelessWidget {
  final Widget child;
  final Widget title;

  const MySliverAppBar({
    super.key,
    required this.child,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      expandedHeight: 320,
      collapsedHeight: 120,
      floating: false,
      pinned: true,
      actions: [
        //cart btn with badge
        Consumer<MyAppFactory.Factory>(builder: (context, factory, child) {
          return Stack(
            children: [
//cart Btn
              IconButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const CartPage(),
                      ));
                },
                icon: const Icon(Icons.shopping_cart),
                iconSize: 30.0,
                padding: const EdgeInsets.all(10.0),
              ),
              if (factory.itemCount > 0)
                Positioned(
                    right: 18,
                    bottom: 20,
                    child: Container(
                        width: 18, // 圓形標記的寬度
                        height: 20, // 圓形標記的高度
                        decoration: const BoxDecoration(
                          color: Colors.orange,
                          shape: BoxShape.circle, // 圓形裝飾
                        ),
                        child: Text(
                          '${factory.itemCount}',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                          ),
                          textAlign: TextAlign.center,
                        )))
            ],
          );
        })
      ],
      backgroundColor: Theme.of(context).colorScheme.background,
      foregroundColor: Theme.of(context).colorScheme.inversePrimary,
      title: const Text("Welfare Factory"),
      flexibleSpace: FlexibleSpaceBar(
        background: Padding(
          padding: const EdgeInsets.only(bottom: 25.0),
          child: child,
        ),
        title: title,
        centerTitle: true,
        titlePadding: const EdgeInsets.only(left: 0, right: 0, top: 0),
        expandedTitleScale: 1,
      ),
    );
  }
}
