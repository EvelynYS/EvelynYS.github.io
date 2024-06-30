import 'package:flutter/material.dart';
import 'package:my_app/models/product.dart';

class MyTabBar extends StatelessWidget {
  final TabController tabController;

  const MyTabBar({
    super.key,
    required this.tabController,
  });

  List<Tab> _buildCategoryTabs() {
    return ProductCategory.values.map((category) {
      return Tab(
        text: category.toString().split('.').last,
      );
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: TabBar(
      controller: tabController,
      tabs: _buildCategoryTabs(),
      dividerColor: Colors.transparent,
    ));
  }
}
