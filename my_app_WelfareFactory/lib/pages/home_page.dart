import 'package:flutter/material.dart';
import 'package:my_app/components/my_current_location.dart';
import 'package:my_app/components/my_description_box.dart';
import 'package:my_app/components/my_drawer.dart';
import 'package:my_app/components/my_product_tile.dart';
import 'package:my_app/components/my_sliver_app_bar.dart';
import 'package:my_app/components/my_tab_bar.dart';
import 'package:my_app/models/product.dart';
import 'package:my_app/models/factory.dart' as MyAppFactory;
import 'package:my_app/pages/product_page.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
// tab controller
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController =
        TabController(length: ProductCategory.values.length, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

///////
//sort out and return a list of food item of each category
  List<Product> _filterMenuByCategory(
      ProductCategory category, List<Product> fullMenu) {
    return fullMenu.where((product) => product.category == category).toList();
  }

//return list in given category
  List<Widget> getProductInThisCategory(List<Product> fullMenu) {
    return ProductCategory.values.map((category) {
      //get food menu
      List<Product> categoryMenu = _filterMenuByCategory(category, fullMenu);

      return ListView.builder(
        itemCount: categoryMenu.length,
        physics: const NeverScrollableScrollPhysics(),
        padding: EdgeInsets.zero,
        itemBuilder: (context, index) {
          //each product
          final product = categoryMenu[index];
          return ProductTile(
            product: product,
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ProductPage(product: product),
              ),
            ),
          );
        },
      );
    }).toList();
  }

///////

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: MyDrawer(),
        body: NestedScrollView(
            headerSliverBuilder: (context, innerBoxIsScrolled) => [
                  MySliverAppBar(
                    title: MyTabBar(tabController: _tabController),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Divider(
                          indent: 25,
                          endIndent: 25,
                          color: Theme.of(context).colorScheme.secondary,
                        ),
                        //my current location
                         MyCurrentLocation(),
                        //description box
                        const MyDescriptionBox(),
                      ],
                    ),
                  ),
                ],
            body: Consumer<MyAppFactory.Factory>(
              builder: (context, factory, child) => TabBarView(
                controller: _tabController,
                children: getProductInThisCategory(factory.menu),
              ),
            )));
  }
}
