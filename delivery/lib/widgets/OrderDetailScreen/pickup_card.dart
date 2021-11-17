import 'package:flutter/material.dart';

import 'package:url_launcher/url_launcher.dart';

import '../../models/wholesaler.dart';
import '../../services/firestore_service.dart';

class PickupCard extends StatelessWidget {
  const PickupCard({Key? key, required this.wid}) : super(key: key);

  final String wid;

  @override
  Widget build(BuildContext context) {
    late Wholesaler _wholesaler;
    return Card(
      color: Colors.teal,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          width: double.infinity,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Image.asset(
                    'assets/images/pickup.png',
                  ),
                  SizedBox(width: 10),
                  Text(
                    'PICK-UP',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 5),
              FittedBox(
                child: FutureBuilder<Wholesaler?>(
                  future: FirestoreService().getWholesaler(wid),
                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      return Center(
                        child: Text(snapshot.error.toString()),
                      );
                    } else if (snapshot.hasData) {
                      _wholesaler = snapshot.data!;
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              _wholesaler.name,
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                              ),
                            ),
                            Text(
                              _wholesaler.pickup_address,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                              ),
                            ),
                            ElevatedButton.icon(
                              style: ElevatedButton.styleFrom(
                                primary: Colors.amber,
                              ),
                              onPressed: () {
                                launch("tel://${_wholesaler.phone}");
                              },
                              icon: Icon(
                                Icons.call,
                                color: Colors.black,
                              ),
                              label: Text(
                                'CALL',
                                style: TextStyle(color: Colors.black),
                              ),
                            ),
                          ],
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
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
