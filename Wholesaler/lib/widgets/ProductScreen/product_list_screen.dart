import 'package:flutter/material.dart';

import './add_product_form.dart';
import './product_card.dart';
import '../../models/product.dart';

class ProductListScreen extends StatelessWidget {
  const ProductListScreen({
    Key? key,
    required this.productList,
  }) : super(key: key);

  final List<Product> productList;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        iconTheme: IconThemeData(color: Colors.black),
        centerTitle: true,
        title: Text(
          'Products',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
      body: NotificationListener<OverscrollIndicatorNotification>(
        onNotification: (overScroll) {
          overScroll.disallowGlow();
          return false;
        },
        child: ListView.builder(
          itemCount: productList.length,
          itemBuilder: (context, index) {
            return ProductCard(product: productList[index]);
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddProduct()),
          );
        },
        backgroundColor: Colors.amber,
      ),
    );
  }
}
