import 'package:flutter/material.dart';
import 'package:navigo_tracker/register_bus.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Future.delayed(const Duration(seconds: 7), () {
      // Navigating to the home page
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => RegisterBus()),
      );
    });

    return Scaffold(
        body: Align(
      alignment: const AlignmentDirectional(0, 0),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Align(
            alignment: const AlignmentDirectional(-0.05, 0.05),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.asset(
                'assets/bus.png',
                width: MediaQuery.of(context).size.width * 0.12,
                height: 40,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsetsDirectional.fromSTEB(0, 10, 0, 0),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.asset(
                'assets/logo.png',
                width: 200,
                fit: BoxFit.cover,
              ),
            ),
          ),
        ],
      ),
    ));
  }
}
