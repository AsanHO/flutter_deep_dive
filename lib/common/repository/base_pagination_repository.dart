import 'package:flutter_deep_dive/common/models/cursor_pagination_model.dart';
import 'package:flutter_deep_dive/common/models/model_with_id.dart';
import 'package:flutter_deep_dive/common/models/pagination_params.dart';


abstract class IBasePaginationRepository<T extends IModelWithId>{
  Future<CursorPagination<T>> paginate({
     PaginationParams? paginationParams = const PaginationParams(),
  });
}