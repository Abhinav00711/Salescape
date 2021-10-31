import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import '../../models/cart_item.dart';
import '../../providers/cart_provider.dart';
import '../../utils/custom_dialog_box.dart';

class OrderItem extends StatelessWidget {
  final CartItem item;
  const OrderItem({
    Key? key,
    required this.item,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Theme.of(context).accentColor,
      margin: EdgeInsets.all(15.0),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: [
          Expanded(
            flex: 8,
            child: Container(
              padding: EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.item,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      letterSpacing: 0.18,
                      color: const Color(0xff092E34),
                    ),
                  ),
                  SizedBox(height: 20),
                  Text('₹ ${item.price.toString()} (${item.unit})'),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  InkWell(
                    child: Icon(Icons.keyboard_arrow_up_rounded),
                    onTap: () {
                      Provider.of<CartProvider>(context, listen: false)
                          .increaseQuantity(item);
                    },
                  ),
                  Text(
                    '${item.quantity}x',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  item.quantity == 1
                      ? InkWell(
                          child: Icon(
                            Icons.delete,
                            color: Colors.red,
                          ),
                          onTap: () {
                            showDialog(
                              context: context,
                              barrierDismissible: false,
                              builder: (context) {
                                return CustomDialogBox(
                                  title: 'Are you sure?',
                                  descriptions:
                                      'Do you want to remove the selected item?',
                                  text: 'Yes',
                                  img: 'assets/images/removing.png',
                                  onPressed: () {
                                    Provider.of<CartProvider>(context,
                                            listen: false)
                                        .remove(item);
                                  },
                                );
                              },
                            );
                          },
                        )
                      : InkWell(
                          child: Icon(Icons.keyboard_arrow_down_rounded),
                          onTap: () {
                            Provider.of<CartProvider>(context, listen: false)
                                .decreaseQuantity(item);
                          },
                        ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
