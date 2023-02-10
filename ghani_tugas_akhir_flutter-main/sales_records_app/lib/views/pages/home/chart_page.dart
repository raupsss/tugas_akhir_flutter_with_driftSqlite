// ignore_for_file: unused_local_variable

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sales_records_app/models/order_stats_model.dart';
// import 'package:charts_flutter/charts_flutter.dart'
//     as charts;
import 'package:charts_flutter_new/flutter.dart' as charts;
import 'package:sales_records_app/view_model/database_controller.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
// import 'package:d_chart/d_chart.dart';
// import

class Chart extends StatelessWidget {
  Chart({Key? key, required this.orderStats}) : super(key: key);

  final List<OrderStats> orderStats;

  final OrderStatsController orderStatsController =
      Get.put(OrderStatsController());
  @override
  Widget build(BuildContext context) {
    List<charts.Series<OrderStats, String>> series = [
      charts.Series(
        id: 'orders',
        data: orderStats,
        domainFn: (series, _) => series.index.toString(),
        measureFn: (series, _) => series.orders,
        colorFn: (series, _) => series.barColor!,
      )
    ];

    final streamChart = FirebaseFirestore.instance
        .collection('transaction_chart')
        .orderBy('date', descending: false)
        .snapshots(includeMetadataChanges: true);

    return Scaffold(
      body: SafeArea(
        child: ListView(children: [
          Builder(
            builder: (context) {
              final List<Map> chartData = [
                {
                  "year": 2018,
                  "sales": 40,
                },
                {
                  "year": 2019,
                  "sales": 90,
                },
                {
                  "year": 2020,
                  "sales": 30,
                },
                {
                  "year": 2021,
                  "sales": 80,
                },
                {
                  "year": 2022,
                  "sales": 90,
                }
              ];

              return Container(
                color: Theme.of(context).cardColor,
                padding: const EdgeInsets.all(12.0),
                child: SfCartesianChart(
                  series: <ChartSeries>[
                    // Renders line chart
                    LineSeries<Map, int>(
                      dataSource: chartData,
                      xValueMapper: (Map data, _) => data["year"],
                      yValueMapper: (Map data, _) => data["sales"],
                    )
                  ],
                ),
              );
            },
          ),
          Builder(
            builder: (context) {
              final List<Map> chartData = [
                {
                  "year": 2018,
                  "sales": 40,
                },
                {
                  "year": 2019,
                  "sales": 90,
                },
                {
                  "year": 2020,
                  "sales": 30,
                },
                {
                  "year": 2021,
                  "sales": 80,
                },
                {
                  "year": 2022,
                  "sales": 90,
                }
              ];

              return Container(
                color: Theme.of(context).cardColor,
                padding: const EdgeInsets.all(12.0),
                child: SfCartesianChart(
                  series: <ChartSeries>[
                    AreaSeries<Map, int>(
                      dataSource: chartData,
                      xValueMapper: (Map data, _) => data["year"],
                      yValueMapper: (Map data, _) => data["sales"],
                    )
                  ],
                ),
              );
            },
          ),
          Builder(
            builder: (context) {
              final List<Map> chartData = [
                {
                  "year": 2018,
                  "sales": 40,
                },
                {
                  "year": 2019,
                  "sales": 90,
                },
                {
                  "year": 2020,
                  "sales": 30,
                },
                {
                  "year": 2021,
                  "sales": 80,
                },
                {
                  "year": 2022,
                  "sales": 90,
                }
              ];

              return Container(
                color: Theme.of(context).cardColor,
                padding: const EdgeInsets.all(12.0),
                child: SfCartesianChart(
                  series: <ChartSeries>[
                    BarSeries<Map, int>(
                      dataSource: chartData,
                      xValueMapper: (Map data, _) => data["year"],
                      yValueMapper: (Map data, _) => data["sales"],
                    )
                  ],
                ),
              );
            },
          ),
          Builder(
            builder: (context) {
              final List<Map> chartData = [
                {
                  "year": 2018,
                  "sales": 40,
                },
                {
                  "year": 2019,
                  "sales": 90,
                },
                {
                  "year": 2020,
                  "sales": 30,
                },
                {
                  "year": 2021,
                  "sales": 80,
                },
                {
                  "year": 2022,
                  "sales": 90,
                }
              ];

              return Container(
                color: Theme.of(context).cardColor,
                padding: const EdgeInsets.all(12.0),
                child: SfCartesianChart(
                  isTransposed: true,
                  primaryXAxis: NumericAxis(
                    decimalPlaces: 0,
                  ),
                  series: <ChartSeries>[
                    BarSeries<Map, int>(
                      dataSource: chartData,
                      xValueMapper: (Map data, _) => data["year"],
                      yValueMapper: (Map data, _) => data["sales"],
                    )
                  ],
                ),
              );
            },
          ),
          Builder(
            builder: (context) {
              final List<Map> chartData = [
                {
                  "year": 2018,
                  "sales": 40,
                },
                {
                  "year": 2019,
                  "sales": 90,
                },
                {
                  "year": 2020,
                  "sales": 30,
                },
                {
                  "year": 2021,
                  "sales": 80,
                },
                {
                  "year": 2022,
                  "sales": 90,
                }
              ];

              return Container(
                color: Theme.of(context).cardColor,
                padding: const EdgeInsets.all(12.0),
                child: SfCartesianChart(
                  series: <ChartSeries>[
                    ScatterSeries<Map, int>(
                      dataSource: chartData,
                      xValueMapper: (Map data, _) => data["year"],
                      yValueMapper: (Map data, _) => data["sales"],
                    )
                  ],
                ),
              );
            },
          ),
          Builder(
            builder: (context) {
              final List<Map> chartData = [
                {
                  "year": 2018,
                  "sales": 40,
                },
                {
                  "year": 2019,
                  "sales": 90,
                },
                {
                  "year": 2020,
                  "sales": 30,
                },
                {
                  "year": 2021,
                  "sales": 80,
                },
                {
                  "year": 2022,
                  "sales": 90,
                }
              ];

              return Container(
                color: Theme.of(context).cardColor,
                padding: const EdgeInsets.all(12.0),
                child: SfCartesianChart(
                  series: <ChartSeries>[
                    StepLineSeries<Map, int>(
                      dataSource: chartData,
                      xValueMapper: (Map data, _) => data["year"],
                      yValueMapper: (Map data, _) => data["sales"],
                    )
                  ],
                ),
              );
            },
          ),
        ]),
        // child: FutureBuilder(
        //   future: orderStatsController.stats.value,
        //   builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        //     if (snapshot.hasData) {
        //       return ListView(
        //         children: [
        //           Container(
        //             height: 250,
        //             padding: const EdgeInsets.all(16),
        //             child: charts.BarChart(
        //               series,
        //               animate: true,
        //             ),
        //           ),
        //           SizedBox(
        //             height: 20,
        //           ),
        //           Builder(
        //             builder: (context) {
        //               final List<Map> chartData = [
        //                 {
        //                   "year": 2018,
        //                   "sales": 40,
        //                 },
        //                 {
        //                   "year": 2019,
        //                   "sales": 90,
        //                 },
        //                 {
        //                   "year": 2020,
        //                   "sales": 30,
        //                 },
        //                 {
        //                   "year": 2021,
        //                   "sales": 80,
        //                 },
        //                 {
        //                   "year": 2022,
        //                   "sales": 90,
        //                 }
        //               ];

        //               return Container(
        //                 color: Theme.of(context).cardColor,
        //                 padding: const EdgeInsets.all(12.0),
        //                 child: SfCartesianChart(
        //                   series: <ChartSeries>[
        //                     // Renders line chart
        //                     LineSeries<Map, int>(
        //                       dataSource: chartData,
        //                       xValueMapper: (Map data, _) => data["year"],
        //                       yValueMapper: (Map data, _) => data["sales"],
        //                     )
        //                   ],
        //                 ),
        //               );
        //             },
        //           ),
        //           Builder(
        //             builder: (context) {
        //               final List<Map> chartData = [
        //                 {
        //                   "year": 2018,
        //                   "sales": 40,
        //                 },
        //                 {
        //                   "year": 2019,
        //                   "sales": 90,
        //                 },
        //                 {
        //                   "year": 2020,
        //                   "sales": 30,
        //                 },
        //                 {
        //                   "year": 2021,
        //                   "sales": 80,
        //                 },
        //                 {
        //                   "year": 2022,
        //                   "sales": 90,
        //                 }
        //               ];

        //               return Container(
        //                 color: Theme.of(context).cardColor,
        //                 padding: const EdgeInsets.all(12.0),
        //                 child: SfCartesianChart(
        //                   series: <ChartSeries>[
        //                     AreaSeries<Map, int>(
        //                       dataSource: chartData,
        //                       xValueMapper: (Map data, _) => data["year"],
        //                       yValueMapper: (Map data, _) => data["sales"],
        //                     )
        //                   ],
        //                 ),
        //               );
        //             },
        //           ),
        //           Builder(
        //             builder: (context) {
        //               final List<Map> chartData = [
        //                 {
        //                   "year": 2018,
        //                   "sales": 40,
        //                 },
        //                 {
        //                   "year": 2019,
        //                   "sales": 90,
        //                 },
        //                 {
        //                   "year": 2020,
        //                   "sales": 30,
        //                 },
        //                 {
        //                   "year": 2021,
        //                   "sales": 80,
        //                 },
        //                 {
        //                   "year": 2022,
        //                   "sales": 90,
        //                 }
        //               ];

        //               return Container(
        //                 color: Theme.of(context).cardColor,
        //                 padding: const EdgeInsets.all(12.0),
        //                 child: SfCartesianChart(
        //                   series: <ChartSeries>[
        //                     BarSeries<Map, int>(
        //                       dataSource: chartData,
        //                       xValueMapper: (Map data, _) => data["year"],
        //                       yValueMapper: (Map data, _) => data["sales"],
        //                     )
        //                   ],
        //                 ),
        //               );
        //             },
        //           ),
        //           Builder(
        //             builder: (context) {
        //               final List<Map> chartData = [
        //                 {
        //                   "year": 2018,
        //                   "sales": 40,
        //                 },
        //                 {
        //                   "year": 2019,
        //                   "sales": 90,
        //                 },
        //                 {
        //                   "year": 2020,
        //                   "sales": 30,
        //                 },
        //                 {
        //                   "year": 2021,
        //                   "sales": 80,
        //                 },
        //                 {
        //                   "year": 2022,
        //                   "sales": 90,
        //                 }
        //               ];

        //               return Container(
        //                 color: Theme.of(context).cardColor,
        //                 padding: const EdgeInsets.all(12.0),
        //                 child: SfCartesianChart(
        //                   isTransposed: true,
        //                   primaryXAxis: NumericAxis(
        //                     decimalPlaces: 0,
        //                   ),
        //                   series: <ChartSeries>[
        //                     BarSeries<Map, int>(
        //                       dataSource: chartData,
        //                       xValueMapper: (Map data, _) => data["year"],
        //                       yValueMapper: (Map data, _) => data["sales"],
        //                     )
        //                   ],
        //                 ),
        //               );
        //             },
        //           ),
        //           Builder(
        //             builder: (context) {
        //               final List<Map> chartData = [
        //                 {
        //                   "year": 2018,
        //                   "sales": 40,
        //                 },
        //                 {
        //                   "year": 2019,
        //                   "sales": 90,
        //                 },
        //                 {
        //                   "year": 2020,
        //                   "sales": 30,
        //                 },
        //                 {
        //                   "year": 2021,
        //                   "sales": 80,
        //                 },
        //                 {
        //                   "year": 2022,
        //                   "sales": 90,
        //                 }
        //               ];

        //               return Container(
        //                 color: Theme.of(context).cardColor,
        //                 padding: const EdgeInsets.all(12.0),
        //                 child: SfCartesianChart(
        //                   series: <ChartSeries>[
        //                     BubbleSeries<Map, int>(
        //                       dataSource: chartData,
        //                       xValueMapper: (Map data, _) => data["year"],
        //                       yValueMapper: (Map data, _) => data["sales"],
        //                     )
        //                   ],
        //                 ),
        //               );
        //             },
        //           ),
        //           SizedBox(
        //             height: 50,
        //           ),
        //           // StreamBuilder(
        //           //   stream: streamChart,
        //           //   builder: ((context,
        //           //       AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>>
        //           //           snapshot) {
        //           //     if (snapshot.hasError) {
        //           //       return const Text('Something wrong');
        //           //     }
        //           //     if (snapshot.data == null) {
        //           //       return const Text('Empsty wrong');
        //           //     }
        //           //     if (snapshot.connectionState == ConnectionState.waiting) {
        //           //       return const Text('Loading');
        //           //     }
        //           //     List<Map<String, dynamic>> listChart =
        //           //         snapshot.data!.docs.map(
        //           //       (e) {
        //           //         String month = e.data()['date'].toString();
        //           //         var income = e.data()['total_income'];
        //           //         print(month.split("-"));
        //           //         switch (month.split("-")[1]) {
        //           //           case "01":
        //           //             {
        //           //               month = 'Januari';
        //           //             }
        //           //             break;
        //           //           case "02":
        //           //             {
        //           //               month = 'Februari';
        //           //             }
        //           //             break;
        //           //           case "03":
        //           //             {
        //           //               month = 'Maret';
        //           //             }
        //           //             break;
        //           //           case "04":
        //           //             {
        //           //               month = 'April';
        //           //             }
        //           //             break;
        //           //           case "05":
        //           //             {
        //           //               month = 'Mei';
        //           //             }
        //           //             break;
        //           //           case "06":
        //           //             {
        //           //               month = 'Juni';
        //           //             }
        //           //             break;
        //           //           case "07":
        //           //             {
        //           //               month = 'Juli';
        //           //             }
        //           //             break;
        //           //           case "08":
        //           //             {
        //           //               month = 'Agustus';
        //           //             }
        //           //             break;
        //           //           case "09":
        //           //             {
        //           //               month = 'September';
        //           //             }
        //           //             break;
        //           //           case "10":
        //           //             {
        //           //               month = 'Oktober';
        //           //             }
        //           //             break;
        //           //           case "11":
        //           //             {
        //           //               month = 'November';
        //           //             }
        //           //             break;
        //           //           case "12":
        //           //             {
        //           //               month = 'Desember';
        //           //             }
        //           //             break;
        //           //         }
        //           //         return {
        //           //           'domain': month,
        //           //           'measure': income,
        //           //         };
        //           //       },
        //           //     ).toList();
        //           //     List<String> month = [
        //           //       '05',
        //           //       '02',
        //           //       '03',
        //           //       '04',
        //           //       '01',
        //           //       '06',
        //           //       '07',
        //           //       '08',
        //           //       '09',
        //           //       '10',
        //           //       '11',
        //           //       '12',
        //           //     ];
        //           //     month.sort();
        //           //     print('Ascending : $month');
        //           //     // print(
        //           //     //     'Descending order (Z to A): ${myFruits.reversed}');
        //           //     return AspectRatio(
        //           //       aspectRatio: 10.5 / 20,
        //           //       child: DChartBar(
        //           //         verticalDirection: false,
        //           //         data: [
        //           //           {
        //           //             'id': 'Bar',
        //           //             'data': listChart,
        //           //           }
        //           //         ],
        //           //         animationDuration: const Duration(milliseconds: 600),
        //           //         domainLabelColor: Colors.white,
        //           //         measureLabelColor: Colors.white,
        //           //         axisLineColor: Colors.white,
        //           //         barColor: ((barData, index, id) => Color(0xFFF1C950)),
        //           //         showBarValue: true,
        //           //       ),
        //           //     );
        //           //   }),
        //           // ),
        //         ],
        //       );
        //     } else {
        //       return Center(
        //         child: CircularProgressIndicator(),
        //       );
        //     }
        //   },
        // ),
      ),
    );
  }
}
