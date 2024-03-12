import 'package:flutter/material.dart';
import 'package:flutter_deep_dive/layout/default_layout.dart';
import 'package:go_router/go_router.dart';

class PushScreen extends StatelessWidget {
  const PushScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultLayout(body: Center(child: Column(
      children: [
        ElevatedButton(
            onPressed: () => context.push('/basic'),
            child: Text('push basic')),
        ElevatedButton(
            onPressed: () => context.goNamed('named_screen'),
            child: Text('go Basic'))
      ],
    ),));
  }
}
