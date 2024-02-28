// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// // import 'package:monit_tracker/Navigations/sideBar.dart';
// // import 'package:monit_tracker/Screens/mainScreen.dart';
// import 'dart:math' as math;
// import 'package:blur/blur.dart';
// import 'package:logisync/constants.dart';
// import 'package:logisync/responsive.dart';
// import 'package:logisync/screens/dashboard/dashboard_screen.dart';
// import 'package:provider/provider.dart';

// import '../../providers/providers.dart';

// // import 'package:monit_tracker/components/stylizedButton.dart';

// class MyLogin extends StatefulWidget {
//   @override
//   State<MyLogin> createState() => _MyLoginState();
// }

// class _MyLoginState extends State<MyLogin> with TickerProviderStateMixin {
//   late AnimationController _controller;
//   TextEditingController usernameController = TextEditingController();
//   TextEditingController passwordController = TextEditingController();
//   bool isUsernameFocused = false;
//   bool isPasswordFocused = false;
//   // void _handleSignIn() {
//   //   if (name == usernameController.text && pwd == passwordController.text) {
//   //     Navigator.push(
//   //       context,
//   //       MaterialPageRoute(
//   //         builder: (context) =>
//   //             SidebarXExampleApp(userName: usernameController.text),
//   //       ),
//   //     );
//   //   }
//   // }

//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     _controller = AnimationController(
//       value: 0.0,
//       duration: Duration(seconds: 10),
//       upperBound: 1,
//       lowerBound: -1,
//       vsync: this,
//     )..repeat();
//   }

//   @override
//   void dispose() {
//     // Dispose of the animation controller when the widget is disposed
//     _controller.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     final size = MediaQuery.of(context).size;
//     var themeModel = Provider.of<ThemeModel>(context, listen: false);

//     return Scaffold(
//         floatingActionButton: FloatingActionButton(
//           onPressed: () {
//             // Access the ThemeModel using Provider

//             // Toggle the theme mode
//             print(themeModel.mode);
//             themeModel.toggleMode();
//           },
//           child: Icon(Icons.color_lens), // Add an icon for the theme change
//         ),
//         body: Column(
//           // alignment: Alignment.center,
//           children: [
//             Container(
//               alignment: Alignment.center,
//               width: size.width * 0.9,
//               height: size.height * 0.99,
//               padding: EdgeInsets.all(20),
//               decoration: BoxDecoration(
//                 color: themeModel.mode == ThemeMode.light
//                     ? secondaryColor
//                     : lightSecondaryColor,
//                 borderRadius: BorderRadius.circular(10),
//                 boxShadow: [
//                   BoxShadow(
//                     color: Colors.black12,
//                     blurRadius: 20,
//                     offset: Offset(0, 10),
//                     spreadRadius: 16,
//                   ),
//                 ],
//               ),
//               child: Column(
//                 children: [
//                   Expanded(
//                     child: Stack(
//                       alignment: Alignment.center,
//                       children: [
//                         ClipRRect(
//                           borderRadius: BorderRadius.circular(8),
//                           child: Blur(
//                             blur: 4,
//                             blurColor: Colors.grey,
//                             child: SizedBox(
//                               height: 500,
//                               child: Image.asset(
//                                 'assets/images/background.jpg',
//                                 fit: BoxFit.cover,
//                               ),
//                             ),
//                           ),
//                         ),
//                         Align(
//                           alignment: Alignment.center,
//                           child: Image.asset(
//                             'assets/images/logo2.png',
//                             width: 300,
//                             // size: 500,
//                           ),
//                         ),
//                       ],
//                       // decoration: BoxDecoration(
//                       //     image: DecorationImage(
//                       //   image: AssetImage('assets/images/background.jpg'),
//                       //   fit: BoxFit.cover,
//                       // )),
//                     ),
//                   ),
//                   Expanded(
//                     child: Padding(
//                       padding: const EdgeInsets.all(8.0),
//                       child: Container(
//                         margin: EdgeInsets.all(10),
//                         color: themeModel.mode == ThemeMode.light
//                             ? secondaryColor
//                             : lightSecondaryColor,
//                         child: Column(
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           crossAxisAlignment: CrossAxisAlignment.center,
//                           children: [
//                             // Your custom text fields and buttons can be added here
//                             Text(
//                               'Sign in',
//                               style: TextStyle(
//                                 fontSize:
//                                     42.0, // Adjust the font size as needed
//                                 fontWeight:
//                                     FontWeight.bold, // Make the text bold
//                               ),
//                             ),
//                             SizedBox(
//                               height: defaultPadding,
//                             ),
//                             Focus(
//                               onFocusChange: (hasFocus) {
//                                 // The focus has changed, update the icon color
//                                 setState(() {
//                                   isUsernameFocused = hasFocus;
//                                 });
//                               },
//                               child: TextField(
//                                 decoration: InputDecoration(
//                                   border: OutlineInputBorder(),
//                                   labelText: 'Username',
//                                   icon: Icon(
//                                     CupertinoIcons.profile_circled,
//                                     color: isUsernameFocused
//                                         ? Colors.blue
//                                         : null, // Change color when focused
//                                   ),
//                                 ),
//                                 controller: usernameController,
//                               ),
//                             ),
//                             SizedBox(
//                               height: 50,
//                             ),
//                             Focus(
//                               onFocusChange: (hasFocus) {
//                                 // The focus has changed, update the icon color
//                                 setState(() {
//                                   isPasswordFocused = hasFocus;
//                                 });
//                               },
//                               child: TextField(
//                                 decoration: InputDecoration(
//                                   border: OutlineInputBorder(),
//                                   labelText: 'Password',
//                                   icon: Icon(
//                                     CupertinoIcons.lock_circle,
//                                     color: isPasswordFocused
//                                         ? Colors.blue
//                                         : null, // Change color when focused
//                                   ),
//                                 ),
//                                 obscureText: true,
//                                 controller: passwordController,

//                                 // width: 260,
//                                 // fontSize: 18,
//                               ),
//                             ),
//                             SizedBox(
//                               height: 20,
//                             ),
//                             ElevatedButton.icon(
//                               style: TextButton.styleFrom(
//                                 padding: EdgeInsets.symmetric(
//                                   horizontal: defaultPadding * 1.5,
//                                   vertical: defaultPadding /
//                                       (Responsive.isMobile(context) ? 2 : 1),
//                                 ),
//                               ),
//                               onPressed: () async {
//                                 if (usernameController.text == 'root' &&
//                                     passwordController.text == 'root') {
//                                   Navigator.push(
//                                       context,
//                                       MaterialPageRoute(
//                                         builder: (context) => DashboardScreen(),
//                                       ));
//                                 } else {}
//                               },
//                               icon: Icon(Icons.login_outlined),
//                               label: Text("Sign in"),
//                             ),
//                             // DynamicTextField(
//                             //   hintText: 'Password',
//                             //   labelText: 'Password',
//                             //   icon: CupertinoIcons.lock_circle,
//                             //   width: 260,
//                             //   fontSize: 18,
//                             //   obscureText: true,
//                             //   controller: passwordController,
//                             // ),

//                             // StylizedButton(
//                             //   label: 'Sign In',
//                             //   onPressed: () {
//                             //     name = usernameController.text;
//                             //     pwd = passwordController.text;
//                             //     // _handleSignIn();
//                             //     if (name == usernameController.text &&
//                             //         pwd == passwordController.text) {
//                             //       Navigator.push(
//                             //         context,
//                             //         MaterialPageRoute(
//                             //           builder: (context) => SidebarXExampleApp(
//                             //             userName: usernameController.text,
//                             //           ),
//                             //         ),
//                             //       );
//                             //     }
//                             //   },

//                             //   // Call the new function to handle sign-in
//                             //   startColor: Colors.blue,

//                             //   endColor: Colors.blue,
//                             // )
//                           ],
//                         ),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//             // SizedBox(
//             //   height: 100,
//             //   child: RotatedBox(
//             //     quarterTurns: 2,
//             //     child: AnimatedBuilder(
//             //       animation: _controller,
//             //       builder: (BuildContext context, Widget? child) {
//             //         return ClipPath(
//             //           clipper: DrawClip(_controller.value),
//             //           child: Container(
//             //             // height: size.height * 0.1,
//             //             decoration: const BoxDecoration(
//             //               gradient: LinearGradient(
//             //                   begin: Alignment.bottomLeft,
//             //                   end: Alignment.topRight,
//             //                   colors: [
//             //                     Color.fromARGB(255, 0, 165, 241),
//             //                     Color.fromARGB(255, 0, 165, 241),
//             //                   ]),
//             //             ),
//             //           ),
//             //         );
//             //       },
//             //     ),
//             //   ),
//             // ),
//           ],
//         ));
//   }
// }

// class DrawClip extends CustomClipper<Path> {
//   double move = 0;
//   double slice = math.pi;
//   DrawClip(this.move);
//   @override
//   Path getClip(Size size) {
//     Path path = Path();
//     path.lineTo(0, size.height * 0.8);
//     double xCenter =
//         size.width * 0.5 + (size.width * 0.6 + 1) * math.sin(move * slice);
//     double yCenter = size.height * 0.8 + 69 * math.cos(move * slice);
//     path.quadraticBezierTo(xCenter, yCenter, size.width, size.height * 0.8);

//     path.lineTo(size.width, 0);
//     return path;
//   }

//   @override
//   bool shouldReclip(CustomClipper<Path> oldClipper) {
//     return true;
//   }
// }

// class WavePainter extends CustomPainter {
//   @override
//   void paint(Canvas canvas, Size size) {
//     final paint = Paint()
//       ..style = PaintingStyle.fill
//       ..isAntiAlias = true
//       ..color = Colors.blue.withOpacity(0.3);

//     final path = Path()
//       ..moveTo(0, size.height * 0.5)
//       ..quadraticBezierTo(size.width * 0.25, size.height * 0.6,
//           size.width * 0.5, size.height * 0.5)
//       ..quadraticBezierTo(
//           size.width * 0.75, size.height * 0.4, size.width, size.height * 0.5)
//       ..lineTo(size.width, size.height)
//       ..lineTo(0, size.height)
//       ..close();

//     canvas.drawPath(path, paint);
//   }

//   @override
//   bool shouldRepaint(CustomPainter oldDelegate) {
//     return false;
//   }
// }
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;
import 'package:blur/blur.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:logisync/constants.dart';
import 'package:logisync/responsive.dart';
import 'package:logisync/screens/dashboard/dashboard_screen.dart';
import 'package:provider/provider.dart';

import '../../providers/providers.dart';

class MyLogin extends StatefulWidget {
  @override
  State<MyLogin> createState() => _MyLoginState();
}

class _MyLoginState extends State<MyLogin> with TickerProviderStateMixin {
  late AnimationController _controller;
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool isUsernameFocused = false;
  bool isPasswordFocused = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      value: 0.0,
      duration: Duration(seconds: 10),
      upperBound: 1,
      lowerBound: -1,
      vsync: this,
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    var themeModel = Provider.of<ThemeModel>(context, listen: false);

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          print(themeModel.mode);
          themeModel.toggleMode();
        },
        child: Icon(Icons.color_lens),
      ),
      body: Stack(
        children: [
          Positioned.fill(
            bottom: 0,
            top: 400,
            child: RotatedBox(
              quarterTurns: 2,
              child: AnimatedBuilder(
                animation: _controller,
                builder: (BuildContext context, Widget? child) {
                  return ClipPath(
                    clipper: DrawClip(_controller.value),
                    child: Container(
                      decoration: const BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.bottomLeft,
                          end: Alignment.topRight,
                          colors: [
                            Color.fromARGB(255, 0, 165, 241),
                            Color.fromARGB(255, 0, 165, 241),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
          Center(
            child: Container(
              alignment: Alignment.center,
              width: size.width * 0.9, // Adjusted width
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: themeModel.mode == ThemeMode.light
                    ? secondaryColor
                    : lightSecondaryColor,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 20,
                    offset: Offset(0, 10),
                    spreadRadius: 16,
                  ),
                ],
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Blur(
                            blur: 4,
                            blurColor: Colors.grey,
                            child: SizedBox(
                              height: size.height * 0.4, // Adjusted height
                              width: double.infinity,
                              child: Image.asset(
                                'assets/images/background.jpg',
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                        Text(
                          'Logisync',
                          style: GoogleFonts.bubblegumSans(
                              fontWeight: FontWeight.bold,
                              color: Colors.blue,
                              fontSize: 72),
                        )
                        // Image.asset(
                        //   'assets/images/logo2.png',
                        //   width: size.width * 0.5, // Adjusted width
                        // ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        margin: EdgeInsets.all(10),
                        color: themeModel.mode == ThemeMode.light
                            ? secondaryColor
                            : lightSecondaryColor,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              'Sign in',
                              style: TextStyle(
                                fontSize: 42.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: defaultPadding),
                            Focus(
                              onFocusChange: (hasFocus) {
                                setState(() {
                                  isUsernameFocused = hasFocus;
                                });
                              },
                              child: TextField(
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                  labelText: 'Username',
                                  icon: Icon(
                                    Icons.person,
                                    color:
                                        isUsernameFocused ? Colors.blue : null,
                                  ),
                                ),
                                controller: usernameController,
                              ),
                            ),
                            SizedBox(height: 20), // Adjusted height
                            Focus(
                              onFocusChange: (hasFocus) {
                                setState(() {
                                  isPasswordFocused = hasFocus;
                                });
                              },
                              child: TextField(
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                  labelText: 'Password',
                                  icon: Icon(
                                    Icons.lock,
                                    color:
                                        isPasswordFocused ? Colors.blue : null,
                                  ),
                                ),
                                obscureText: true,
                                controller: passwordController,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  ElevatedButton.icon(
                    style: TextButton.styleFrom(
                      padding: EdgeInsets.symmetric(
                        horizontal: defaultPadding * 1.5,
                        vertical: defaultPadding /
                            (Responsive.isMobile(context) ? 2 : 1),
                      ),
                    ),
                    onPressed: () async {
                      if (usernameController.text == 'root' &&
                          passwordController.text == 'root') {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => DashboardScreen(),
                          ),
                        );
                      } else {}
                    },
                    icon: Icon(Icons.login_outlined),
                    label: Text("Sign in"),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class DrawClip extends CustomClipper<Path> {
  double move = 0;
  double slice = math.pi;
  DrawClip(this.move);
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.lineTo(0, size.height * 0.8);
    double xCenter =
        size.width * 0.5 + (size.width * 0.6 + 1) * math.sin(move * slice);
    double yCenter = size.height * 0.8 + 69 * math.cos(move * slice);
    path.quadraticBezierTo(xCenter, yCenter, size.width, size.height * 0.8);
    path.lineTo(size.width, 0);
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return true;
  }
}
