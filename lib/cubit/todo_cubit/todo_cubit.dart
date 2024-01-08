import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth_and_todo/models/todo_model.dart';
import 'package:firebase_auth_and_todo/services/realtime_database.dart';
import 'package:flutter/cupertino.dart';

part 'todo_state.dart';

class TodoCubit extends Cubit<TodoState> {
  TodoCubit() : super(TodoInitial());

  void getAllTodo()async{
    try{
      emit(TodoLoadingState());
      final todos = await RDTBService.getAllTodo();
      emit(TodoStateGetAllTodo(todos: todos));
    }catch(e){
      debugPrint("Error get all todos => $e");
      emit(TodoFailureState(message: e.toString()));
    }
  }
  void createTodo(Todo todo)async{
    try{
      emit(TodoLoadingState());
      final data = await RDTBService.addTodo(todo);
      emit(TodoStateGetAllTodo(todos: await RDTBService.getAllTodo()));
    }catch(e){
      debugPrint("Error create todo => $e");
      emit(TodoFailureState(message: e.toString()));
    }
  }
  void createOfflineTodo(Todo todo)async{
    try{
      emit(TodoLoadingState());
      emit(TodoOfflineCreateState(todos: [todo]));
    }catch(e){
      debugPrint("Error offline create todo => $e");
      emit(TodoFailureState(message: e.toString()));
    }
  }

  void editTodo(Todo todo)async{
    try{
      emit(TodoLoadingState());
      final data = await RDTBService.updateTodo(
        todo.id,
        todo.title,
        todo.description,
        todo.time,
        todo.isCompleted,
      );
      emit(TodoEditState());
    }catch(e){
      debugPrint("Error create todo => $e");
      emit(TodoFailureState(message: e.toString()));
    }
  }

  void deleteTodo(String id)async{
    try{
      emit(TodoLoadingState());
      await RDTBService.deleteTodo(id);
      emit(TodoDeleteState());
    }catch(e){
      debugPrint("Error create todo => $e");
      emit(TodoFailureState(message: e.toString()));
    }
  }
}
