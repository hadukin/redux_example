import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:redux_example/features/todo/domain/entity/todo_entity.dart';

part 'state.freezed.dart';

@freezed
class TodoState with _$TodoState {
  const factory TodoState({
    @Default(false) bool isLoading,
    @Default([]) List<TodoEntity> todos,
    UniqueKey? deleteId,
    String? error,
  }) = _TodoState;
}
