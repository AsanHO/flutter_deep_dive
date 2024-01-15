import 'package:flutter/material.dart';
import 'package:flutter_deep_dive/common/layout/default_layout.dart';
import 'package:flutter_deep_dive/screen/state_notifier_provider_screen.dart';
import 'package:flutter_deep_dive/screen/state_provider_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
      title: '홈',
      child: ListView(
        children: [
          ElevatedButton(
            onPressed: () => Navigator.of(context).push(
              MaterialPageRoute(
                builder: (_) => const StateProviderScreen(),
              ),
            ),
            child: const Text('StateProviderScreen'),
          ),
          ElevatedButton(
            onPressed: () => Navigator.of(context).push(
              MaterialPageRoute(
                builder: (_) => const StateNotifierProviderScreen(),
              ),
            ),
            child: const Text('StateNotifierProviderScreen'),
          )
        ],
      ),
    );
  }
}
