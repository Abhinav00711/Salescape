import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../models/product.dart';
import '../../models/cart_item.dart';
import '../../providers/cart_provider.dart';

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
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Theme.of(context).accentColor,
        ),
        height: 100,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Expanded(
                flex: 1,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8.0),
                  child: Image.network(
                    product.imageUrl,
                    fit: BoxFit.cover,
                    width: 80,
                    height: 80,
                  ),
                ),
              ),
              Expanded(
                flex: 2,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        product.name,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                        ),
                      ),
                      SizedBox(height: 10),
                      Text(
                        product.bname,
                        style: TextStyle(
                          color: Colors.blueGrey,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                flex: 2,
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(height: 8),
                    Text(
                      '₹${product.price}',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    ElevatedButton.icon(
                      onPressed: () async {
                        bool isAdded = await Provider.of<CartProvider>(context,
                                listen: false)
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
                      icon: Icon(Icons.shopping_cart),
                      label: Text('ADD'),
                      style: ElevatedButton.styleFrom(
                        primary: const Color(0xff092E34),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
