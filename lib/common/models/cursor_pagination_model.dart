import 'package:json_annotation/json_annotation.dart';

part 'cursor_pagination_model.g.dart';

abstract class CursorPaginationBase {}

class CursorPaginationError extends CursorPaginationBase {
  final String message;

  CursorPaginationError({required this.message});
}

class CursorPaginationLoading extends CursorPaginationBase {}

//새로고침을 했을 때 CursorPagination 상속
class CursorPaginationRefetching extends CursorPagination {
  CursorPaginationRefetching({
    required super.data,
    required super.meta,
  });
}

//추가 페이지 요청,
class CursorPaginationFetchingMore extends CursorPagination {
  CursorPaginationFetchingMore({
    required super.data,
    required super.meta,
  });
}

@JsonSerializable(genericArgumentFactories: true)
class CursorPagination<T> extends CursorPaginationBase {
  final CursorPaginationMeta meta;
  final List<T> data;

  CursorPagination({
    required this.meta,
    required this.data,
  });

  factory CursorPagination.fromJson(
          Map<String, dynamic> json, T Function(Object? json) fromJsonT) =>
      _$CursorPaginationFromJson(json, fromJsonT);
}

@JsonSerializable()
class CursorPaginationMeta {
  final int count;
  final bool? isNotLast;

  CursorPaginationMeta({
    required this.count,
    required this.isNotLast,
  });

  factory CursorPaginationMeta.fromJson(Map<String, dynamic> json) =>
      _$CursorPaginationMetaFromJson(json);
}
