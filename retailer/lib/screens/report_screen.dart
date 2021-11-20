import 'package:flutter/material.dart';

import 'package:pie_chart/pie_chart.dart';

import '../data/global.dart';
import '../models/report.dart';
import '../services/firestore_service.dart';
import '../widgets/ReportScreen/report_tile.dart';

class ReportScreen extends StatelessWidget {
  const ReportScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        iconTheme: IconThemeData(color: Colors.black),
        centerTitle: true,
        title: Text(
          'REPORT',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
      body: SafeArea(
        child: FutureBuilder<Report?>(
          future: FirestoreService().getReport(Global.userData!.rid),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Center(
                child: Text(snapshot.error.toString()),
              );
            } else if (snapshot.hasData) {
              Report _report = snapshot.data!;
              return Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Card(
                      color: Colors.teal[300],
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      child: Container(
                        width: double.infinity,
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  color: const Color(0xff092E34),
                                  borderRadius: BorderRadius.circular(15.0),
                                ),
                                child: Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        Global.userData!.name,
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20,
                                          letterSpacing: 0.18,
                                        ),
                                      ),
                                    ),
                                    RichText(
                                      text: TextSpan(
                                        text: 'Total Orders : ',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18,
                                        ),
                                        children: [
                                          TextSpan(
                                            text: _report.torder,
                                            style: TextStyle(
                                              fontWeight: FontWeight.w400,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(height: 5),
                                  ],
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(15.0),
                              child: PieChart(
                                dataMap: {
                                  "Pending": _report.pending.toDouble(),
                                  "Accepted": _report.accepted.toDouble(),
                                  "Completed": _report.completed.toDouble(),
                                },
                                animationDuration: Duration(milliseconds: 800),
                                chartLegendSpacing: 32,
                                chartRadius: MediaQuery.of(context).size.width /
                                            3.2 >
                                        300
                                    ? 300
                                    : MediaQuery.of(context).size.width / 3.2,
                                colorList: [
                                  Colors.red,
                                  Colors.blue,
                                  Colors.yellow,
                                ],
                                initialAngleInDegree: 0,
                                chartType: ChartType.disc,
                                ringStrokeWidth: 32,
                                centerText: "ORDERS",
                                legendOptions: LegendOptions(
                                  showLegendsInRow: false,
                                  legendPosition: LegendPosition.right,
                                  showLegends: true,
                                  legendShape: BoxShape.circle,
                                  legendTextStyle: TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                chartValuesOptions: ChartValuesOptions(
                                  showChartValueBackground: true,
                                  showChartValues: true,
                                  showChartValuesInPercentage: false,
                                  showChartValuesOutside: false,
                                  decimalPlaces: 0,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 8),
                      child: Text(
                        'Products',
                        textAlign: TextAlign.start,
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child:
                        NotificationListener<OverscrollIndicatorNotification>(
                      onNotification: (overScroll) {
                        overScroll.disallowGlow();
                        return false;
                      },
                      child: ListView.builder(
                        itemCount: _report.prodrep.length,
                        itemBuilder: (context, index) {
                          return ReportTile(
                              productReport: _report.prodrep[index]);
                        },
                      ),
                    ),
                  ),
                ],
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
