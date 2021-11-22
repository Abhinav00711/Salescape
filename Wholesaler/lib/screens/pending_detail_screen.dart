import 'package:flutter/material.dart';

import 'package:intl/intl.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../models/delivery.dart';
import './active_detail_screen.dart';
import '../models/order.dart';
import '../data/global.dart';
import '../widgets/OrderDetailScreen/order_item.dart';
import '../widgets/OrderDetailScreen/retailer_card.dart';
import '../services/firestore_service.dart';

class PendingDetailScreen extends StatelessWidget {
  const PendingDetailScreen({
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
          RetailerCard(rid: order.rid),
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
                        ' PENDING',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 24,
                          letterSpacing: 0.18,
                        ),
                      ),
                    ],
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
                      text: 'Pickup Address : ',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                      children: [
                        TextSpan(
                          text: Global.userData!.pickup_address,
                          style: TextStyle(
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 5),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton.icon(
                        onPressed: () async {
                          var delList =
                              await FirestoreService().getAllFreeDelivery();
                          if (delList.isNotEmpty) {
                            Delivery delivery = delList.firstWhere(
                              (element) =>
                                  element.state == Global.userData!.state,
                              orElse: () => delList[0],
                            );
                            Order updatedOrder = Order(
                              rid: order.rid,
                              oid: order.oid,
                              wid: order.wid,
                              bname: order.bname,
                              items: order.items,
                              total: order.total,
                              dateTime: order.dateTime,
                              status: OrderStatus.accepted,
                              otp: order.otp,
                              did: delivery.did,
                            );
                            await FirestoreService().updateOrder(updatedOrder);
                            Delivery updatedDelivery = Delivery(
                              did: delivery.did,
                              name: delivery.name,
                              phone: delivery.phone,
                              state: delivery.state,
                              email: delivery.email,
                              status: 1,
                            );
                            await FirestoreService()
                                .updateDeliveryStatus(updatedDelivery);
                            Navigator.of(context).pushReplacement(
                              MaterialPageRoute(
                                  builder: (context) =>
                                      ActiveDetailScreen(order: updatedOrder)),
                            );
                          } else {
                            Fluttertoast.showToast(
                                msg: "Delivery Agent not available.",
                                toastLength: Toast.LENGTH_SHORT,
                                timeInSecForIosWeb: 1,
                                fontSize: 16.0);
                          }
                        },
                        icon: Icon(FontAwesomeIcons.checkCircle),
                        label: Text(
                          'Accept',
                          style: TextStyle(
                            color: Colors.black,
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                          primary: Colors.tealAccent,
                        ),
                      ),
                      ElevatedButton.icon(
                        onPressed: () async {
                          await FirestoreService().deleteOrder(order.oid);
                          Navigator.of(context).pop();
                        },
                        icon: Icon(FontAwesomeIcons.windowClose),
                        label: Text(
                          'Decline',
                          style: TextStyle(
                            color: Colors.black,
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                          primary: Colors.redAccent,
                        ),
                      ),
                    ],
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
