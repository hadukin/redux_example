import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'todo_entity.freezed.dart';

@freezed
class TodoEntity with _$TodoEntity {
  factory TodoEntity({
    required UniqueKey id,
    required String title,
  }) = _TodoEntity;
}
