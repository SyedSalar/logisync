import 'package:flutter/material.dart';
import 'package:logisync/constants.dart';
import 'package:logisync/providers/providers.dart';
import 'package:logisync/screens/auth/login.dart';
import 'package:logisync/screens/dashboard/dashboard_screen.dart';
import 'package:google_fonts/google_fonts.dart' as Googlefonts;
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ThemeModel>(
        create: (_) => ThemeModel(),
        child: Consumer<ThemeModel>(builder: (_, model, __) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            themeMode: model.mode,
            darkTheme: ThemeData.light().copyWith(
              scaffoldBackgroundColor: lightBgColor,
              textTheme: Googlefonts.GoogleFonts.poppinsTextTheme(
                      Theme.of(context).textTheme)
                  .apply(bodyColor: Colors.black),
              canvasColor: lightSecondaryColor,
            ),
            theme: ThemeData.dark().copyWith(
              scaffoldBackgroundColor: bgColor,
              textTheme: Googlefonts.GoogleFonts.poppinsTextTheme(
                      Theme.of(context).textTheme)
                  .apply(bodyColor: Colors.white),
              canvasColor: secondaryColor,
            ),
            home: MyLogin(),
          );
        }));
  }
}
