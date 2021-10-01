import 'dart:async';

import 'package:flutter/material.dart';

import 'package:retailer/services/firestore_service.dart';
import 'package:retailer/widgets/SearchScreen/search_tile.dart';
import 'package:retailer/widgets/SearchScreen/search_bar.dart';
import '../models/product.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({
    Key? key,
    this.industry,
  }) : super(key: key);

  final String? industry;

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
    final products = widget.industry == null
        ? await FirestoreService().getAllProductsByQuery(query)
        : await FirestoreService()
            .getAllIndustryProductsByQuery(query, widget.industry!);

    setState(() => this.products = products);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: widget.industry == null
          ? null
          : AppBar(
              backgroundColor: Theme.of(context).primaryColor,
              iconTheme: IconThemeData(color: Colors.black),
              centerTitle: true,
              title: Text(
                widget.industry!,
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
      backgroundColor: Theme.of(context).primaryColor,
      body: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            SearchBar(
              text: query,
              onChanged: searchProduct,
              hintText: 'Product or Business Name',
            ),
            Expanded(
              child: ListView.builder(
                itemCount: products.length,
                itemBuilder: (_, index) => SearchTile(product: products[index]),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future searchProduct(String query) async => debounce(() async {
        final products = widget.industry == null
            ? await FirestoreService().getAllProductsByQuery(query)
            : await FirestoreService()
                .getAllIndustryProductsByQuery(query, widget.industry!);

        if (!mounted) return;

        setState(() {
          this.query = query;
          this.products = products;
        });
      });
}
