import 'dart:math';

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
import '../utils/custom_dialog_box.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  String generateOTP() {
    var rnd = Random(DateTime.now().millisecondsSinceEpoch);
    String otp = '';
    for (var i = 0; i < 4; i++) {
      otp = otp + rnd.nextInt(10).toString();
    }
    return otp;
  }

  @override
  Widget build(BuildContext context) {
    late List<CartItem> _items;
    bool _isConfirming = false;
    double _total = context.watch<CartProvider>().totalPrice;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        iconTheme: IconThemeData(color: Colors.black),
        centerTitle: true,
        title: Text(
          'Order Summary',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
      body: Container(
        color: Theme.of(context).primaryColor,
        child: FutureBuilder<List<CartItem>>(
            future: context.watch<CartProvider>().items,
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
                      Expanded(
                        child: NotificationListener<
                            OverscrollIndicatorNotification>(
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
                        padding: EdgeInsets.fromLTRB(10, 10, 10, 70),
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
                                      fontSize: 20,
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
                                      String wid = await FirestoreService()
                                          .getProduct(_items[0].pid)
                                          .then((product) => product!.wid);
                                      Order order = Order(
                                        rid: Global.userData!.rid,
                                        oid: Uuid().v1().replaceAll('-', ''),
                                        wid: wid,
                                        bname: await FirestoreService()
                                            .getWholesalerBname(wid),
                                        items: _items,
                                        total: _total,
                                        dateTime: DateTime.now(),
                                        status: OrderStatus.pending,
                                        otp: generateOTP(),
                                      );
                                      showDialog(
                                        context: context,
                                        barrierDismissible: false,
                                        builder: (context) {
                                          return CustomDialogBox(
                                            title: 'Are you sure?',
                                            descriptions:
                                                'Do you want to confirm the order?',
                                            text: 'Yes',
                                            img:
                                                'assets/images/confirmation.png',
                                            onPressed: () async {
                                              await FirestoreService()
                                                  .addOrder(order);
                                              context
                                                  .read<CartProvider>()
                                                  .removeAll();
                                              setState(() {
                                                _isConfirming = false;
                                              });
                                              Navigator.of(context).pop();
                                            },
                                          );
                                        },
                                      );
                                    },
                              style: ElevatedButton.styleFrom(
                                primary: Colors.amber,
                                padding: EdgeInsets.symmetric(
                                    horizontal: 30, vertical: 10),
                                textStyle: TextStyle(
                                  fontSize: 15,
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
      ),
    );
  }
}
