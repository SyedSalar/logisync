import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:logisync/models/RecentFile.dart';
import 'package:logisync/providers/providers.dart';
import 'package:provider/provider.dart';
import '../../../constants.dart';

class RecentFiles extends StatefulWidget {
  const RecentFiles({
    Key? key,
  }) : super(key: key);

  @override
  State<RecentFiles> createState() => _RecentFilesState();
}

class _RecentFilesState extends State<RecentFiles> {
  List newData = [];
  @override
  void initState() {
    super.initState();
    getLogs();
    _scheduleUpdates();
  }

  _scheduleUpdates() {
    Future.delayed(Duration(minutes: 1), () {
      getLogs();
      _scheduleUpdates();
    });
  }

  getLogs() async {
    try {} catch (e) {
      print('Error fetching data: $e');
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    var themeModel = Provider.of<ThemeModel>(context, listen: false);

    return Container(
      padding: EdgeInsets.all(defaultPadding),
      decoration: BoxDecoration(
        color: themeModel.mode == ThemeMode.light
            ? secondaryColor
            : lightSecondaryColor,
        borderRadius: const BorderRadius.all(Radius.circular(10)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Journey Status",
            style: Theme.of(context).textTheme.subtitle1,
          ),
          SizedBox(
            height: 300,
            child: DataTable2(
              columnSpacing: defaultPadding,
              minWidth: 600,
              columns: [
                DataColumn(
                  label: Text("Journey"),
                ),
                DataColumn(
                  label: Text("Date"),
                ),
                DataColumn(
                  label: Text("Status"),
                ),
              ],
              rows: List.generate(
                demoRecentFiles.length,
                (index) => recentFileDataRow(demoRecentFiles[index]),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

DataRow recentFileDataRow(RecentFile fileInfo) {
  return DataRow(
    cells: [
      DataCell(
        Row(
          children: [
            SvgPicture.asset(
              fileInfo.icon!,
              height: 30,
              width: 30,
            ),
            Expanded(child: Text(fileInfo.title!)),
          ],
        ),
      ),
      DataCell(Text(fileInfo.date!)),
      DataCell(Text(fileInfo.size!)),
    ],
  );
}
