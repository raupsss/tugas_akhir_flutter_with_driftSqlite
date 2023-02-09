import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class Chart extends StatelessWidget {
  const Chart({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Charts"),
        actions: const [],
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
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
                    },
                    {
                      "year": 2023,
                      "sales": 100,
                    },
                    {
                      "year": 2024,
                      "sales": 10,
                    },
                    {
                      "year": 2025,
                      "sales": 40,
                    },
                  ];

                  return Container(
                    color: Theme.of(context).cardColor,
                    padding: const EdgeInsets.all(12.0),
                    child: SfCartesianChart(
                      series: <ChartSeries>[
                        // Renders line chart
                        LineSeries<Map, dynamic>(
                          dataSource: chartData,
                          xValueMapper: (Map data, _) => data["year"],
                          yValueMapper: (Map data, _) => data["sales"],
                        )
                      ],
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}


// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:d_chart/d_chart.dart';

// class Chart extends StatefulWidget {
//   Chart({super.key});

//   @override
//   State<Chart> createState() => _ChartState();
// }

// class _ChartState extends State<Chart> {
//   final streamChart = FirebaseFirestore.instance
//       .collection('invoice')
//       .orderBy('date', descending: false)
//       .snapshots(includeMetadataChanges: true);
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Container(
//         width: MediaQuery.of(context).size.width,
//         height: MediaQuery.of(context).size.height,
//         color: Color.fromARGB(255, 31, 31, 31),
//         child: Column(
//           children: [
//             Padding(
//               padding: const EdgeInsets.fromLTRB(17, 40, 0, 0),
//               child: Row(
//                 children: [
//                   IconButton(
//                     icon: const Icon(
//                       Icons.arrow_back_outlined,
//                       size: 30.0,
//                       color: Colors.white,
//                     ),
//                     tooltip: "Back",
//                     onPressed: () {
//                       Navigator.pop(context);
//                     },
//                   ),
//                   const Text(
//                     "Chart",
//                     style: TextStyle(
//                         color: Colors.white,
//                         fontSize: 20,
//                         fontWeight: FontWeight.bold),
//                   )
//                 ],
//               ),
//             ),
//             const SizedBox(
//               height: 15,
//             ),
//             const Text(
//               'Grafik Penjualan',
//               style: TextStyle(
//                   color: Colors.white,
//                   fontSize: 20,
//                   fontWeight: FontWeight.bold),
//             ),
//             Container(
//               height: 665,
//               width: MediaQuery.of(context).size.width,
//               child: ListView(
//                 // scrollDirection: Axis.horizontal,
//                 padding: const EdgeInsets.only(left: 15, right: 15),
//                 children: [
//                   StreamBuilder(
//                       stream: streamChart,
//                       builder: ((context,
//                           AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>>
//                               snapshot) {
//                         if (snapshot.hasError) {
//                           return const Text('Something wrong');
//                         }
//                         if (snapshot.data == null) {
//                           return const Text('Empsty wrong');
//                         }
//                         if (snapshot.connectionState ==
//                             ConnectionState.waiting) {
//                           return const Text('Loading');
//                         }
//                         List<Map<String, dynamic>> listChart =
//                             snapshot.data!.docs.map(
//                           (e) {
//                             String month = e.data()['date'].toString();
//                             var income = e.data()['totalHarga'];
//                             print(month.split("-"));
//                             switch (month.split("-")[1]) {
//                               case "01":
//                                 {
//                                   month = 'Januari';
//                                 }
//                                 break;
//                               case "02":
//                                 {
//                                   month = 'Februari';
//                                 }
//                                 break;
//                               case "03":
//                                 {
//                                   month = 'Maret';
//                                 }
//                                 break;
//                               case "04":
//                                 {
//                                   month = 'April';
//                                 }
//                                 break;
//                               case "05":
//                                 {
//                                   month = 'Mei';
//                                 }
//                                 break;
//                               case "06":
//                                 {
//                                   month = 'Juni';
//                                 }
//                                 break;
//                               case "07":
//                                 {
//                                   month = 'Juli';
//                                 }
//                                 break;
//                               case "08":
//                                 {
//                                   month = 'Agustus';
//                                 }
//                                 break;
//                               case "09":
//                                 {
//                                   month = 'September';
//                                 }
//                                 break;
//                               case "10":
//                                 {
//                                   month = 'Oktober';
//                                 }
//                                 break;
//                               case "11":
//                                 {
//                                   month = 'November';
//                                 }
//                                 break;
//                               case "12":
//                                 {
//                                   month = 'Desember';
//                                 }
//                                 break;
//                             }
//                             return {
//                               'domain': month,
//                               'measure': income,
//                             };
//                           },
//                         ).toList();
//                         List<String> month = [
//                           '05',
//                           '02',
//                           '03',
//                           '04',
//                           '01',
//                           '06',
//                           '07',
//                           '08',
//                           '09',
//                           '10',
//                           '11',
//                           '12',
//                         ];
//                         month.sort();
//                         print('Ascending : $month');
//                         // print(
//                         //     'Descending order (Z to A): ${myFruits.reversed}');
//                         return AspectRatio(
//                           aspectRatio: 10.5 / 20,
//                           child: DChartBar(
//                             verticalDirection: false,
//                             data: [
//                               {
//                                 'id': 'Bar',
//                                 'data': listChart,
//                               }
//                             ],
//                             animationDuration:
//                                 const Duration(milliseconds: 600),
//                             domainLabelColor: Colors.white,
//                             measureLabelColor: Colors.white,
//                             axisLineColor: Colors.white,
//                             barColor: ((barData, index, id) =>
//                                 Color(0xFFF1C950)),
//                             showBarValue: true,
//                           ),
//                         );
//                       })),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

