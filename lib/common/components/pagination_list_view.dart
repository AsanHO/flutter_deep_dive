import 'package:flutter/material.dart';
import 'package:flutter_deep_dive/common/models/cursor_pagination_model.dart';
import 'package:flutter_deep_dive/common/providers/pagination_provider.dart';
import 'package:flutter_deep_dive/common/utils/pagination_util.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PaginationListView extends ConsumerStatefulWidget {
  final StateNotifierProvider<PaginationProvider, CursorPaginationBase>
      provider;

  const PaginationListView({
    super.key,
    required this.provider,
  });

  @override
  ConsumerState<PaginationListView> createState() => _PaginationListViewState();
}

class _PaginationListViewState extends ConsumerState<PaginationListView> {
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
    return const Placeholder();
  }
}
