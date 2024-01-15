import 'package:flutter/material.dart';
import 'package:flutter_deep_dive/common/layout/default_layout.dart';
import 'package:flutter_deep_dive/riverpod/state_notifier_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/shopping_item_model.dart';

class StateNotifierProviderScreen extends ConsumerWidget {
  const StateNotifierProviderScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // 타입은 선언해주지 않아도 된다. 하지만 해주자.
    final List<ShoppingItemModel> state = ref.watch(shoppingListProvider);
    return DefaultLayout(
      title: 'StateNotifierProvider',
      child: ListView(
        children: state
            .map(
              (e) => Row(
                children: [
                  Text(e.name),
                  Checkbox.adaptive(
                    value: e.hasBought,
                    onChanged: (value) {
                      ref
                          .read(shoppingListProvider.notifier)
                          .toggleHasBought(name: e.name);
                      print(state);
                    },
                  )
                ],
              ),
            )
            .toList(),
      ),
    );
  }
}
