import 'package:flutter/material.dart';

import '../../models/product.dart';

class SearchTile extends StatelessWidget {
  const SearchTile({
    Key? key,
    required this.product,
  }) : super(key: key);

  final Product product;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        color: Theme.of(context).accentColor,
        child: ListTile(
          contentPadding: EdgeInsets.symmetric(horizontal: 5.0),
          leading: Image.network(
            product.imageUrl,
            fit: BoxFit.cover,
            width: 50,
            height: 50,
          ),
          title: Text(product.name),
          subtitle: Text(product.wname),
          trailing: Text('₹${product.price}'),
        ),
      ),
    );
  }
}
