import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_deep_dive/common/const/environments.dart';
import 'package:flutter_deep_dive/common/dio/dio.dart';
import 'package:flutter_deep_dive/common/models/cursor_pagination_model.dart';
import 'package:flutter_deep_dive/restaurant/components/restaurant_card.dart';
import 'package:flutter_deep_dive/restaurant/models/restaurant_model.dart';
import 'package:flutter_deep_dive/restaurant/providers/retaurant_provider.dart';
import 'package:flutter_deep_dive/restaurant/repository/restaurant_repository.dart';
import 'package:flutter_deep_dive/restaurant/view/restaurant_detail_screen.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RestaurantScreen extends ConsumerStatefulWidget {
  const RestaurantScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<RestaurantScreen> createState() => _RestaurantScreenState();
}

class _RestaurantScreenState extends ConsumerState<RestaurantScreen> {
  Future<List<RestaurantModel>> getRestaurant() async {
    final dio = ref.watch(dioProvider);
    final resp = await RestaurantRepository(dio, baseUrl: '$IP/restaurant')
        .getRestaurants();
    print(resp);
    return resp.data;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(restaurantProvider);
    if (state.length == 0) {
      return Center(
        child: CircularProgressIndicator.adaptive(),
      );
    }
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: ListView.separated(
            itemBuilder: (_, idx) {
              final RestaurantModel item = state[idx];

              return GestureDetector(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (builder) => RestaurantDetailScreen(
                        id: item.id,
                        title: item.name,
                      ),
                    ),
                  );
                },
                child: RestaurantCard.fromModel(
                  model: item,
                ),
              );
            },
            separatorBuilder: (_, idx) {
              return Divider(
                height: 40,
              );
            },
            itemCount: state.length),
      ),
    );
  }
}
