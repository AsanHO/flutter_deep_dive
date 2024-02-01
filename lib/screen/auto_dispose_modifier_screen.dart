import 'package:flutter/material.dart';
import 'package:flutter_deep_dive/common/layout/default_layout.dart';
import 'package:flutter_deep_dive/riverpod/family_modifier_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../riverpod/auto_dispose_provider.dart';

class AutoDisposeModifierProviderScreen extends ConsumerWidget {
  const AutoDisposeModifierProviderScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(autoDisposeModifierProvider);
    return DefaultLayout(
      title: 'familyModifierProviderScreen',
      child: Center(
        child: state.when(
            data: (data) => Text(data.toString()),
            error: (err, stack) => Text(err.toString()),
            loading: () => const CircularProgressIndicator()),
      ),
    );
  }
}
