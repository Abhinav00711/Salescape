import 'package:flutter/material.dart';

import 'package:intl/intl.dart';

import '../models/order.dart';
import '../data/global.dart';
import '../widgets/OrderDetailScreen/order_item.dart';
import '../widgets/OrderDetailScreen/delivery_agent_card.dart';

class ActiveDetailScreen extends StatelessWidget {
  const ActiveDetailScreen({
    Key? key,
    required this.order,
  }) : super(key: key);

  final Order order;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.teal,
      appBar: AppBar(
        backgroundColor: Colors.teal,
        iconTheme: IconThemeData(color: Colors.white),
        centerTitle: true,
        title: Text(
          'Order Summary',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: [
          DeliveryAgentCard(
            isCompleted: order.status == OrderStatus.completed,
            isStarted: order.status == OrderStatus.start,
            did: order.did,
            otp: order.otp,
          ),
          Expanded(
            child: NotificationListener<OverscrollIndicatorNotification>(
              onNotification: (overScroll) {
                overScroll.disallowGlow();
                return false;
              },
              child: ListView.builder(
                itemCount: order.items.length,
                itemBuilder: (context, index) {
                  return OrderItem(item: order.items[index]);
                },
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(vertical: 10),
            width: double.infinity,
            color: const Color(0xff092E34),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.info_outline_rounded,
                        color: Colors.white,
                      ),
                      Text(
                        order.status == OrderStatus.completed
                            ? ' COMPLETED'
                            : ' ACTIVE',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 24,
                          letterSpacing: 0.18,
                        ),
                      ),
                    ],
                  ),
                  Text(
                    order.bname,
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      letterSpacing: 0.18,
                    ),
                  ),
                  RichText(
                    text: TextSpan(
                      text: 'Order Id : ',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
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
                  RichText(
                    text: TextSpan(
                      text: 'Order Date : ',
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
                  RichText(
                    text: TextSpan(
                      text: 'Delivery Address : ',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                      children: [
                        TextSpan(
                          text: Global.userData!.delivery_address,
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
        ],
      ),
    );
  }
}
