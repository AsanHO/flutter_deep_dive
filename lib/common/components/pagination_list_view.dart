import 'package:flutter/material.dart';
import 'package:flutter_deep_dive/common/models/cursor_pagination_model.dart';
import 'package:flutter_deep_dive/common/models/model_with_id.dart';
import 'package:flutter_deep_dive/common/providers/pagination_provider.dart';
import 'package:flutter_deep_dive/common/utils/pagination_util.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

typedef PaginationWidgetBuilder<T extends IModelWithId> = Widget Function(
    BuildContext context, int index, T model);

class PaginationListView<T extends IModelWithId>
    extends ConsumerStatefulWidget {
  final StateNotifierProvider<PaginationProvider, CursorPaginationBase>
      provider;
  final PaginationWidgetBuilder<T> itemBuilder;

  const PaginationListView({
    super.key,
    required this.provider,
    required this.itemBuilder,
  });

  @override
  ConsumerState<PaginationListView> createState() =>
      _PaginationListViewState<T>();
}

class _PaginationListViewState<T extends IModelWithId>
    extends ConsumerState<PaginationListView> {
  final ScrollController scrollController = ScrollController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    scrollController.addListener(listener);
  }

  void listener() {
    PaginationUtil.paginate(
      scrollController: scrollController,
      provider: ref.read(widget.provider.notifier),
    );
  }

  @override
  void dispose() {
    scrollController.removeListener(listener);
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(widget.provider);
    if (state is CursorPaginationLoading) {
      return const Center(
        child: CircularProgressIndicator.adaptive(),
      );
    }
    //에러
    if (state is CursorPaginationError) {
      return Center(
        child: Column(
          children: [
            Text(state.message),
            ElevatedButton(
                onPressed: () {
                  ref.read(widget.provider.notifier).paginate(isReFetch: true);
                },
                child: Text('다시 시도'))
          ],
        ),
      );
    }
    final cp = state as CursorPagination;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: ListView.separated(
        controller: scrollController,
        itemCount: cp.data.length + 1,
        itemBuilder: (_, index) {
          if (index == cp.data.length) {
            return Padding(
              padding: EdgeInsets.all(10),
              child: cp is CursorPaginationFetchingMore
                  ? CircularProgressIndicator.adaptive()
                  : Text("마지막데이터입니다."),
            );
          }
          final item = cp.data[index];
          return widget.itemBuilder(context, index, item);
        },
        separatorBuilder: (_, idx) {
          return const Divider(
            height: 40,
          );
        },
      ),
    );
  }
}
