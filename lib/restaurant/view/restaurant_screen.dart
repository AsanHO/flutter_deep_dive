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
  final ScrollController scrollController = ScrollController();

  Future<List<RestaurantModel>> getRestaurant() async {
    final dio = ref.watch(dioProvider);
    final resp = await RestaurantRepository(dio, baseUrl: '$IP/restaurant')
        .paginate();
    print(resp);
    return resp.data;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    scrollController.addListener(() {
      if (scrollController.offset >
          scrollController.position.maxScrollExtent - 300) {
        ref.read(restaurantProvider.notifier).paginate(fetchMore: true);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(restaurantProvider);

    if (state is CursorPaginationLoading) {
      return Center(
        child: CircularProgressIndicator.adaptive(),
      );
    }

    if (state is CursorPaginationError) {
      return Center(
        child: Text(state.message),
      );
    }
    final cp = state as CursorPagination;
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: ListView.separated(
          controller: scrollController,
          itemCount: cp.data.length + 1,
          itemBuilder: (_, idx) {
            if (idx == cp.data.length) {
              return Padding(
                padding: EdgeInsets.all(10),
                child: state is CursorPaginationFetchingMore
                    ? CircularProgressIndicator.adaptive()
                    : Text("마지막데이터입니다."),
              );
            }
            final RestaurantModel item = cp.data[idx];

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
        ),
      ),
    );
  }
}
