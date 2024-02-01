import 'package:flutter/material.dart';
import 'package:flutter_deep_dive/common/layout/default_layout.dart';
import 'package:flutter_deep_dive/riverpod/code_generation_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CodeGenerationScreen extends ConsumerWidget {
  const CodeGenerationScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final String state = ref.watch(gStateProvider);
    final AsyncValue<int> fstate = ref.watch(gStateFutureProvider);
    final AsyncValue<int> fstateAlive = ref.watch(gStateFutureAliveProvider);
    final int stateF = ref.watch(gStatefProvider(p1: 10,p2: 22));
    final int stateNotifier = ref.watch(gStateNotifierProvider);
    return DefaultLayout(
      title: '코드 제너레이션',
      child: Center(
        child: Column(
          children: [
            Text(state),
            Text(fstate.toString()),
            Text(fstateAlive.toString()),
            Text(stateF.toString()),
            Text(stateNotifier.toString()),
            ElevatedButton(onPressed: () => ref.read(gStateNotifierProvider.notifier).inc(), child: Text("증가")),
            ElevatedButton(onPressed: () => ref.read(gStateNotifierProvider.notifier).dec(), child: Text("감소")),
          ],
        ),
      ),
    );
  }
}
