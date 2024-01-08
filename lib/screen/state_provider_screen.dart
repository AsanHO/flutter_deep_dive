import 'package:flutter/material.dart';
import 'package:flutter_deep_dive/common/layout/default_layout.dart';
import 'package:flutter_deep_dive/riverpod/state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class StateProviderScreen extends ConsumerWidget {
  const StateProviderScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final provider = ref.watch(numProvider);
    return DefaultLayout(
      title: 'StateProviderScreen',
      child: Column(
        children: [
          Text(provider.toString()),
          ElevatedButton(onPressed: (){ref.read(numProvider.notifier).update((state) => state+=1);}, child: Text("Up"))
        ],
      ),
    );
  }
}
