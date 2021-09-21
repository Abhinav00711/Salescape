import 'package:flutter/material.dart';

import './error_screen.dart';
import './loading_screen.dart';
import '../widgets/ProductScreen/product_list_screen.dart';
import '../widgets/ProductScreen/empty_product_screen.dart';
import '../data/global.dart';
import '../services/firestore_service.dart';
import '../models/product.dart';

class ProductScreen extends StatelessWidget {
  const ProductScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Product>>(
      future: FirestoreService().getAllProducts(Global.userData!.wid),
      builder: (context, productData) {
        if (productData.hasError) {
          return ErrorScreen();
        } else if (productData.hasData) {
          if (productData.data!.isEmpty) {
            return EmptyProductScreen();
          } else {
            return ProductListScreen(productList: productData.data!);
          }
        } else {
          return LoadingScreen();
        }
      },
    );
  }
}
