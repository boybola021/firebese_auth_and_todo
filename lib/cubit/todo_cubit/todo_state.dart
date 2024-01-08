part of 'todo_cubit.dart';


abstract class TodoState extends Equatable {
  @override
  List<Object> get props => [];
}

class TodoInitial extends TodoState {}

class TodoLoadingState extends TodoState{}

class TodoStateGetAllTodo extends TodoState{
  final List<Todo> todos;
   TodoStateGetAllTodo({required this.todos});
  @override
  List<Object> get props => [todos];
}

class TodoCreateState extends TodoState{
  final Todo todo;
   TodoCreateState({required this.todo});
  @override
  List<Object> get props => [todo];
}

class TodoOfflineCreateState extends TodoState{
  final List<Todo> todos;
  TodoOfflineCreateState({required this.todos});
  @override
  List<Object> get props => [todos];
}

class TodoEditState extends TodoState{}

class TodoDeleteState extends TodoState {}

class TodoFailureState extends TodoState{
  final String message;
   TodoFailureState({required this.message});
}
