import 'dart:typed_data';

import 'package:flutter/material.dart';

import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../models/delivery_location.dart';
import '../services/firestore_service.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({Key? key, required this.did}) : super(key: key);

  final String did;

  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  Marker? marker;
  late Uint8List imageData;

  Future<void> getMarker() async {
    ByteData byteData =
        await DefaultAssetBundle.of(context).load("assets/images/marker.png");
    imageData = byteData.buffer.asUint8List();
  }

  @override
  void initState() {
    getMarker();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).primaryColor,
        appBar: AppBar(
          backgroundColor: Theme.of(context).primaryColor,
          iconTheme: IconThemeData(color: Colors.black),
          centerTitle: true,
          title: Text('Live Location'),
        ),
        body: StreamBuilder<DeliveryLocation>(
          stream: FirestoreService().getDeliveryLocation(widget.did),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Center(child: Text(snapshot.error.toString()));
            } else if (snapshot.hasData) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              } else if (snapshot.connectionState == ConnectionState.none) {
                return Center(child: Text('Not Connected'));
              }
              return GoogleMap(
                mapType: MapType.normal,
                initialCameraPosition: CameraPosition(
                  target:
                      LatLng(snapshot.data!.latitude, snapshot.data!.longitude),
                  zoom: 14.4746,
                ),
                markers: Set.of([
                  Marker(
                    markerId: MarkerId("delivery"),
                    position: LatLng(
                        snapshot.data!.latitude, snapshot.data!.longitude),
                    draggable: false,
                    flat: false,
                    icon: BitmapDescriptor.fromBytes(imageData),
                  ),
                ]),
              );
            } else {
              return Center(
                child: CircularProgressIndicator(
                  color: Theme.of(context).accentColor,
                ),
              );
            }
          },
        ));
  }
}
