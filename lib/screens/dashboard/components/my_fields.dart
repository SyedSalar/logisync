import 'package:flutter/material.dart';
import 'package:logisync/models/MyFiles.dart';
import 'package:logisync/responsive.dart';
import 'package:logisync/screens/dashboard/components/trucks.dart';
import 'package:provider/provider.dart';
import '../../../constants.dart';
import 'file_info_card.dart';

class MyFiles extends StatefulWidget {
  late List<CloudStorageInfo> demoMyFiles;

  MyFiles({Key? key, required this.demoMyFiles}) : super(key: key);

  @override
  State<MyFiles> createState() => _MyFilesState();
}

class _MyFilesState extends State<MyFiles> {
  @override
  Widget build(BuildContext context) {
    final Size _size = MediaQuery.of(context).size;
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Analytics",
              style: Theme.of(context).textTheme.subtitle1,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton.icon(
                  style: TextButton.styleFrom(
                    padding: EdgeInsets.symmetric(
                      horizontal: defaultPadding * 1.5,
                      vertical: defaultPadding /
                          (Responsive.isMobile(context) ? 2 : 1),
                    ),
                  ),
                  onPressed: () async {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => MapScreen(),
                        ));
                  },
                  icon: Icon(Icons.add),
                  label: Text("Start Ride"),
                ),
              ],
            )
          ],
        ),
        SizedBox(height: defaultPadding),
        Responsive(
          mobile: FileInfoCardGridView(
            crossAxisCount: _size.width < 650 ? 2 : 4,
            childAspectRatio: _size.width < 650 && _size.width > 350 ? 1.3 : 1,
            demoMyFiles: widget.demoMyFiles,
          ),
          tablet: FileInfoCardGridView(
            demoMyFiles: widget.demoMyFiles,
          ),
          desktop: FileInfoCardGridView(
            childAspectRatio: _size.width < 1400 ? 1.1 : 1.4,
            demoMyFiles: widget.demoMyFiles,
          ),
        ),
      ],
    );
  }

  void _showBottomSheet(BuildContext context, newData, myIndex) {
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      shape: BeveledRectangleBorder(
          borderRadius:
              BorderRadius.circular(100)), // Enable scrolling if needed
      builder: (BuildContext context) {
        return DefaultTabController(
          length: 1, // Number of tabs
          initialIndex: myIndex,
          child: FractionallySizedBox(
            heightFactor: 0.9, // Cover the full height of the screen
            // widthFactor: MediaQuery.of(context).size.width *
            //     1, // Cover the full width of the screen
            child: Container(
              decoration: const BoxDecoration(
                  color:
                      Colors.white, // Customize the background color as needed
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(16.0),
                    topRight: Radius.circular(16.0),
                  )), // Customize the background color as needed
              child: Column(
                children: [
                  TabBar(
                    dividerColor: Color.fromARGB(255, 139, 139, 139),
                    indicatorColor: Colors.black,
                    labelColor: Colors.black,
                    tabs: [
                      Tab(
                          child: Text('Start Ride',
                              textAlign: TextAlign.center,
                              style: TextStyle(fontSize: 20))),
                    ],
                  ),
                  Expanded(
                    child: TabBarView(
                      children: [
                        Center(
                          child: MapScreen(),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  double _calculateDynamicSize(BuildContext context) {
    // Calculate and return the desired dynamic text size based on the context or any other factors.
    // You can replace this with your logic to calculate the text size dynamically.
    return MediaQuery.of(context).size.width *
        0.04; // Adjust the multiplier as needed
  }
}

class FileInfoCardGridView extends StatefulWidget {
  FileInfoCardGridView(
      {Key? key,
      this.crossAxisCount = 4,
      this.childAspectRatio = 1,
      required this.demoMyFiles})
      : super(key: key);

  final int crossAxisCount;
  final double childAspectRatio;

  late List<CloudStorageInfo> demoMyFiles = [];
  @override
  State<FileInfoCardGridView> createState() => _FileInfoCardGridViewState();
}

class _FileInfoCardGridViewState extends State<FileInfoCardGridView> {
  @override
  Widget build(BuildContext context) {
    widget.demoMyFiles ??= [];

    return GridView.builder(
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: widget.demoMyFiles.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: widget.crossAxisCount,
        crossAxisSpacing: defaultPadding,
        mainAxisSpacing: defaultPadding,
        childAspectRatio: widget.childAspectRatio,
      ),
      itemBuilder: (context, index) =>
          FileInfoCard(info: widget.demoMyFiles[index]),
    );
  }
}
