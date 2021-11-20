import 'package:flutter/material.dart';

import '../../models/report.dart';

class ReportTile extends StatelessWidget {
  const ReportTile({Key? key, required this.productReport}) : super(key: key);

  final ProductReport productReport;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Theme.of(context).accentColor,
      margin: EdgeInsets.all(15.0),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: [
          Expanded(
            flex: 8,
            child: Container(
              padding: EdgeInsets.all(8.0),
              child: Text(
                productReport.name,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  letterSpacing: 0.18,
                  color: const Color(0xff092E34),
                ),
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Container(
              alignment: Alignment.bottomCenter,
              padding: EdgeInsets.all(8.0),
              child: Text(
                productReport.qty.toString(),
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
