import 'package:flutter/material.dart';

import '../../models/product.dart';

class ProductTile extends StatelessWidget {
  const ProductTile({
    Key? key,
    required this.product,
  }) : super(key: key);

  final Product product;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Image.network(
        product.imageUrl,
        fit: BoxFit.cover,
        width: 50,
        height: 50,
      ),
      title: Text(product.name),
      subtitle: Text(product.wid),
      trailing: Text('₹${product.price}'),
    );
  }
}
