import 'package:flutter/material.dart';

import 'package:intl/intl.dart';

import '../models/order.dart';
import '../widgets/OrderDetailScreen/pickup_card.dart';
import '../widgets/OrderDetailScreen/drop_card.dart';
import '../services/firestore_service.dart';

class OrderDetailScreen extends StatelessWidget {
  const OrderDetailScreen({required this.order, Key? key}) : super(key: key);

  final Order order;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal[900],
        iconTheme: IconThemeData(color: Colors.white),
        centerTitle: false,
        title: Text(
          'Order Details',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
      backgroundColor: Colors.teal[900],
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Card(
                color: Colors.teal[700],
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      FittedBox(
                        child: RichText(
                          text: TextSpan(
                            text: 'Order Id : ',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            ),
                            children: [
                              TextSpan(
                                text: order.oid,
                                style: TextStyle(
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 5),
                      RichText(
                        text: TextSpan(
                          text: 'Total : ',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                          children: [
                            TextSpan(
                              text: '₹${order.total}',
                              style: TextStyle(
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 5),
                      RichText(
                        text: TextSpan(
                          text: 'Date : ',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                          children: [
                            TextSpan(
                              text: DateFormat("MMMM dd, yyyy")
                                  .format(order.dateTime),
                              style: TextStyle(
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 5),
                      RichText(
                        text: TextSpan(
                          text: 'Status : ',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                          children: [
                            TextSpan(
                              text: order.status == OrderStatus.completed
                                  ? 'Completed'
                                  : 'Active',
                              style: TextStyle(
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Card(
                color: Colors.amber,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        width: double.infinity,
                        child: Text(
                          'Items : ${order.items.length.toString()}',
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                      ),
                      SizedBox(height: 10),
                      PickupCard(wid: order.wid),
                      DropCard(rid: order.rid),
                    ],
                  ),
                ),
              ),
            ),
            order.status == OrderStatus.completed
                ? Container()
                : Padding(
                    padding: EdgeInsets.symmetric(horizontal: 50, vertical: 20),
                    child: order.status == OrderStatus.accepted
                        ? ElevatedButton(
                            child: Text(
                              'START',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                            onPressed: () async {
                              Order updatedOrder = Order(
                                rid: order.rid,
                                oid: order.oid,
                                wid: order.wid,
                                bname: order.bname,
                                items: order.items,
                                total: order.total,
                                dateTime: order.dateTime,
                                status: OrderStatus.start,
                                otp: order.otp,
                              );
                              await FirestoreService()
                                  .updateOrder(updatedOrder);
                              Navigator.of(context).pop();
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
                        : ElevatedButton(
                            child: Text(
                              'COMPLETE',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                            onPressed: () async {
                              Order updatedOrder = Order(
                                rid: order.rid,
                                oid: order.oid,
                                wid: order.wid,
                                bname: order.bname,
                                items: order.items,
                                total: order.total,
                                dateTime: order.dateTime,
                                status: OrderStatus.completed,
                                otp: order.otp,
                              );
                              await FirestoreService()
                                  .updateOrder(updatedOrder);
                              Navigator.of(context).pop();
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
                          ),
                  ),
          ],
        ),
      ),
    );
  }
}
