import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../../domain/models/base.dart';
import '../../../../utils/result.dart';
import 'filters.dart';

class APIService<T extends BaseModel> extends ChangeNotifier {
  final SupabaseClient supabase;
  final String tableName;
  final T Function(Map<String, dynamic>) fromJson;

  APIService({required this.supabase, required this.tableName, required this.fromJson});

  User get userAuth => supabase.auth.currentUser!;

  static const int _pageSize = 20;
  int _offset = 0;
  bool _hasMore = true;

  void resetPagination() {
    _offset = 0;
    _hasMore = true;
  }

  bool get hasMore => _hasMore;

  FutureResult<List<T>> get({
    List<SupabaseFilter>? filters,
    int? limit,
    int? offset,
    bool noLimit = false,
  }) async {
    try {
      var query = supabase.from(tableName).select();

      if (filters != null) {
        for (var f in filters) {
          query = query.filter(f.field, f.operator.value, f.value);
        }
      }

      final bool useInternalPagination =
          !noLimit && limit == null && offset == null;

      final dynamic result;
      if (noLimit) {
        result = await query;
      } else if (!useInternalPagination) {
        final int l = limit ?? _pageSize;
        final int o = offset ?? 0;
        result = await query.range(o, o + l - 1);
      } else {
        result = await query.range(_offset, _offset + _pageSize - 1);
      }

      final data = (result as List<Map<String, dynamic>>).map<T>(fromJson).toList();

      if (!noLimit) {
        if (useInternalPagination) {
          if (data.length < _pageSize) {
            _hasMore = false;
          } else {
            _offset += _pageSize;
          }
        }
      }

      return Result.ok(data);
    } on PostgrestException catch (error) {
      return Result.error(error);
    } on Exception catch (error) {
      return Result.error(error);
    } catch (error) {
      return Result.error(Exception(error));
    }
  }

  FutureResultVoid update(T model) async {
    try {
      await supabase
          .from(tableName)
          .update(model.toJson())
          .eq('id', model.toJson()['id']);
      return Result.ok(null);
    } on PostgrestException catch (error) {
      return Result.error(error);
    } on Exception catch (error) {
      return Result.error(error);
    } catch (error) {
      return Result.error(Exception(error));
    }
  }

  FutureResultVoid create(T model) async {
    try {
      await supabase.from(tableName).insert([model.toJson()]);
      return Result.ok(null);
    } on PostgrestException catch (error) {
      return Result.error(error);
    } on Exception catch (error) {
      return Result.error(error);
    } catch (error) {
      return Result.error(Exception(error));
    }
  }

  FutureResultVoid delete(String id) async {
    try {
      await supabase.from(tableName).delete().eq('id', id);
      return Result.ok(null);
    } on PostgrestException catch (error) {
      return Result.error(error);
    } on Exception catch (error) {
      return Result.error(error);
    } catch (error) {
      return Result.error(Exception(error));
    }
  }
}
