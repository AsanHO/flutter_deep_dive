import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_deep_dive/common/const/environments.dart';
import 'package:flutter_deep_dive/common/layout/default_layout.dart';
import 'package:flutter_deep_dive/product/components/product_card.dart';
import 'package:flutter_deep_dive/restaurant/components/restaurant_card.dart';
import 'package:flutter_deep_dive/restaurant/models/restaurant_detail_model.dart';

class RestaurantDetailScreen extends StatelessWidget {
  final String id;
  final String title;

  const RestaurantDetailScreen({
    super.key,
    required this.id,
    required this.title,
  });

  Future<Map<String, dynamic>> getRestaurantDetail() async {
    final dio = Dio();

    final accessToken = await storage.read(key: ACCESS_TOKEN_KEY);
    final resp = await dio.get("$IP/restaurant/$id",
        options: Options(headers: {'authorization': 'Bearer $accessToken'}));
    return resp.data;
  }

  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
        title: title,
        child: FutureBuilder(
          future: getRestaurantDetail(),
          builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
            if (!snapshot.hasData) {
              return const Center(
                child: CircularProgressIndicator.adaptive(),
              );
            }
            final item = RestaurantDetailModel.fromJson(
              snapshot.data!,
            );
            return CustomScrollView(
              slivers: [
                renderTop(
                  model: item,
                ),
                renderLabel(),
                renderProducts(model: item),
              ],
            );
          },
        ));
  }

  SliverToBoxAdapter renderTop({
    required RestaurantDetailModel model,
  }) {
    return SliverToBoxAdapter(
      child: RestaurantCard.fromModel(
        model: model,
        isDetail: true,
      ),
    );
  }

  SliverPadding renderLabel() {
    return const SliverPadding(
      padding: EdgeInsets.symmetric(horizontal: 16.0),
      sliver: SliverToBoxAdapter(
        child: Text(
          '메뉴',
          style: TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }

  SliverPadding renderProducts({required RestaurantDetailModel model}) {
    return SliverPadding(
      padding: EdgeInsets.symmetric(horizontal: 16.0),
      sliver: SliverList(
        delegate: SliverChildBuilderDelegate(
              (context, index) {
            return Padding(
              padding: const EdgeInsets.only(top: 16.0),
              child: ProductCard(model: model.products[index]),
            );
          },
          childCount:model.products.length,
        ),
      ),
    );
  }
}
