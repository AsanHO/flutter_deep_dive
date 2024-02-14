import 'package:flutter_deep_dive/common/models/cursor_pagination_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RestaurantRatingStateNotifier
    extends StateNotifier<CursorPaginationBase> {
  RestaurantRatingStateNotifier()
      : super(
          CursorPaginationLoading(),
        );
}
