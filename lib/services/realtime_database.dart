

import 'dart:convert';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:uuid/uuid.dart';
import '../models/todo_model.dart';

class RDTBService{
  static final _database = FirebaseDatabase.instance;


  static Future<bool> addTodo(Todo todo)async{
    final folder = _database.ref("todos");
    final child = folder.child(todo.id);
    await child.set(todo.toJson());
    return true;
  }

  static Future<List<Todo>> getAllTodo()async{
   final folder = _database.ref("todos");
   final data = await folder.get();
   final json = jsonDecode(jsonEncode(data.value)) as Map;
    return json.values.map((e) => Todo.fromJson(e as Map<String, Object?>)).toList();
  }

  static Future<bool> deleteTodo(String id)async{
    debugPrint(id);
    final folder =  _database.ref("todos").child(id);
     await folder.remove();
    return true;
  }

  static Future<bool> updateTodo(String id,String title,String desc,DateTime time,bool isCompleted)async{
   final folder =  _database.ref("todos");
   final data = folder.child(id).update({
     "title": title,
     "description": desc,
     "time": time,
     "isCompleted":isCompleted,
   });
    return true;
  }

}