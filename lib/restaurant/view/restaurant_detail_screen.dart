import 'package:flutter/material.dart';
import 'package:flutter_deep_dive/common/layout/default_layout.dart';
import 'package:flutter_deep_dive/common/models/cursor_pagination_model.dart';
import 'package:flutter_deep_dive/common/utils/pagination_util.dart';
import 'package:flutter_deep_dive/product/components/product_card.dart';
import 'package:flutter_deep_dive/restaurant/components/rating_card.dart';
import 'package:flutter_deep_dive/restaurant/components/restaurant_card.dart';
import 'package:flutter_deep_dive/restaurant/models/rating_model.dart';
import 'package:flutter_deep_dive/restaurant/models/restaurant_detail_model.dart';
import 'package:flutter_deep_dive/restaurant/models/restaurant_model.dart';
import 'package:flutter_deep_dive/restaurant/providers/restaurant_rating_provider.dart';
import 'package:flutter_deep_dive/restaurant/providers/retaurant_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:skeletons/skeletons.dart';

import '../../common/dio/dio.dart';

class RestaurantDetailScreen extends ConsumerStatefulWidget {
  final String id;
  final String title;

  const RestaurantDetailScreen({
    super.key,
    required this.id,
    required this.title,
  });

  @override
  ConsumerState<RestaurantDetailScreen> createState() =>
      _RestaurantDetailScreenState();
}

class _RestaurantDetailScreenState
    extends ConsumerState<RestaurantDetailScreen> {
  final ScrollController scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    ref.read(restaurantProvider.notifier).getRestaurantDetail(id: widget.id);
    scrollController.addListener(
          () {
        PaginationUtil.paginate(
          scrollController: scrollController,
          provider: ref.read(restaurantRatingProvider(widget.id).notifier),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(restaurantDetailProvider(widget.id));
    final ratingsState = ref.watch(restaurantRatingProvider(widget.id));

    if (state == null) {
      const DefaultLayout(
        child: Center(
          child: CircularProgressIndicator.adaptive(),
        ),
      );
    }
    return DefaultLayout(
        title: widget.title,
        child: CustomScrollView(
          controller: scrollController,
          slivers: [
            renderTop(
              model: state!,
            ),
            if (state is! RestaurantDetailModel) renderLoading(),
            if (state is RestaurantDetailModel) renderLabel(),
            if (state is RestaurantDetailModel) renderProducts(model: state),
            if (ratingsState is CursorPagination<RatingModel>)
              renderRatings(models: ratingsState.data)
          ],
        ));
  }

  SliverPadding renderRatings({required List<RatingModel> models}) {
    return SliverPadding(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 30),
      sliver: SliverList(
        delegate: SliverChildBuilderDelegate(
            (context, index) => Padding(
                  padding: const EdgeInsets.only(bottom: 30),
                  child: RatingCard.fromModel(
                    model: models[index],
                  ),
                ),
            childCount: models.length),
      ),
    );
  }

  SliverPadding renderLoading() {
    return SliverPadding(
      padding: EdgeInsets.symmetric(
        vertical: 16.0,
        horizontal: 16.0,
      ),
      sliver: SliverList(
        delegate: SliverChildListDelegate(
          List.generate(
            3,
            (index) => Padding(
              padding: const EdgeInsets.only(bottom: 32.0),
              child: SkeletonParagraph(
                style: SkeletonParagraphStyle(
                  lines: 5,
                  padding: EdgeInsets.zero,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  SliverToBoxAdapter renderTop({
    required RestaurantModel model,
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
              child: ProductCard.fromRestaurantProductModel(model: model.products[index]),
            );
          },
          childCount: model.products.length,
        ),
      ),
    );
  }
}
