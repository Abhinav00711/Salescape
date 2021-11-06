import 'package:flutter/material.dart';

class ProductItem extends StatelessWidget {
  final String image;
  final String name;

  ProductItem({
    required this.image,
    required this.name,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      color: Colors.teal[300],
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: double.infinity,
            height: 250,
            margin: const EdgeInsets.symmetric(horizontal: 10),
            padding: const EdgeInsets.all(15),
            child: FadeInImage(
              image: NetworkImage(image),
              placeholder: AssetImage('assets/images/Salescape.jpeg'),
              fit: BoxFit.contain,
            ),
          ),
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
    );
  }
}
