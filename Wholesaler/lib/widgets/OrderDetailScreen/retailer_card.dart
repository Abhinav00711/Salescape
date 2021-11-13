import 'package:flutter/material.dart';

import '../../models/retailer.dart';
import '../../services/firestore_service.dart';

class RetailerCard extends StatelessWidget {
  const RetailerCard({
    Key? key,
    required this.rid,
  }) : super(key: key);

  final String rid;

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
            child: FutureBuilder<Retailer?>(
              future: FirestoreService().getRetailer(rid),
              builder: (context, userData) {
                if (userData.hasError) {
                  return Text('An Error Occurred!');
                } else if (userData.hasData) {
                  return Column(
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
                              text: userData.data!.name,
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
                              text: userData.data!.delivery_address,
                              style: TextStyle(
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  );
                } else {
                  return CircularProgressIndicator();
                }
              },
            ),
          ),
        ),
      ),
    );
  }
}
