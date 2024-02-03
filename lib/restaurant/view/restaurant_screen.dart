import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_deep_dive/common/const/environments.dart';
import 'package:flutter_deep_dive/common/dio/dio.dart';
import 'package:flutter_deep_dive/restaurant/components/restaurant_card.dart';
import 'package:flutter_deep_dive/restaurant/models/restaurant_model.dart';
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
    final resp = await RestaurantRepository(dio, baseUrl: '$IP/restaurant').getRestaurants();
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
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: FutureBuilder(
          future: getRestaurant(),
          builder: (context, AsyncSnapshot<List> snapshot) {
            if (!snapshot.hasData) {
              return Container();
            }
            return ListView.separated(
                itemBuilder: (_, idx) {
                  final RestaurantModel item =
                      snapshot.data![idx];

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
                itemCount: snapshot.data!.length);
          },
        ),
      ),
    );
  }
}
