import 'package:flutter/material.dart';

class CustomScaffold extends StatelessWidget {
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      extendBodyBehindAppBar: true,
      body: Stack(
        children: [
          // Image.asset(
          //  'assets/images/bg1.png',
          // fit: BoxFit.cover,
          //  width: double.infinity,
          //   height: double.infinity,
          // ),
          SafeArea(
            child: Container(
              color: Colors.white.withOpacity(0.8), // Adjust opacity if needed
              child: child,
            ),
          ),
        ],
      ),
    );
  }
}
