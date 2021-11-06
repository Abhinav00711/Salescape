import 'package:flutter/material.dart';

import 'package:badges/badges.dart';
import 'package:provider/provider.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../providers/cart_provider.dart';
import '../../models/cart_item.dart';
import '../../models/product.dart';

class AddButton extends StatelessWidget {
  const AddButton({
    Key? key,
    required this.product,
  }) : super(key: key);

  final Product product;

  @override
  Widget build(BuildContext context) {
    int q = Provider.of<CartProvider>(context).getProductQuantity(product.pid);
    return Badge(
      badgeContent: Text(
        q.toString(),
        style: TextStyle(color: Colors.white),
      ),
      showBadge: q != 0,
      child: FloatingActionButton(
        child: Icon(q == 0 ? Icons.add : Icons.shopping_cart),
        onPressed: () async {
          bool isAdded = await Provider.of<CartProvider>(context, listen: false)
              .add(CartItem(
            pid: product.pid,
            item: product.name,
            quantity: 1,
            price: product.price,
            unit: product.unit,
          ));
          if (isAdded) {
            Fluttertoast.showToast(
                msg: "Successfully Added",
                toastLength: Toast.LENGTH_SHORT,
                timeInSecForIosWeb: 1,
                fontSize: 16.0);
          } else {
            Fluttertoast.showToast(
                msg: "Not Same Wholesaler",
                toastLength: Toast.LENGTH_SHORT,
                timeInSecForIosWeb: 1,
                fontSize: 16.0);
          }
        },
      ),
      badgeColor: const Color(0xff092E34),
      animationType: BadgeAnimationType.scale,
    );
  }
}
