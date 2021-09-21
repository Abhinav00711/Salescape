import 'package:flutter/material.dart';

class HomeStatusCard extends StatelessWidget {
  const HomeStatusCard({
    Key? key,
    required this.value,
    required this.title,
  }) : super(key: key);

  final String value;
  final String title;

  @override
  Widget build(BuildContext context) {
    MediaQueryData _mediaQuery = MediaQuery.of(context);
    const double _cardBorderRadius = 20.0;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 15),
      child: Card(
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(_cardBorderRadius),
          ),
        ),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.tealAccent[400],
            borderRadius: BorderRadius.all(
              Radius.circular(_cardBorderRadius),
            ),
          ),
          width: _mediaQuery.size.width * 0.25,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Expanded(
                flex: 2,
                child: Center(
                  child: Text(
                    value,
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 30,
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: Center(
                  child: Text(
                    title,
                    style: TextStyle(
                      color: Colors.white,
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
