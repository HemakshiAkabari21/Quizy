import 'package:flutter/material.dart';
import 'package:quizy/widgets/animated_time_up.dart';

class StoreScreen extends StatefulWidget {
  const StoreScreen({super.key});

  @override
  _StoreScreenState createState() => _StoreScreenState();
}

class _StoreScreenState extends State<StoreScreen> with TickerProviderStateMixin {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Coming soon.....'),
          ],
        ),
      ),
    );
  }
}