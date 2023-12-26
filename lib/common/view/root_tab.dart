import 'package:flutter/material.dart';

class RootTab extends StatefulWidget {
  const RootTab({super.key});

  @override
  State<RootTab> createState() => _RootTabState();
}

class _RootTabState extends State<RootTab> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Text("루트다투르"),),
    );
  }
}
