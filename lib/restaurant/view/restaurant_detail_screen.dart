import 'package:flutter/material.dart';
import 'package:flutter_deep_dive/common/layout/default_layout.dart';

class RestaurantDetailScreen extends StatefulWidget {
  const RestaurantDetailScreen({super.key});

  @override
  State<RestaurantDetailScreen> createState() => _RestaurantDetailScreenState();
}

class _RestaurantDetailScreenState extends State<RestaurantDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultLayout(child: Center(child: Text("hi"),));
  }
}
