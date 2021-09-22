import 'package:flutter/material.dart';

import '../models/product.dart';
import '../utils/curve_painter.dart';
import '../../widgets/ProductDetailScreen/product_item.dart';

class ProductDetailScreen extends StatelessWidget {
  const ProductDetailScreen({
    Key? key,
    required this.product,
  }) : super(key: key);

  final Product product;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal,
        iconTheme: IconThemeData(color: Colors.white),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              AnimatedContainer(
                duration: Duration(milliseconds: 500),
                curve: Curves.ease,
                height: MediaQuery.of(context).size.height * 0.4,
                child: CustomPaint(
                  painter: CurvePainter(true, color: Colors.teal),
                  child: Container(
                    padding: EdgeInsets.only(bottom: 0),
                    child: Center(
                      child: SeriesItem(
                        image: product.imageUrl,
                        name: product.name,
                      ),
                    ),
                  ),
                ),
              ),
              AnimatedContainer(
                duration: Duration(milliseconds: 500),
                curve: Curves.ease,
                height: MediaQuery.of(context).size.height * 0.45,
                child: Container(
                  color: Colors.transparent,
                  padding: EdgeInsets.only(top: 55),
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 15),
                    child: Text(
                      product.description,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 16,
                        letterSpacing: -0.05,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
