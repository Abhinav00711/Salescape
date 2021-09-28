import 'package:flutter/material.dart';

import '../data/global.dart';
import '../models/order.dart';
import '../services/firestore_service.dart';
import '../widgets/OrderScreen/order_tile.dart';

class OrderScreen extends StatelessWidget {
  const OrderScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    late List<Order> _pendingOrders;
    late List<Order> _acceptedOrders;
    late List<Order> _completedOrders;
    return DefaultTabController(
      length: 3, // Number of Tabs
      child: Scaffold(
        backgroundColor: Theme.of(context).primaryColor,
        appBar: AppBar(
          backgroundColor: Theme.of(context).primaryColor,
          iconTheme: IconThemeData(color: Colors.black),
          centerTitle: true,
          title: Text(
            'ORDERS',
            style: TextStyle(
              color: Colors.white,
            ),
          ),
          bottom: TabBar(
            tabs: [
              Tab(
                text: 'Pending',
              ),
              Tab(
                text: 'Accepted',
              ),
              Tab(
                text: 'Completed',
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            FutureBuilder<List<Order>>(
              future:
                  FirestoreService().getPendingUserOrders(Global.userData!.rid),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Center(
                    child: Text(snapshot.error.toString()),
                  );
                } else if (snapshot.hasData) {
                  _pendingOrders = snapshot.data!;
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
                            itemCount: _pendingOrders.length,
                            itemBuilder: (context, index) {
                              return OrderTile(order: _pendingOrders[index]);
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
            FutureBuilder<List<Order>>(
              future: FirestoreService()
                  .getAcceptedUserOrders(Global.userData!.rid),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Center(
                    child: Text('Error'),
                  );
                } else if (snapshot.hasData) {
                  _acceptedOrders = snapshot.data!;
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
                            itemCount: _acceptedOrders.length,
                            itemBuilder: (context, index) {
                              return OrderTile(order: _acceptedOrders[index]);
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
            FutureBuilder<List<Order>>(
              future: FirestoreService()
                  .getCompletedUserOrders(Global.userData!.rid),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Center(
                    child: Text('Error'),
                  );
                } else if (snapshot.hasData) {
                  _completedOrders = snapshot.data!;
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
                            itemCount: _completedOrders.length,
                            itemBuilder: (context, index) {
                              return OrderTile(order: _completedOrders[index]);
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
          ],
        ),
      ),
    );
  }
}
