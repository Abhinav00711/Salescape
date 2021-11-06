import 'package:flutter/material.dart';

import 'package:intl/intl.dart';

import '../../screens/pending_detail_screen.dart';
import '../../models/order.dart';

class OrderTile extends StatelessWidget {
  const OrderTile({required this.order, Key? key}) : super(key: key);

  final Order order;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        switch (order.status) {
          case OrderStatus.pending:
            {
              Navigator.of(context).push(
                MaterialPageRoute(
                    builder: (context) => PendingDetailScreen(order: order)),
              );
              break;
            }
          case OrderStatus.accepted:
            {
              break;
            }
          case OrderStatus.completed:
            {
              break;
            }
        }
      },
      child: Card(
        color: Theme.of(context).accentColor,
        margin: EdgeInsets.all(15.0),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          children: [
            Expanded(
              flex: 7,
              child: Container(
                padding: EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${order.items.length.toString()} Items',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        letterSpacing: 0.18,
                        color: const Color(0xff092E34),
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      DateFormat("MMMM dd, yyyy").format(order.dateTime),
                      style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 14,
                        letterSpacing: -0.04,
                        color: const Color(0xff092E34),
                      ),
                    ),
                    SizedBox(height: 5),
                    Text(
                      DateFormat.jm().format(order.dateTime),
                      style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 14,
                        letterSpacing: -0.04,
                        color: const Color(0xff092E34),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 3,
              child: Container(
                alignment: Alignment.bottomCenter,
                padding: EdgeInsets.all(8.0),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      '₹ ${order.total}',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
