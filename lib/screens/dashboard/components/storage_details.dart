import 'package:flutter/material.dart';
import 'package:logisync/providers/providers.dart';
import 'package:logisync/screens/dashboard/components/latest_violation_map.dart';
import 'package:provider/provider.dart';
import '../../../constants.dart';
import 'chart.dart';
import 'storage_info_card.dart';

class StarageDetails extends StatefulWidget {
  String sealOpenCount;

  StarageDetails({Key? key, required this.sealOpenCount}) : super(key: key);

  @override
  State<StarageDetails> createState() => _StarageDetailsState();
}

class _StarageDetailsState extends State<StarageDetails> {
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
            "Details",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(height: defaultPadding),
          Chart(),
          GestureDetector(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => LatestViolationMap(),
                  ));
            },
            child: StorageInfoCard(
              svgSrc: "assets/icons/Documents.svg",
              title: "Seatbelt On",
              amountOfFiles: widget.sealOpenCount.toString(),
              numOfFiles: int.parse(widget.sealOpenCount),
            ),
          ),
          StorageInfoCard(
            svgSrc: "assets/icons/media.svg",
            title: "Reached on time",
            amountOfFiles: "15",
            numOfFiles: 1328,
          ),
          StorageInfoCard(
            svgSrc: "assets/icons/folder.svg",
            title: "Slow Driving",
            amountOfFiles: "1",
            numOfFiles: 1328,
          ),
          StorageInfoCard(
            svgSrc: "assets/icons/unknown.svg",
            title: "Violations",
            amountOfFiles: "2",
            numOfFiles: 140,
          ),
        ],
      ),
    );
  }
}
