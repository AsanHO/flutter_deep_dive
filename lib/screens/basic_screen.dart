import 'package:flutter/material.dart';
import 'package:flutter_deep_dive/layout/default_layout.dart';

class BasicScreen extends StatelessWidget {
  const BasicScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultLayout(body: Center(child: Text('basicScreen'),));
  }
}
