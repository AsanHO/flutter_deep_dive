import 'package:flutter/cupertino.dart';
import 'package:flutter_deep_dive/common/providers/pagination_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PaginationUtil {
  static void paginate({
    required ScrollController scrollController,
    required PaginationProvider provider,
  }) {
        if (scrollController.offset >
            scrollController.position.maxScrollExtent - 300) {
          provider.paginate(fetchMore: true);
        }


  }
}
