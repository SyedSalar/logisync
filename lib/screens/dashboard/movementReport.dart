// import 'dart:async';

// import 'package:admin/api/get_data.dart';
// import 'package:admin/constants.dart';
// import 'package:pluto_grid/pluto_grid.dart';
// import 'package:flutter/material.dart';

// class MyMovementReport extends StatefulWidget {
//   String imei;
//   String from_date;
//   String to_date;

//   MyMovementReport(
//       {super.key,
//       required this.imei,
//       required this.from_date,
//       required this.to_date});

//   @override
//   State<MyMovementReport> createState() => _MyMovementReportState();
// }

// class _MyMovementReportState extends State<MyMovementReport> {
//   List<PlutoRow> rows = [];
//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     getData().then((fetchedRows) {
//       /// When there are many rows and the UI freezes when the grid is loaded
//       /// Initialize the rows asynchronously through the initializeRowsAsync method
//       /// Add rows to stateManager.refRows.
//       /// And disable the loading screen.
//       PlutoGridStateManager.initializeRowsAsync(
//         columns,
//         fetchedRows,
//       ).then((value) {
//         stateManager.refRows.addAll(value);

//         /// In this example,
//         /// the loading screen is activated in the onLoaded callback when the grid is created.
//         /// If the loading screen is not activated
//         /// You must update the grid state by calling the stateManager.notifyListeners() method.
//         /// Because calling setShowLoading updates the grid state
//         /// No need to call stateManager.notifyListeners.
//         stateManager.setShowLoading(false);
//       });
//     });
//     getData();
//   }

//   Future<List<PlutoRow>> getData() async {
//     final Completer<List<PlutoRow>> completer = Completer();

//     List<PlutoRow> _rows = [];

//     setState(() {});
//     var newData = await ApiService.fetchUserData(
//         imeiNumber: widget.imei,
//         fromDate: widget.from_date,
//         toDate: widget.to_date);
//     // print(newData);

//     _rows = newData.map((e) => mapToPlutoRow(e)).toList();
//     Timer(Duration(seconds: 1), () {
//       completer.complete(_rows);
//     });

//     return completer.future;
//   }

//   static PlutoRow mapToPlutoRow(Map<String, dynamic> item) {
//     return PlutoRow(
//       cells: {
//         'id': PlutoCell(value: item['id'].toString()),
//         'imei': PlutoCell(value: item['imei'].toString()),
//         'lat_long':
//             PlutoCell(value: '${item['latitude']},${item['longitude']}'),
//         'speed': PlutoCell(value: item['speed'].toString()),
//         'status': PlutoCell(value: item['statuses'].toString()),
//         'date': PlutoCell(value: item['date'].toString()),
//         'time': PlutoCell(value: item['time'].toString()),
//         'packetStatus': PlutoCell(value: item['packetStatus'].toString()),
//       },
//     );
//   }

//   final List<PlutoColumn> columns = <PlutoColumn>[
//     PlutoColumn(
//       title: 'Id',
//       field: 'id',
//       backgroundColor: bgColor,
//       width: 100,
//       type: PlutoColumnType.text(),
//     ),
//     PlutoColumn(
//       title: 'Imei Number',
//       field: 'imei',
//       backgroundColor: bgColor,
//       type: PlutoColumnType.text(),
//     ),
//     PlutoColumn(
//       title: 'Lat,Long',
//       field: 'lat_long',
//       backgroundColor: bgColor,
//       type: PlutoColumnType.number(),
//     ),
//     PlutoColumn(
//         title: 'Speed',
//         field: 'speed',
//         backgroundColor: bgColor,
//         type: PlutoColumnType.number()),
//     PlutoColumn(
//       title: 'Statuses',
//       field: 'status',
//       type: PlutoColumnType.text(),
//       backgroundColor: bgColor,
//     ),
//     PlutoColumn(
//       title: 'Data Type',
//       field: 'packetStatus',
//       type: PlutoColumnType.text(),
//       backgroundColor: bgColor,
//     ),
//     PlutoColumn(
//       title: 'Date',
//       field: 'date',
//       type: PlutoColumnType.text(),
//       backgroundColor: bgColor,
//     ),
//     PlutoColumn(
//       title: 'Time',
//       field: 'time',
//       type: PlutoColumnType.text(),
//       backgroundColor: bgColor,
//     ),
//   ];

//   // final List<PlutoRow> rows = [
//   //   PlutoRow(
//   //     cells: {
//   //       'id': PlutoCell(value: 'user1'),
//   //       'name': PlutoCell(value: 'Mike'),
//   //       'age': PlutoCell(value: 20),
//   //       'role': PlutoCell(value: 'Programmer'),
//   //       'joined': PlutoCell(value: '2021-01-01'),
//   //       'working_time': PlutoCell(value: '09:00'),
//   //       'salary': PlutoCell(value: 300),
//   //     },
//   //   ),
//   //   PlutoRow(
//   //     cells: {
//   //       'id': PlutoCell(value: 'user2'),
//   //       'name': PlutoCell(value: 'Jack'),
//   //       'age': PlutoCell(value: 25),
//   //       'role': PlutoCell(value: 'Designer'),
//   //       'joined': PlutoCell(value: '2021-02-01'),
//   //       'working_time': PlutoCell(value: '10:00'),
//   //       'salary': PlutoCell(value: 400),
//   //     },
//   //   ),
//   //   PlutoRow(
//   //     cells: {
//   //       'id': PlutoCell(value: 'user2'),
//   //       'name': PlutoCell(value: 'Jack'),
//   //       'age': PlutoCell(value: 25),
//   //       'role': PlutoCell(value: 'Designer'),
//   //       'joined': PlutoCell(value: '2021-02-01'),
//   //       'working_time': PlutoCell(value: '10:00'),
//   //       'salary': PlutoCell(value: 400),
//   //     },
//   //   ),
//   //   PlutoRow(
//   //     cells: {
//   //       'id': PlutoCell(value: 'user2'),
//   //       'name': PlutoCell(value: 'Jack'),
//   //       'age': PlutoCell(value: 25),
//   //       'role': PlutoCell(value: 'Designer'),
//   //       'joined': PlutoCell(value: '2021-02-01'),
//   //       'working_time': PlutoCell(value: '10:00'),
//   //       'salary': PlutoCell(value: 400),
//   //     },
//   //   ),
//   //   PlutoRow(
//   //     cells: {
//   //       'id': PlutoCell(value: 'user2'),
//   //       'name': PlutoCell(value: 'Jack'),
//   //       'age': PlutoCell(value: 25),
//   //       'role': PlutoCell(value: 'Designer'),
//   //       'joined': PlutoCell(value: '2021-02-01'),
//   //       'working_time': PlutoCell(value: '10:00'),
//   //       'salary': PlutoCell(value: 400),
//   //     },
//   //   ),
//   //   PlutoRow(
//   //     cells: {
//   //       'id': PlutoCell(value: 'user2'),
//   //       'name': PlutoCell(value: 'Jack'),
//   //       'age': PlutoCell(value: 25),
//   //       'role': PlutoCell(value: 'Designer'),
//   //       'joined': PlutoCell(value: '2021-02-01'),
//   //       'working_time': PlutoCell(value: '10:00'),
//   //       'salary': PlutoCell(value: 400),
//   //     },
//   //   ),
//   //   PlutoRow(
//   //     cells: {
//   //       'id': PlutoCell(value: 'user2'),
//   //       'name': PlutoCell(value: 'Jack'),
//   //       'age': PlutoCell(value: 25),
//   //       'role': PlutoCell(value: 'Designer'),
//   //       'joined': PlutoCell(value: '2021-02-01'),
//   //       'working_time': PlutoCell(value: '10:00'),
//   //       'salary': PlutoCell(value: 400),
//   //     },
//   //   ),
//   //   PlutoRow(
//   //     cells: {
//   //       'id': PlutoCell(value: 'user2'),
//   //       'name': PlutoCell(value: 'Jack'),
//   //       'age': PlutoCell(value: 25),
//   //       'role': PlutoCell(value: 'Designer'),
//   //       'joined': PlutoCell(value: '2021-02-01'),
//   //       'working_time': PlutoCell(value: '10:00'),
//   //       'salary': PlutoCell(value: 400),
//   //     },
//   //   ),
//   //   PlutoRow(
//   //     cells: {
//   //       'id': PlutoCell(value: 'user2'),
//   //       'name': PlutoCell(value: 'Jack'),
//   //       'age': PlutoCell(value: 25),
//   //       'role': PlutoCell(value: 'Designer'),
//   //       'joined': PlutoCell(value: '2021-02-01'),
//   //       'working_time': PlutoCell(value: '10:00'),
//   //       'salary': PlutoCell(value: 400),
//   //     },
//   //   ),
//   //   PlutoRow(
//   //     cells: {
//   //       'id': PlutoCell(value: 'user2'),
//   //       'name': PlutoCell(value: 'Jack'),
//   //       'age': PlutoCell(value: 25),
//   //       'role': PlutoCell(value: 'Designer'),
//   //       'joined': PlutoCell(value: '2021-02-01'),
//   //       'working_time': PlutoCell(value: '10:00'),
//   //       'salary': PlutoCell(value: 400),
//   //     },
//   //   ),

//   // ];

//   /// columnGroups that can group columns can be omitted.
//   // final List<PlutoColumnGroup> columnGroups = [
//   //   PlutoColumnGroup(
//   //     title: 'Id',
//   //     fields: ['id'],
//   //     expandedColumn: true,
//   //     backgroundColor: bgColor,
//   //   ),
//   //   PlutoColumnGroup(
//   //     title: 'User information',
//   //     fields: ['name', 'age'],
//   //     backgroundColor: bgColor,
//   //   ),
//   //   PlutoColumnGroup(title: 'Status', backgroundColor: bgColor, children: [
//   //     PlutoColumnGroup(
//   //       title: 'A',
//   //       fields: ['role'],
//   //       expandedColumn: true,
//   //       backgroundColor: bgColor,
//   //     ),
//   //     PlutoColumnGroup(
//   //       title: 'Etc.',
//   //       fields: ['joined', 'working_time'],
//   //       backgroundColor: bgColor,
//   //     ),
//   //   ]),
//   // ];

//   /// [PlutoGridStateManager] has many methods and properties to dynamically manipulate the grid.
//   /// You can manipulate the grid dynamically at runtime by passing this through the [onLoaded] callback.
//   late final PlutoGridStateManager stateManager;
//   int rowIndexCounter = 0;

//   @override
//   Widget build(BuildContext context) {
//     final screenSize = MediaQuery.of(context).size;
//     final screenHeight = screenSize.height;
//     final screenWidth = screenSize.width;
//     // TODO: implement build
//     return Scaffold(
//       body: SingleChildScrollView(
//         child: Column(
//           children: [
//             SizedBox(
//               height: 10,
//             ),
//             Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: Container(
//                 width: screenWidth,
//                 height: 600,
//                 child: Stack(
//                   alignment: Alignment.center,
//                   children: [
//                     // Container(
//                     //   color: bgColor,
//                     //   height: 100,
//                     // ),
//                     // Padding(
//                     //   padding: const EdgeInsets.all(50.0),
//                     //   child: Container(
//                     //       decoration: BoxDecoration(
//                     //           borderRadius: BorderRadius.circular(8),
//                     //           boxShadow: [
//                     //             BoxShadow(
//                     //               color: Colors.grey.withOpacity(0.5),
//                     //               spreadRadius: 2,
//                     //               blurRadius: 5,
//                     //               offset: Offset(0, 3),
//                     //             ),
//                     //           ]),
//                     //       child: ClusteringManyMarkersPage()),
//                     // ),
//                     Positioned(
//                         bottom: 20,
//                         child: Container(
//                           alignment: Alignment.center,
//                           height: 150,
//                           width: 500,
//                           decoration: BoxDecoration(
//                               borderRadius: BorderRadius.circular(8),
//                               color: bgColor),
//                           child: Column(
//                             crossAxisAlignment: CrossAxisAlignment.center,
//                             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                             children: [
//                               Text(
//                                 'MOVEMENT REPORT',
//                                 style: TextStyle(
//                                     fontWeight: FontWeight.bold,
//                                     fontSize: 20,
//                                     color: Colors.white,
//                                     fontStyle: FontStyle.italic),
//                                 textAlign: TextAlign.left,
//                               ),
//                               Center(
//                                 child: Row(
//                                   crossAxisAlignment: CrossAxisAlignment.center,
//                                   mainAxisAlignment: MainAxisAlignment.center,
//                                   children: [
//                                     Spacer(),
//                                     Column(
//                                       crossAxisAlignment:
//                                           CrossAxisAlignment.center,
//                                       mainAxisAlignment:
//                                           MainAxisAlignment.center,
//                                       children: [
//                                         Text(
//                                           'Vehicle Number',
//                                           textAlign: TextAlign.left,
//                                         ),
//                                         Text(
//                                           'JZ-4079',
//                                           style: TextStyle(
//                                               fontWeight: FontWeight.bold,
//                                               color: Colors.white,
//                                               fontSize: 18),
//                                           textAlign: TextAlign.left,
//                                         )
//                                       ],
//                                     ),
//                                     Spacer(),
//                                     Column(
//                                       crossAxisAlignment:
//                                           CrossAxisAlignment.center,
//                                       mainAxisAlignment:
//                                           MainAxisAlignment.center,
//                                       children: [
//                                         Text(
//                                           'Last Active',
//                                           textAlign: TextAlign.left,
//                                         ),
//                                         Text(
//                                           'Date and Time',
//                                           textAlign: TextAlign.left,
//                                           style: TextStyle(
//                                               fontWeight: FontWeight.bold,
//                                               color: Colors.white,
//                                               fontSize: 18),
//                                         )
//                                       ],
//                                     ),
//                                     Spacer(),
//                                     Column(
//                                       crossAxisAlignment:
//                                           CrossAxisAlignment.center,
//                                       mainAxisAlignment:
//                                           MainAxisAlignment.center,
//                                       children: [
//                                         Text(
//                                           'Lat,Long',
//                                           textAlign: TextAlign.left,
//                                         ),
//                                         Text(
//                                           'Lat-Long',
//                                           textAlign: TextAlign.left,
//                                           style: TextStyle(
//                                               fontWeight: FontWeight.bold,
//                                               color: Colors.white,
//                                               fontSize: 18),
//                                         )
//                                       ],
//                                     ),
//                                     Spacer(),
//                                   ],
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ))
//                   ],
//                 ),
//               ),
//             ),
//             SizedBox(
//               height: 1000,
//               child: PlutoGrid(
//                 columns: columns,
//                 rows: rows,
//                 // columnGroups: columnGroups,
//                 onLoaded: (PlutoGridOnLoadedEvent event) {
//                   stateManager = event.stateManager;
//                   stateManager.setShowColumnFilter(true);
//                   stateManager.setShowLoading(true);
//                 },
//                 onChanged: (PlutoGridOnChangedEvent event) {
//                   print(event);
//                 },
//                 configuration: const PlutoGridConfiguration.dark(),
//                 rowColorCallback: (rowColorContext) {
//                   rowIndexCounter++;
//                   if (rowIndexCounter.isOdd) {
//                     return const Color.fromRGBO(232, 245, 233,
//                         1); // Change to the color you want for odd rows
//                   } else
//                     return secondaryColor;
//                 },
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
