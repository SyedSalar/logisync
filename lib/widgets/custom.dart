import 'package:flutter/material.dart';

class CustomSchaffold extends StatelessWidget{
  const CustomSchaffold({super.key, required this.child});
  final Widget child;
  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      extendBodyBehindAppBar: true,
      body: Stack(
        children: <Widget>[
          Image.asset("assets/images/bg1.png",
            fit: BoxFit.cover,
            width: double.infinity,
            height: double.infinity,
          ),
          SafeArea(child: child)
        ],
      ),
    );;
  }
}