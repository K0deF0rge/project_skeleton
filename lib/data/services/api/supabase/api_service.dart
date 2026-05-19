import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../../core/logger.dart';
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

  Future<Result<List<T>>> get({
    List<SupabaseFilter>? filters,
    int? limit,
    int? offset,
    bool noLimit = false,
  }) async {
    try {
      AppLogger.debug("\n!!!!!API_SERVICE!!!!!");
      AppLogger.debug("api_service: Tablename $tableName");
      var query = supabase.from(tableName).select();

      if (filters != null) {
        for (var f in filters) {
          query = query.filter(f.field, f.operator.value, f.value);
        }
      }

      final bool useInternalPagination =
          !noLimit && limit == null && offset == null;

      AppLogger.debug("api_service: useInternalPagination $useInternalPagination limit $limit offset $offset");

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

      AppLogger.debug("api_service: result query $result");

      final data = (result as List<Map<String, dynamic>>).map<T>(fromJson).toList();

      AppLogger.debug("api_service: data ${data.runtimeType}");

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
      AppLogger.error('error PostgrestException', error, stackTrace: StackTrace.current);
      return Result.error(error);
    } on Exception catch (error) {
      AppLogger.error('error', error, stackTrace: StackTrace.current);
      return Result.error(error);
    }
  }

  Future<Result<T>> update(T model) async {
    try {
      AppLogger.debug('update model ${model.toJson()}');
      await supabase
          .from(tableName)
          .update(model.toJson())
          .eq('id', model.toJson()['id']);
      return Result.ok(model);
    } on PostgrestException catch (error) {
      return Result.error(error);
    } on Exception catch (error) {
      return Result.error(error);
    } catch (error) {
      return Result.error(Exception('Erro desconhecido'));
    }
  }

  Future<Result<T>> create(T model) async {
    try {
      await supabase.from(tableName).insert([model.toJson()]);
      return Result.ok(model);
    } on PostgrestException catch (error) {
      return Result.error(error);
    } on Exception catch (error) {
      return Result.error(error);
    } catch (error) {
      return Result.error(Exception('Erro desconhecido'));
    }
  }

  Future<Result<bool>> delete(String id) async {
    try {
      await supabase.from(tableName).delete().eq('id', id);
      return Result.ok(true);
    } on PostgrestException catch (error) {
      return Result.error(error);
    } on Exception catch (error) {
      return Result.error(error);
    } catch (error) {
      return Result.error(Exception('Erro desconhecido'));
    }
  }
}
