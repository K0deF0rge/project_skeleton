import 'dart:convert';

import '../../../../utils/result.dart';
import '../../../core/logger.dart';
import '../../../domain/models/base.dart';
import 'shared_preferences.dart';

class LocalService<T extends BaseModel> {
  LocalService(this._key, {required this.toModel});
  final String _key;
  final T Function(Map<String, dynamic>) toModel;

  String _map(T model){
    return jsonEncode(model.toJson());
  }

  Map<String, dynamic> _model(String json) => jsonDecode(json) as Map<String, dynamic>;

  FutureResult save(T model, {String key = ''}) async {
    final k = '$_key${key.isNotEmpty ? '_$key' : ''}';
    try {
      AppLogger.debug("\nLocalServicee: K $k - map ${_map(model)}");

      final succeded = await sharedPreferences.setString(
        k,
        _map(model),
      );

      AppLogger.debug("\nLocalServicee: succeded $succeded");
      if (!succeded) {
        return Result.error(Exception('Failed to save user data'));
      }

      return const Result.ok(null);
    } on Exception catch (e) {
      return Result.error(e);
    } catch (e) {
      return Result.error(Exception('Erro desconhecido'));
    }
  }

  Result<T> get({String key = ''}) {
    final k = '$_key${key.isNotEmpty ? '_$key' : ''}';
    try {
      AppLogger.debug("\nLocalServicee: get $k");
      String? response = sharedPreferences.getString(k);

      if (response == null) {
        return Result.error(Exception('No data found for key $k'));
      }

      AppLogger.debug("LocalServicee: response get $response");

      final model = toModel(_model(response));

      return Result.ok(model);
    } on Exception catch (e) {
      return Result.error(e);
    } catch (e) {
      return Result.error(Exception('Erro desconhecido'));
    }
  }

  FutureResult saveArray(List<T> models, {String key = ''}) async {
    final k = '$_key${key.isNotEmpty ? '_$key' : ''}';

    if (models.isEmpty) {
      return Result.error(Exception('No models to save'));
    }

    List<String> jsonList = models.map(_map).toList();

    try {
      final successed = await sharedPreferences.setStringList(k, jsonList);

      if (!successed) {
        return Result.error(Exception('Failed to save user data'));
      }

      return const Result.ok(null);
    } on Exception catch (e) {
      return Result.error(e);
    } catch (e) {
      return Result.error(Exception('Erro desconhecido'));
    }
  }

  Result<List<T>> getArray({String key = ''}) {
    final k = '$_key${key.isNotEmpty ? '_$key' : ''}';

    try {
      final List<String>? response = sharedPreferences.getStringList(k);

      if (response == null) {
        return Result.error(Exception('No data found for key $k'));
      }

      final List<Map<String, dynamic>> jsonStrings = response.map(_model).toList();
      final models = jsonStrings.map(toModel).toList();

      return Result.ok(models);
    } on Exception catch (e) {
      return Result.error(e);
    } catch (e) {
      return Result.error(Exception('Erro desconhecido'));
    }
  }
}
