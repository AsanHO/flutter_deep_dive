import 'package:flutter/material.dart';
import 'package:flutter_deep_dive/common/layout/default_layout.dart';
import 'package:flutter_deep_dive/screen/auto_dispose_modifier_screen.dart';
import 'package:flutter_deep_dive/screen/family_modifier_provider_screen.dart';
import 'package:flutter_deep_dive/screen/futuer_provider_screen.dart';
import 'package:flutter_deep_dive/screen/state_notifier_provider_screen.dart';
import 'package:flutter_deep_dive/screen/state_provider_screen.dart';
import 'package:flutter_deep_dive/screen/stream_provider_screen.dart';

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
          ),
          ElevatedButton(
            onPressed: () => Navigator.of(context).push(
              MaterialPageRoute(
                builder: (_) => const FutureProviderScreen(),
              ),
            ),
            child: const Text('FutureProviderScreen'),
          ),
          ElevatedButton(
            onPressed: () => Navigator.of(context).push(
              MaterialPageRoute(
                builder: (_) => const StreamProviderScreen(),
              ),
            ),
            child: const Text('StreamProviderScreen'),
          ),
          ElevatedButton(
            onPressed: () => Navigator.of(context).push(
              MaterialPageRoute(
                builder: (_) => const FamilyModifierProviderScreen(),
              ),
            ),
            child: const Text('FamilyModifierProviderScreen'),
          ),
          ElevatedButton(
            onPressed: () => Navigator.of(context).push(
              MaterialPageRoute(
                builder: (_) => const AutoDisposeModifierProviderScreen(),
              ),
            ),
            child: const Text('AutoDisposeModifierProviderScreen'),
          ),
        ],
      ),
    );
  }
}
