import 'package:firebase_ddd_resocoder/domain/core/value_objects.dart';
import 'package:firebase_ddd_resocoder/domain/notes/todo_item.dart';
import 'package:firebase_ddd_resocoder/domain/notes/value_objects.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'todo_item_presentation_classes.freezed.dart';

@freezed
abstract class TodoItemPrimitive implements _$TodoItemPrimitive {
  const TodoItemPrimitive._();
  const factory TodoItemPrimitive({
    required UniqueID id,
    required String name,
    required bool done,
  }) = _TodoItemPrimitive;

  factory TodoItemPrimitive.empty() =>
      TodoItemPrimitive(id: UniqueID(), name: '', done: false);

  factory TodoItemPrimitive.fromDomain(TodoItem todoItem) {
    return TodoItemPrimitive(
      id: todoItem.id,
      name: todoItem.name.getOrCrash(),
      done: todoItem.done,
    );
  }

  TodoItem toDomain() {
    return TodoItem(
      id: id,
      name: TodoName(name),
      done: done,
    );
  }
}
