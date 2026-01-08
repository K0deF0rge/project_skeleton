// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'role.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Role _$RoleFromJson(Map<String, dynamic> json) {
  $checkKeys(json, requiredKeys: const ['id']);
  return Role(
    (json['id'] as num).toInt(),
    userId: json['user_id'] as String,
    module: $enumDecode(_$ModulesEnumMap, json['module']),
    canRead: json['can_read'] as bool? ?? false,
    canWrite: json['can_write'] as bool? ?? false,
    canDelete: json['can_delete'] as bool? ?? false,
  );
}

Map<String, dynamic> _$RoleToJson(Role instance) => <String, dynamic>{
  'id': instance.id,
  'user_id': instance.userId,
  'module': _$ModulesEnumMap[instance.module]!,
  'can_read': instance.canRead,
  'can_write': instance.canWrite,
  'can_delete': instance.canDelete,
};

const _$ModulesEnumMap = {Modules.products: 'products', Modules.users: 'users'};
