import 'package:dartz/dartz.dart';
import 'package:firebase_ddd_resocoder/domain/core/failures.dart';
import 'package:firebase_ddd_resocoder/domain/core/value_objects.dart';
import 'package:firebase_ddd_resocoder/domain/notes/value_objects.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'todo_item.freezed.dart';

@freezed
abstract class TodoItem implements _$TodoItem {
  const TodoItem._();

  const factory TodoItem({
    required UniqueID id,
    required TodoName name,
    required bool done,
  }) = _TodoItem;

  factory TodoItem.empty() => TodoItem(
        id: UniqueID(),
        name: TodoName(''),
        done: false,
      );

  Option<ValueFailure<dynamic>> get failureOption {
    return name.value.fold((f) => some(f), (_) => none());
  }
}
