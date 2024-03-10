import 'package:flutter/material.dart';
import 'package:flutter_deep_dive/common/components/pagination_list_view.dart';
import 'package:flutter_deep_dive/restaurant/components/restaurant_card.dart';
import 'package:flutter_deep_dive/restaurant/providers/retaurant_provider.dart';
import 'package:flutter_deep_dive/restaurant/view/restaurant_detail_screen.dart';

class RestaurantScreen extends StatelessWidget {
  const RestaurantScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return PaginationListView(
        provider: restaurantProvider,
        itemBuilder: <RestaurantModel>(_, index, model) {
          return GestureDetector(
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (builder) => RestaurantDetailScreen(
                    id: model.id,
                    title: model.name,
                  ),
                ),
              );
            },
            child: RestaurantCard.fromModel(
              model: model,
            ),
          );
        });
  }
}
