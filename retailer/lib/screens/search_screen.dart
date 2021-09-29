import 'dart:async';

import 'package:flutter/material.dart';

import 'package:retailer/services/firestore_service.dart';
import 'package:retailer/widgets/SearchScreen/product_tile.dart';
import 'package:retailer/widgets/SearchScreen/search_bar.dart';
import '../models/product.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  List<Product> products = [];
  String query = '';
  Timer? debouncer;

  @override
  void initState() {
    super.initState();
    init();
  }

  @override
  void dispose() {
    debouncer?.cancel();
    super.dispose();
  }

  void debounce(
    VoidCallback callback, {
    Duration duration = const Duration(milliseconds: 1000),
  }) {
    if (debouncer != null) {
      debouncer!.cancel();
    }

    debouncer = Timer(duration, callback);
  }

  Future init() async {
    final products = await FirestoreService().getAllProductsByQuery(query);

    setState(() => this.products = products);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).primaryColor,
      child: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            SearchBar(
              text: query,
              onChanged: searchProduct,
              hintText: 'Product or Wholesaler Name',
            ),
            Expanded(
              child: ListView.builder(
                itemCount: products.length,
                itemBuilder: (_, index) =>
                    ProductTile(product: products[index]),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future searchProduct(String query) async => debounce(() async {
        final products = await FirestoreService().getAllProductsByQuery(query);

        if (!mounted) return;

        setState(() {
          this.query = query;
          this.products = products;
        });
      });
}
