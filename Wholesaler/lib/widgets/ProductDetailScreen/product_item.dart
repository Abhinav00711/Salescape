import 'package:flutter/material.dart';

class SeriesItem extends StatelessWidget {
  final String image;
  final String name;

  SeriesItem({
    required this.image,
    required this.name,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      color: Colors.teal,
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: MediaQuery.of(context).size.width * 0.7,
              height: 250,
              margin: const EdgeInsets.symmetric(horizontal: 10),
              padding: const EdgeInsets.all(15),
              child: FadeInImage(
                image: NetworkImage(image),
                placeholder: AssetImage('assets/images/Salescape.jpeg'),
                fit: BoxFit.contain,
              ),
            ),
            SizedBox(height: 20),
            Text(
              name,
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
