import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

import '../data/global.dart';
import '../models/cart_item.dart';
import '../models/order.dart';
import '../providers/cart_provider.dart';
import '../services/firestore_service.dart';
import '../widgets/CartScreen/empty_cart_screen.dart';
import '../widgets/CartScreen/order_item.dart';
import '../utils/dialog.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  void _selectCategory(BuildContext ctx, IconData icon, String title,
      String button, Color color, String description) {
    showGeneralDialog(
      barrierColor: Colors.black.withOpacity(0.5),
      barrierDismissible: true,
      context: ctx,
      transitionBuilder: (context, a1, a2, widget) {
        return Transform.scale(
          scale: a1.value,
          child: Opacity(
            opacity: a1.value,
            child: CommonDialog(
              title: title,
              button: button,
              color: color,
              description: description,
              icon: icon,
            ),
          ),
        );
      },
      transitionDuration: Duration(milliseconds: 200),
      barrierLabel: '',
      pageBuilder: (context, animation1, animation2) {
        return Transform.scale(
          scale: animation1.value,
          child: Opacity(
            opacity: animation1.value,
            child: CommonDialog(
              title: title,
              button: button,
              color: color,
              description: description,
              icon: icon,
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    late List<CartItem> _items;
    bool _isConfirming = false;
    int _total = context.read<CartProvider>().totalPrice;
    return Container(
      color: Theme.of(context).primaryColor,
      child: FutureBuilder<List<CartItem>>(
          future: context.read<CartProvider>().items,
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Center(
                child: Text('Error'),
              );
            } else if (snapshot.hasData) {
              _items = snapshot.data!;
              if (_items.isNotEmpty) {
                return Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Text(
                      'Order Summary',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    Expanded(
                      child:
                          NotificationListener<OverscrollIndicatorNotification>(
                        onNotification: (overScroll) {
                          overScroll.disallowGlow();
                          return false;
                        },
                        child: ListView.builder(
                          itemCount: _items.length,
                          itemBuilder: (context, index) {
                            return OrderItem(item: _items[index]);
                          },
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(10),
                      color: const Color(0xff092E34),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                Icons.info_outline_rounded,
                                color: Colors.white,
                              ),
                              RichText(
                                text: TextSpan(
                                  text: ' Total: ',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 24,
                                    letterSpacing: 0.18,
                                  ),
                                  children: [
                                    TextSpan(
                                      text: '₹${_total}',
                                      style: TextStyle(
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          ElevatedButton(
                            child: _isConfirming
                                ? CircularProgressIndicator(
                                    color: Colors.white,
                                  )
                                : Text(
                                    'CONFIRM',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: const Color(0xff092E34),
                                    ),
                                  ),
                            onPressed: _items.isEmpty
                                ? null
                                : () async {
                                    setState(() {
                                      _isConfirming = true;
                                    });
                                    Order order = Order(
                                      rid: Global.userData!.rid,
                                      oid: Uuid().v1().replaceAll('-', ''),
                                      items: _items,
                                      total: _total,
                                      dateTime: DateTime.now(),
                                      status: OrderStatus.pending,
                                    );
                                    // await FirestoreService().addOrder(order);
                                    // context.read<CartProvider>().removeAll();
                                    // Navigator.pop(context);
                                    // _selectCategory(
                                    //   context,
                                    //   Icons.check,
                                    //   'Order Requested Successfully',
                                    //   'Keep Shopping',
                                    //   const Color(0xff22A45D),
                                    //   'Your order request is successfully placed. We will contact you soon, till then stay put:)',
                                    // );
                                  },
                            style: ElevatedButton.styleFrom(
                              primary: Colors.amber,
                              padding: EdgeInsets.symmetric(
                                  horizontal: 30, vertical: 10),
                              textStyle: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                              shadowColor: Colors.amberAccent,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30.0),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                );
              } else {
                return EmptyCartScreen();
              }
            } else {
              return Center(
                child: CircularProgressIndicator(
                  color: Theme.of(context).accentColor,
                ),
              );
            }
          }),
    );
  }
}
