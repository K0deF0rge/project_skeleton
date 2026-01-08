
import '../../core/logger.dart';

abstract class BaseModel {
  Map<String, dynamic> toJson();
  BaseModel toModel(Map<String, dynamic> json);
  Map<String, dynamic> get map => toJson();
  
  void _validateField(String fieldName){
    if (!map.containsKey(fieldName)) {
      throw ArgumentError('Campo $fieldName não existe em Model');
    }
  }

  void setValue<T>(String fieldName, String value) {
    AppLogger.debug('Setting $fieldName to $value');
    _validateField(fieldName);
  }

  T getValue<T>(String fieldName) {
    _validateField(fieldName);
    return map[fieldName];
  }
}