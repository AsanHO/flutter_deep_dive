import 'package:flutter/material.dart';
import 'package:flutter_deep_dive/common/components/pagination_list_view.dart';
import 'package:flutter_deep_dive/product/components/product_card.dart';
import 'package:flutter_deep_dive/product/providers/product_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProductScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return PaginationListView(
      provider: productProvider,
      itemBuilder: <ProductModel>(_, index, model) {
        return ProductCard.fromProductModel(
          model: model,
        );
      },
    );
  }
}
