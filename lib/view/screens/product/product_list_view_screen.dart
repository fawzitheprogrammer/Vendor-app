import 'package:flutter/material.dart';
import 'package:wave_mall_vendor/localization/language_constrants.dart';
import 'package:wave_mall_vendor/view/base/custom_app_bar.dart';
import 'package:wave_mall_vendor/view/screens/product/most_popular_product.dart';
import 'package:wave_mall_vendor/view/screens/product/top_selling_product.dart';

class ProductListScreen extends StatelessWidget {
  final String title;
  final bool isPopular;
  const ProductListScreen({Key? key, required this.title, this.isPopular = false}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ScrollController scrollController = ScrollController();

    return Scaffold(
      appBar: CustomAppBar(title: getTranslated(title, context)),
      body: SingleChildScrollView(
        controller: scrollController,
        child: Container(child: isPopular?
         const MostPopularProductScreen():
         TopSellingProductScreen(scrollController: scrollController)),
      ),

    );
  }
}
