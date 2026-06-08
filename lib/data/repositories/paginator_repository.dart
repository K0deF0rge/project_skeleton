import '../../domain/models/base.dart';
import '../../utils/result.dart';
import '../services/api/supabase/api_service.dart';
import '../services/api/supabase/filters.dart';

class RepositoryPaginator<T extends BaseModel> {
  final APIService<T>? service;
  final int pageSize;

  int _offset = 0;
  bool _hasMore = true;
  bool _isLoading = false;
  final Filter _filter = Filter();

  RepositoryPaginator({required this.service, this.pageSize = 20});

  bool get hasMore => _hasMore;
  bool get isLoading => _isLoading;

  void reset() {
    _offset = 0;
    _hasMore = true;
    _isLoading = false;
  }

  Future<Result<List<T>>> nextPage() async {
    if (!_hasMore || _isLoading) return Result.ok([]);
    _isLoading = true;
    try {
      if (service == null) return Result.ok([]);

      final res = await service!.get(
        filters: _filter.filters,
        limit: pageSize,
        offset: _offset,
      );

      if (res is Error<List<T>>) {
        return res;
      }

      final items = (res as Ok<List<T>>).value;
      if (items.length < pageSize) {
        _hasMore = false;
      } else {
        _offset += pageSize;
      }

      return Result.ok(items);
    } finally {
      _isLoading = false;
    }
  }
}
