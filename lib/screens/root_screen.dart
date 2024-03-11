import 'package:flutter/material.dart';
import 'package:flutter_deep_dive/layout/default_layout.dart';
import 'package:go_router/go_router.dart';

class RootScreen extends StatelessWidget {
  const RootScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
      body: ListView(
        children: [
          ElevatedButton(
              onPressed: () => context.go('/basic'), child: Text('gobasic')),
          ElevatedButton(
              onPressed: () => context.goNamed('named_screen'),
              child: Text('gonamedbasic'))
        ],
      ),
    );
  }
}
