import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:logisync/providers/providers.dart';
import 'package:logisync/responsive.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../constants.dart';

class Header extends StatelessWidget {
  Header({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        if (!Responsive.isMobile(context))
          Text(
            "Dashboard",
            style: Theme.of(context).textTheme.headline6,
          ),
        if (!Responsive.isMobile(context))
          Spacer(flex: Responsive.isDesktop(context) ? 2 : 1),
        Expanded(child: SearchField()),
        ProfileCard()
      ],
    );
  }
}

class ProfileCard extends StatelessWidget {
  ProfileCard({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var themeModel = Provider.of<ThemeModel>(context, listen: false);

    return InkWell(
      onTap: () {
        showMenu(
          shape: BeveledRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(5))),
          context: context,
          position: const RelativeRect.fromLTRB(
              100, 100, 10, 0), // Adjust position as needed
          items: [
            // PopupMenuItem<String>(
            //   onTap: () async {
            //     // SharedPreferences prefs = await SharedPreferences.getInstance();
            //     // prefs.remove('username');
            //     // prefs.remove('password');
            //     // prefs.remove('role');
            //     // Navigator.pushAndRemoveUntil(
            //     //   context,
            //     //   MaterialPageRoute(builder: (context) => MyApp()),
            //     //   (route) => true,
            //     // );
            //   },
            //   // value: _branch.text,
            //   child: Text(''),
            // ),
            // PopupMenuItem<String>(
            //     onTap: () {},
            //     child: ElevatedButton(
            //       onPressed: () {},
            //       style: ElevatedButton.styleFrom(
            //           backgroundColor: ColorModel.colorCodes[20]),
            //       child: const Text('Search'),
            //     )),
          ],
          elevation: 8.0, // Adjust elevation as needed
        );
      },
      child: Container(
        margin: EdgeInsets.only(left: defaultPadding),
        padding: EdgeInsets.symmetric(
          horizontal: defaultPadding,
          vertical: defaultPadding / 2,
        ),
        decoration: BoxDecoration(
          color: themeModel.mode == ThemeMode.light
              ? secondaryColor
              : lightSecondaryColor,
          borderRadius: const BorderRadius.all(Radius.circular(10)),
          border: Border.all(color: Colors.white10),
        ),
        child: Row(
          children: [
            Icon(
              Icons.account_circle_outlined,
              color: Colors.white,
            ),
            if (!Responsive.isMobile(context))
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: defaultPadding / 2),
                child: Text('Rider'),
              ),
            Icon(Icons.keyboard_arrow_down),
          ],
        ),
      ),
    );
  }
}

class SearchField extends StatelessWidget {
  const SearchField({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var themeModel = Provider.of<ThemeModel>(context, listen: false);

    return TextField(
      decoration: InputDecoration(
        hintText: "Search",
        fillColor: themeModel.mode == ThemeMode.light
            ? secondaryColor
            : lightSecondaryColor,
        filled: true,
        border: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: const BorderRadius.all(Radius.circular(10)),
        ),
        suffixIcon: InkWell(
          onTap: () {},
          child: Container(
            padding: EdgeInsets.all(defaultPadding * 0.75),
            margin: EdgeInsets.symmetric(horizontal: defaultPadding / 2),
            decoration: BoxDecoration(
              color: primaryColor,
              borderRadius: const BorderRadius.all(Radius.circular(10)),
            ),
            child: SvgPicture.asset("assets/icons/Search.svg"),
          ),
        ),
      ),
    );
  }
}
