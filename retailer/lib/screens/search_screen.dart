import 'dart:async';

import 'package:flutter/material.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

import '../services/firestore_service.dart';
import '../widgets/SearchScreen/search_tile.dart';
import '../widgets/SearchScreen/search_bar.dart';
import '../providers/filter_provider.dart';
import '../models/product.dart';
import './filter_screen.dart';

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
    var industry =
        Provider.of<FilterProvider>(context, listen: false).industries;
    final List<Product> listProducts = [];
    listProducts.addAll(products);
    if (industry.isNotEmpty) {
      for (var product in products) {
        if (!industry.contains(product.industry)) {
          listProducts.remove(product);
        }
      }
      products.clear();
      products.addAll(listProducts);
    }
    var state = Provider.of<FilterProvider>(context, listen: false).locations;
    if (state.isNotEmpty) {
      for (var product in products) {
        var wState = await FirestoreService().getWholesalerState(product.wid);
        if (!state.contains(wState)) {
          listProducts.remove(product);
        }
      }
      products.clear();
      products.addAll(listProducts);
    }
    var range = Provider.of<FilterProvider>(context, listen: false).range;
    if (range.isNotEmpty) {
      for (var product in products) {
        if (product.price < range[0] || product.price > range[1]) {
          listProducts.remove(product);
        }
      }
      products.clear();
      products.addAll(listProducts);
    }
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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  child: SearchBar(
                    text: query,
                    onChanged: searchProduct,
                    hintText: 'Product or Business Name',
                  ),
                ),
                IconButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => FilterScreen(
                          isIndustry: widget.industry != null,
                        ),
                      ),
                    ).then((_) {
                      init();
                    });
                  },
                  splashRadius: 25,
                  icon: Icon(FontAwesomeIcons.filter),
                  color: Colors.white,
                ),
              ],
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
        var industry =
            Provider.of<FilterProvider>(context, listen: false).industries;
        final List<Product> listProducts = [];
        listProducts.addAll(products);
        if (industry.isNotEmpty) {
          for (var product in products) {
            if (!industry.contains(product.industry)) {
              listProducts.remove(product);
            }
          }
          products.clear();
          products.addAll(listProducts);
        }
        var state =
            Provider.of<FilterProvider>(context, listen: false).locations;
        if (state.isNotEmpty) {
          for (var product in products) {
            var wState =
                await FirestoreService().getWholesalerState(product.wid);
            if (!state.contains(wState)) {
              listProducts.remove(product);
            }
          }
          products.clear();
          products.addAll(listProducts);
        }
        var range = Provider.of<FilterProvider>(context, listen: false).range;
        if (range.isNotEmpty) {
          for (var product in products) {
            if (product.price < range[0] || product.price > range[1]) {
              listProducts.remove(product);
            }
          }
          products.clear();
          products.addAll(listProducts);
        }
        if (!mounted) return;
        setState(() {
          this.query = query;
          this.products = products;
        });
      });
}
