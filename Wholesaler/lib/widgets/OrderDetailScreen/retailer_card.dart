import 'package:flutter/material.dart';

import '../../models/retailer.dart';
import '../../services/firestore_service.dart';

class RetailerCard extends StatefulWidget {
  const RetailerCard({
    Key? key,
    required this.rid,
  }) : super(key: key);

  final String rid;

  @override
  _RetailerCardState createState() => _RetailerCardState();
}

class _RetailerCardState extends State<RetailerCard> {
  late Retailer _retailer;

  @override
  void initState() {
    super.initState();
    getRetailerData();
  }

  void getRetailerData() async {
    _retailer = await FirestoreService().getRetailer(widget.rid);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Card(
        elevation: 20,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        color: Colors.teal.shade800,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            width: double.infinity,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                RichText(
                  textAlign: TextAlign.left,
                  text: TextSpan(
                    text: 'Retailer Name : ',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                    children: [
                      TextSpan(
                        text: _retailer.name,
                        style: TextStyle(
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 5),
                RichText(
                  textAlign: TextAlign.left,
                  text: TextSpan(
                    text: 'Delivery Address : ',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                    children: [
                      TextSpan(
                        text: _retailer.delivery_address,
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
    );
  }
}
