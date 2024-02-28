import 'package:flutter/material.dart';
import 'package:logisync/providers/providers.dart';
import 'package:logisync/responsive.dart';
import 'package:logisync/screens/dashboard/components/my_fields.dart';
import 'package:provider/provider.dart';
import '../../constants.dart';
import '../../models/MyFiles.dart';
import '../../models/logs_data.dart';
import 'components/header.dart';

import 'components/recent_files.dart';
import 'components/storage_details.dart';

class DashboardScreen extends StatefulWidget {
  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  late List<CombinedModel> newData = [];
  late List hauliers = [];
  late int violations = 0;
  late List<CloudStorageInfo> demoMyFiles = [];

  @override
  void initState() {
    super.initState();
    getLogs();
    _scheduleUpdates();
  }

  _scheduleUpdates() {
    Future.delayed(Duration(minutes: 1), () {
      if (mounted) {
        getLogs();
        _scheduleUpdates();
      }
    });
  }

  getLogs() async {
    try {
      setState(() {
        updateDemoMyFiles();
      });
    } catch (e) {
      print('Error fetching data: $e');
      setState(() {});
    }
  }

  void updateDemoMyFiles() {
    demoMyFiles = [
      CloudStorageInfo(
        title: "Violations",
        numOfFiles: 2,
        svgSrc: "assets/icons/report.svg",
        totalStorage: "1.9GB",
        color: Colors.red,
        percentage: 35,
      ),
      CloudStorageInfo(
        title: "Completed Rides",
        numOfFiles: 12,
        svgSrc: "assets/icons/truck.svg",
        totalStorage: "2.9GB",
        color: Color.fromARGB(255, 19, 255, 27),
        percentage: 35,
      ),
      CloudStorageInfo(
        title: "Cash Earned",
        numOfFiles: 10000,
        svgSrc: "assets/icons/menu_profile.svg",
        totalStorage: "10",
        color: Color(0xFFA4CDFF),
        percentage: 80,
      ),
      CloudStorageInfo(
        title: "Rating",
        numOfFiles: 5,
        svgSrc: "assets/icons/truck.svg",
        totalStorage: "200",
        color: Color(0xFF007EE5),
        percentage: 60,
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    var themeModel = Provider.of<ThemeModel>(context, listen: false);

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Access the ThemeModel using Provider

          // Toggle the theme mode
          print(themeModel.mode);
          themeModel.toggleMode();
        },
        child: Icon(Icons.color_lens), // Add an icon for the theme change
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          primary: false,
          padding: EdgeInsets.all(defaultPadding),
          child: Column(
            children: [
              Header(),
              SizedBox(height: defaultPadding),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 5,
                    child: Column(
                      children: [
                        MyFiles(demoMyFiles: demoMyFiles),
                        SizedBox(height: defaultPadding),
                        RecentFiles(),
                        if (Responsive.isMobile(context))
                          SizedBox(height: defaultPadding),
                        if (Responsive.isMobile(context))
                          StarageDetails(sealOpenCount: violations.toString()),
                      ],
                    ),
                  ),
                  if (!Responsive.isMobile(context))
                    SizedBox(width: defaultPadding),
                  // On Mobile means if the screen is less than 850 we dont want to show it
                  if (!Responsive.isMobile(context))
                    Expanded(
                      flex: 2,
                      child:
                          StarageDetails(sealOpenCount: violations.toString()),
                    ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
