import 'package:flutter/material.dart';
import 'package:flutter_deep_dive/common/components/pagination_list_view.dart';
import 'package:flutter_deep_dive/order/model/order_model.dart';
import 'package:flutter_deep_dive/order/provider/order_provider.dart';
import 'package:flutter_deep_dive/order/views/widgets/order_card.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class OrderScreen extends ConsumerWidget {
  const OrderScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return PaginationListView<OrderModel>(
      provider: orderProvider,
      itemBuilder: <OrderModel>(_, index, model) {
        return OrderCard.fromModel(model: model);
      },
    );
  }
}
