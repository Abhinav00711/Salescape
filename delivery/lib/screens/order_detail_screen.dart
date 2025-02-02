import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:intl/intl.dart';
import 'package:location/location.dart';

import '../models/order.dart';
import '../models/delivery_location.dart';
import '../models/delivery.dart';
import '../data/global.dart';
import '../widgets/OrderDetailScreen/pickup_card.dart';
import '../widgets/OrderDetailScreen/drop_card.dart';
import '../services/firestore_service.dart';
import '../widgets/LoginScreen/decoration_functions.dart';

class OrderDetailScreen extends StatefulWidget {
  const OrderDetailScreen({required this.order, Key? key}) : super(key: key);

  final Order order;
  static final _formKey = new GlobalKey<FormState>();

  @override
  _OrderDetailScreenState createState() => _OrderDetailScreenState();
}

class _OrderDetailScreenState extends State<OrderDetailScreen> {
  @override
  Widget build(BuildContext context) {
    DeliveryLocation loc;
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
        child: NotificationListener<OverscrollIndicatorNotification>(
          onNotification: (overScroll) {
            overScroll.disallowGlow();
            return false;
          },
          child: SingleChildScrollView(
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
                                    text: widget.order.oid,
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
                                  text: '₹${widget.order.total}',
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
                                      .format(widget.order.dateTime),
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
                                  text: widget.order.status ==
                                          OrderStatus.completed
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
                              'Items : ${widget.order.items.length.toString()}',
                              style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                              ),
                            ),
                          ),
                          SizedBox(height: 10),
                          PickupCard(wid: widget.order.wid),
                          DropCard(rid: widget.order.rid),
                        ],
                      ),
                    ),
                  ),
                ),
                widget.order.status == OrderStatus.completed
                    ? Container()
                    : Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 50, vertical: 20),
                        child: widget.order.status == OrderStatus.accepted
                            ? ElevatedButton(
                                child: Text(
                                  'START',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                ),
                                onPressed: () async {
                                  Location location = new Location();
                                  bool _serviceEnabled;
                                  PermissionStatus _permissionGranted;
                                  LocationData _locationData;

                                  _serviceEnabled =
                                      await location.serviceEnabled();
                                  if (!_serviceEnabled) {
                                    _serviceEnabled =
                                        await location.requestService();
                                    if (!_serviceEnabled) {
                                      return;
                                    }
                                  }

                                  _permissionGranted =
                                      await location.hasPermission();
                                  if (_permissionGranted ==
                                      PermissionStatus.denied) {
                                    _permissionGranted =
                                        await location.requestPermission();
                                    if (_permissionGranted !=
                                        PermissionStatus.granted) {
                                      return;
                                    }
                                  }

                                  _locationData = await location.getLocation();
                                  loc = DeliveryLocation(
                                    did: Global.userData!.did,
                                    latitude: _locationData.latitude!,
                                    longitude: _locationData.longitude!,
                                  );
                                  await FirestoreService().updateLocation(loc);

                                  location.changeSettings(
                                      interval: 10000, distanceFilter: 30);
                                  location.enableBackgroundMode(enable: true);
                                  location.onLocationChanged
                                      .listen((locationData) async {
                                    loc = DeliveryLocation(
                                      did: Global.userData!.did,
                                      latitude: _locationData.latitude!,
                                      longitude: _locationData.longitude!,
                                    );
                                    await FirestoreService()
                                        .updateLocation(loc);
                                  });

                                  Order updatedOrder = Order(
                                    rid: widget.order.rid,
                                    oid: widget.order.oid,
                                    wid: widget.order.wid,
                                    bname: widget.order.bname,
                                    items: widget.order.items,
                                    total: widget.order.total,
                                    dateTime: widget.order.dateTime,
                                    status: OrderStatus.start,
                                    did: widget.order.did,
                                    otp: widget.order.otp,
                                  );
                                  await FirestoreService()
                                      .updateOrder(updatedOrder);
                                  setState(() {});
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
                            : Form(
                                key: OrderDetailScreen._formKey,
                                child: Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(16),
                                      child: TextFormField(
                                        style: const TextStyle(
                                          fontSize: 18,
                                          color: Colors.white,
                                        ),
                                        decoration: registerInputDecoration(
                                          hintText: 'OTP',
                                          icon: FontAwesomeIcons.lock,
                                        ),
                                        keyboardType: TextInputType.phone,
                                        maxLength: 4,
                                        maxLengthEnforcement:
                                            MaxLengthEnforcement.enforced,
                                        autocorrect: false,
                                        cursorColor: Colors.white,
                                        autovalidateMode:
                                            AutovalidateMode.onUserInteraction,
                                        validator: (value) {
                                          if (value!.trim().isEmpty) {
                                            return 'Please enter OTP.';
                                          } else if (!RegExp('[0-9]')
                                                  .hasMatch(value.trim()) ||
                                              value.trim().length != 4) {
                                            return 'Invalid OTP';
                                          } else if (value.trim() !=
                                              widget.order.otp) {
                                            return 'Wrong OTP';
                                          } else {
                                            return null;
                                          }
                                        },
                                      ),
                                    ),
                                    ElevatedButton(
                                      child: Text(
                                        'COMPLETE',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black,
                                        ),
                                      ),
                                      onPressed: () async {
                                        if (OrderDetailScreen
                                            ._formKey.currentState!
                                            .validate()) {
                                          OrderDetailScreen
                                              ._formKey.currentState!
                                              .save();
                                          Order updatedOrder = Order(
                                            rid: widget.order.rid,
                                            oid: widget.order.oid,
                                            wid: widget.order.wid,
                                            did: widget.order.did,
                                            bname: widget.order.bname,
                                            items: widget.order.items,
                                            total: widget.order.total,
                                            dateTime: widget.order.dateTime,
                                            status: OrderStatus.completed,
                                            otp: widget.order.otp,
                                          );
                                          await FirestoreService()
                                              .updateOrder(updatedOrder);
                                          Delivery updatedDelivery = Delivery(
                                            did: Global.userData!.did,
                                            name: Global.userData!.name,
                                            phone: Global.userData!.phone,
                                            state: Global.userData!.state,
                                            email: Global.userData!.email,
                                            status: 0,
                                          );
                                          await FirestoreService()
                                              .updateUser(updatedDelivery)
                                              .then((_) {
                                            Global.userData = updatedDelivery;
                                          });
                                          Navigator.of(context).pop();
                                        }
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
                                          borderRadius:
                                              BorderRadius.circular(30.0),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
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
