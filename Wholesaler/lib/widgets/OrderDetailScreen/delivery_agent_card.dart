import 'package:flutter/material.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../models/retailer.dart';
import '../../models/delivery.dart';
import '../../services/firestore_service.dart';
import '../../screens/map_screen.dart';

class DeliveryAgentCard extends StatelessWidget {
  const DeliveryAgentCard({
    Key? key,
    required this.rid,
    required this.did,
    required this.isCompleted,
    required this.isStarted,
  }) : super(key: key);

  final String rid;
  final String did;
  final bool isCompleted;
  final bool isStarted;

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
        child: FutureBuilder<Retailer?>(
          future: FirestoreService().getRetailer(rid),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Center(
                child: Text(snapshot.error.toString()),
              );
            } else if (snapshot.hasData) {
              Retailer _retailer = snapshot.data!;
              return FutureBuilder<Delivery?>(
                future: FirestoreService().getDelivery(did),
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return Center(
                      child: Text(snapshot.error.toString()),
                    );
                  } else if (snapshot.hasData) {
                    Delivery _delivery = snapshot.data!;
                    return Padding(
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
                            SizedBox(height: 5),
                            RichText(
                              textAlign: TextAlign.left,
                              text: TextSpan(
                                text: 'Delivery Agent : ',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                ),
                                children: [
                                  TextSpan(
                                    text: _delivery.name,
                                    style: TextStyle(
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: isCompleted ? 0 : 5),
                            isCompleted
                                ? Container()
                                : Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      ElevatedButton.icon(
                                        onPressed: () {
                                          launch("tel://${_delivery.phone}");
                                        },
                                        icon: Icon(Icons.call),
                                        label: Text('CALL'),
                                      ),
                                      ElevatedButton.icon(
                                        onPressed: () {
                                          if (isStarted) {
                                            Navigator.of(context).push(
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      MapScreen(
                                                          did: _delivery.did)),
                                            );
                                          }
                                        },
                                        icon: Icon(FontAwesomeIcons.mapMarker),
                                        label: Text('LOCATION'),
                                      ),
                                    ],
                                  ),
                          ],
                        ),
                      ),
                    );
                  } else {
                    return Center(
                      child: CircularProgressIndicator(
                        color: Theme.of(context).accentColor,
                      ),
                    );
                  }
                },
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
    );
  }
}
