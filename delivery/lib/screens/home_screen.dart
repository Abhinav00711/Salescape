import 'package:flutter/material.dart';

import '../widgets/HomeScreen/profile_card.dart';
import '../widgets/OrderScreen/order_tile.dart';
import '../models/order.dart';
import '../services/firestore_service.dart';
import '../data/global.dart';
import './order_detail_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    late List<Order> _orders;
    return Scaffold(
      backgroundColor: Colors.teal,
      body: SafeArea(
        bottom: false,
        left: false,
        right: false,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ProfileCard(),
            ),
            Expanded(
              child: FutureBuilder<List<Order>>(
                future:
                    FirestoreService().getAllUserOrders(Global.userData!.did),
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return Center(
                      child: Text(snapshot.error.toString()),
                    );
                  } else if (snapshot.hasData) {
                    _orders = snapshot.data!;
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
                              itemCount: _orders.length,
                              itemBuilder: (context, index) {
                                return InkWell(
                                  child: OrderTile(order: _orders[index]),
                                  onTap: () {
                                    Navigator.of(context)
                                        .push(
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              OrderDetailScreen(
                                                  order: _orders[index])),
                                    )
                                        .then((_) {
                                      setState(() {});
                                    });
                                  },
                                );
                              },
                            ),
                          ),
                        ),
                      ],
                    );
                  } else {
                    return Center(
                      child: CircularProgressIndicator(
                        color: Theme.of(context).accentColor,
                      ),
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
