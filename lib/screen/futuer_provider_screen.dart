import 'package:flutter/material.dart';
import 'package:flutter_deep_dive/common/layout/default_layout.dart';
import 'package:flutter_deep_dive/riverpod/future_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FutureProviderScreen extends ConsumerWidget {
  const FutureProviderScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final AsyncValue state = ref.watch(multipleFutureProvider);
    return DefaultLayout(
      title: 'futureProvider',
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            state.when(
              data: (data) => Text(data.toString()),
              error: (err, stack) => Text(err.toString()),
              loading: () => const CircularProgressIndicator.adaptive(),
            )
          ],
        ),
      ),
    );
  }
}
