import 'dart:async';
import 'package:firebase_auth_and_todo/cubit/todo_cubit/todo_cubit.dart';
import 'package:firebase_auth_and_todo/pages/detail_page.dart';
import 'package:firebase_auth_and_todo/services/auth_service.dart';
import 'package:firebase_auth_and_todo/views/logout_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../views/custom_list_tile.dart';
import '../views/delate_account.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    BlocProvider.of<TodoCubit>(context).getAllTodo();
  }
  Future<void> deleteButton(BuildContext context,String id) async {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
        return AlertDialog.adaptive(
          title: const Text("Attention"),
          content: const Text("Your order has been received"),
          actions: [
            TextButton(
              onPressed: (){
                Navigator.pop(context);
              },
              child: const Text("No"),
            ),
            TextButton(
              onPressed: (){
                BlocProvider.of<TodoCubit>(context).deleteTodo(id);
                BlocProvider.of<TodoCubit>(context).getAllTodo();
                Navigator.pop(context);
              },
              child: const Text("Ok"),
            ),
          ],
        );
        });
  }

  @override
  void dispose() {
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text("Todos", style: TextStyle(fontSize: 28),),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: (){
            Navigator.push(
                context, MaterialPageRoute(builder: (builder) => const DetailPage()));
          },
          child: const Icon(Icons.add),
        ),
      drawer: Drawer(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            UserAccountsDrawerHeader(
              accountName: Text(
                AuthService.user.displayName ?? "No name",
                style:  const TextStyle(fontSize: 20,color: Colors.white),
              ),
              accountEmail: Text( AuthService.user.email ?? "No email",
                  style: const TextStyle(fontSize: 20,color: Colors.white)),
            ),
            const LogOutButton(),
            const DeleteUserButton(),
          ],
        ),
      ),
        body: BlocBuilder<TodoCubit, TodoState>(
          builder: (context, state) {
            debugPrint(state.runtimeType.toString());
           if(state is TodoStateGetAllTodo){
             return  ListView.builder(
               itemCount: state.todos.length,
               itemBuilder: (context, i) {
                 final todo = state.todos[i];
                 return Card(
                   margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                   color: Colors.white.withOpacity(0.2),
                   child: KTListTile(
                     todo: todo,
                     onPressed: () => deleteButton(context, todo.id),
                   ),
                 );
               },
             );
           }
           else if(state is TodoInitial || state is TodoLoadingState){
            return const Center(
              child: CircularProgressIndicator.adaptive(),
            );
           } else if(state is TodoEditState){
             BlocProvider.of<TodoCubit>(context).getAllTodo();
             return const SizedBox.shrink();
           }else{
             return const Center(
               child: Text("No Data",style: TextStyle(fontSize: 30),),
             );
           }
          },
        ),
    );
  }
}


