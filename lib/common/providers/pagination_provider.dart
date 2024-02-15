import 'package:flutter_deep_dive/common/models/cursor_pagination_model.dart';
import 'package:flutter_deep_dive/common/models/model_with_id.dart';
import 'package:flutter_deep_dive/common/models/pagination_params.dart';
import 'package:flutter_deep_dive/common/repository/base_pagination_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PaginationProvider<T extends IModelWithId,
        R extends IBasePaginationRepository<T>>
    extends StateNotifier<CursorPaginationBase> {
  final R repository;

  PaginationProvider({
    required this.repository,
  }) : super(
          CursorPaginationLoading(),
        ) {
    paginate();
  }

  Future<void> paginate({
    int fetchAmount = 5,
    bool fetchMore = false,
    bool isReFetch = false,
  }) async {
    // 1.CursorPagination
    // 2.CursorPaginationLoading
    // 3.CursorPaginationError
    // 4.CursorPaginationRefetching
    // 4.CursorPaginationFetchMore

    // 바로 반환시 ->
    try {
      if (state is CursorPagination && !isReFetch) {
        final pState = state as CursorPagination;
        // 1
        if (!pState.meta.hasMore!) {
          return;
        }
      }

      final isLoading = state is CursorPaginationLoading;
      final isRefetching = state is CursorPaginationRefetching;
      final isFetchingMore = state is CursorPaginationFetchingMore;

      if (fetchMore && (isLoading || isRefetching || isFetchingMore)) {
        return;
      }
      //<- 바로 반환시

      //다음페이지로 이동
      PaginationParams paginationParams = PaginationParams(count: fetchAmount);
      if (fetchMore) {
        final pState = state as CursorPagination<T>;

        state = CursorPaginationFetchingMore<T>(
          meta: pState.meta,
          data: pState.data,
        );

        paginationParams = paginationParams.copyWith(
          after: pState.data.last.id,
        );
      }
      if (state is CursorPagination && isReFetch) {
        final pState = state as CursorPagination<T>;
        state = CursorPaginationRefetching<T>(
          data: pState.data,
          meta: pState.meta,
        );
      }
      final resp =
          await repository.paginate(paginationParams: paginationParams);

      if (state is CursorPaginationFetchingMore) {
        final pState = state as CursorPaginationFetchingMore;

        state = resp.copyWith(data: [
          ...pState.data,
          ...resp.data,
        ]);
      } else {
        state = resp;
      }
    } catch (e,stack) {
      print(e);
      print(stack);
      state = CursorPaginationError(message: '데이터를 가져오지 못했어요 ㅜ');
    }
  }
}
