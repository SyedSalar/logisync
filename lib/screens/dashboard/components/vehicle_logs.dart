import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:logisync/providers/providers.dart';
import 'package:provider/provider.dart';
import '../../../constants.dart';
import 'package:http/http.dart' as http;

import 'package:flutter/services.dart';

class VehicleLogs extends StatefulWidget {
  String imei;
  String from_date;
  String to_date;

  String displayName;

  VehicleLogs(
      {Key? key,
      required this.imei,
      required this.from_date,
      required this.to_date,
      required this.displayName});

  @override
  State<VehicleLogs> createState() => _VehicleLogsState();
}

class _VehicleLogsState extends State<VehicleLogs> {
  late List newData = []; // Declare newData at the class level
  late bool isLoading;
  int currentPage = 1; // Track the current page
  late ScrollController _scrollController;
  bool isPreviousButtonDisabled = false;
  bool isNextButtonDisabled = false;
  @override
  void initState() {
    super.initState();
    isLoading = true;
    _scrollController = ScrollController();
    getLogs();
  }

  getLogs() async {
    try {
      setState(() {
        isLoading = true;
        isPreviousButtonDisabled =
            true; // Disable the buttons while fetching data
        isNextButtonDisabled = true;
      });

      setState(() {});
    } catch (e) {
      print('Error fetching data: $e');
      setState(() {});
    }
  }
  // getLogs() async {
  //   try {
  //     List<UserData> fetchedData = await ApiService.fetchUserData(
  //       imeiNumber: widget.imei,
  //       fromDate: widget.from_date,
  //       toDate: widget.to_date,
  //       page: currentPage, // Pass the current page to the API request
  //     );

  //     setState(() {
  //       if (currentPage == 1) {
  //         // If it's the first page, replace the existing data
  //         newData = fetchedData;
  //       } else {
  //         // If it's not the first page, append the new data
  //         newData = [];
  //         newData = fetchedData;
  //       }
  //       isLoading = false;
  //     });
  //   } catch (e) {
  //     print('Error fetching data: $e');
  //     setState(() {
  //       isLoading = false;
  //     });
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    var themeModel = Provider.of<ThemeModel>(context, listen: false);

    return SafeArea(
      child: SingleChildScrollView(
        child: Column(children: [
          Container(
            padding: EdgeInsets.all(defaultPadding),
            decoration: BoxDecoration(
              color: themeModel.mode == ThemeMode.light
                  ? secondaryColor
                  : lightSecondaryColor,
              borderRadius: const BorderRadius.all(Radius.circular(10)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "Vehicles Status",
                  style: Theme.of(context).textTheme.subtitle1,
                ),
                Text(
                  'Name: ${widget.displayName}',
                  style: TextStyle(fontSize: 24),
                ),
                Text(
                  'IMEI: ${widget.imei}',
                  style: TextStyle(fontSize: 24),
                ),
                Align(
                  alignment: Alignment.topRight,
                  child: ElevatedButton.icon(
                    onPressed: () {},
                    label: Text('Export to CSV'),
                    icon: Icon(Icons.file_download),
                  ),
                ),
                isLoading
                    ? Center(
                        child: SizedBox(
                        child: CircularProgressIndicator(),
                      ))
                    : SizedBox(
                        width: MediaQuery.of(context).size.width,
                        height: 600,
                        child: DataTable2(
                          columnSpacing: defaultPadding,
                          isVerticalScrollBarVisible: true,
                          isHorizontalScrollBarVisible: true,
                          minWidth: 600,
                          columns: [
                            // DataColumn(
                            //   label: Text("Id"),
                            // ),
                            DataColumn(
                              label: Container(
                                padding: EdgeInsets.symmetric(
                                  vertical: 10,
                                  horizontal: 5,
                                ),
                                child: Text("Date"),
                              ),
                            ),
                            DataColumn(
                              label: Container(
                                padding: EdgeInsets.symmetric(
                                  vertical: 10,
                                  horizontal: 5,
                                ),
                                child: Text("POI"),
                              ),
                            ),
                            DataColumn(
                              label: Text("Lat,Long"),
                            ),
                            DataColumn(
                              label: Text("Speed"),
                            ),
                            DataColumn(
                              label: Text("PacketStatus"),
                            ),
                            DataColumn(
                              label: Text("ESeal Panel"),
                            ),
                            DataColumn(
                              label: Text("Chamber 1"),
                            ),
                            DataColumn(
                              label: Text("Chamber 2"),
                            ),
                            DataColumn(
                              label: Text("Chamber 3"),
                            ),
                            DataColumn(
                              label: Text("Chamber 4"),
                            ),
                            DataColumn(
                              label: Text("Chamber 5"),
                            ),
                            DataColumn(
                              label: Text("Power"),
                            ),
                          ],
                          rows: List.generate(
                            newData.length,
                            (index) => recentFileDataRow(newData[index]),
                          ),
                        ),
                      ),
                SizedBox(
                  height: defaultPadding,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton.icon(
                      onPressed: isPreviousButtonDisabled
                          ? null
                          : currentPage > 1
                              ? () {
                                  // Load the previous page when the button is pressed
                                  currentPage--;
                                  getLogs();
                                }
                              : null,
                      label: Text('Previous Page'),
                      icon: Icon(Icons.navigate_before),
                    ),
                    SizedBox(width: defaultPadding),
                    Text('$currentPage'),
                    SizedBox(
                      width: defaultPadding,
                    ),
                    ElevatedButton.icon(
                      onPressed: isNextButtonDisabled
                          ? null
                          : () {
                              // Load the next page when the button is pressed
                              currentPage++;
                              getLogs();
                            },
                      label: Text('Next Page'),
                      icon: Icon(Icons.navigate_next),
                    ),
                  ],
                ),
              ],
            ),
          )
        ]),
      ),
    );
  }
}

DataRow recentFileDataRow(fileInfo) {
  List eachStatus = fileInfo.statuses.split(' ');

  return DataRow(
    cells: [
      // DataCell(
      //   Row(
      //     children: [
      //       SvgPicture.asset(
      //         fileInfo.icon!,
      //         height: 30,
      //         width: 30,
      //       ),
      //       Padding(
      //         padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
      //         child: Text(fileInfo.id.toString()!),
      //       ),
      //     ],
      //   ),
      // ),
      // DataCell(Text('${fileInfo.id}')),
      DataCell(Text(fileInfo.formattedTime + ' ' + fileInfo.date!)),
      DataCell(
        FutureBuilder<String>(
          future: getAddressFromLatLng(fileInfo.latitude, fileInfo.longitude),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Text('Loading...'); // or some other loading indicator
            } else if (snapshot.hasError) {
              print('Error: ${snapshot.error}');
              return Text('Error: ${snapshot.error}');
            } else {
              return Text(snapshot.data ??
                  ''); // display the address or an empty string
            }
          },
        ),
      ),
      DataCell(
        Text(
            '${fileInfo.latitude.toStringAsFixed(3)}, ${fileInfo.longitude.toStringAsFixed(3)}'),
      ),
      DataCell(Text('${fileInfo.speed}')),
      DataCell(Text('${fileInfo.packetStatus}')),
      DataCell(Text(eachStatus[0] ?? '')),
      DataCell(Text(eachStatus[1] ?? '')),
      DataCell(Text(eachStatus[2] ?? '')),
      DataCell(Text(eachStatus[3] ?? '')),
      DataCell(Text(eachStatus[4] ?? '')),
      DataCell(Text(eachStatus[5] ?? '')),
      DataCell(Text(eachStatus[6] ?? '')),
    ],
  );
}

Future<String> getAddress(double lat, double lng) async {
  if (lat != 0 || lng != 0) {
    final url =
        'https://nominatim.openstreetmap.org/reverse?format=json&lat=$lat&lon=$lng';

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final decoded = json.decode(response.body);
      return decoded['display_name'];
    } else {
      throw Exception('Failed to fetch address');
    }
  } else
    return 'Unknown Area';
}

Future<String> getAddressFromLatLng(double lat, double lng) async {
  String address;

  try {
    address = await getAddress(lat, lng);
    print('address $address');
  } catch (e) {
    address = ('Error: $e');
  }

  return address;
}
