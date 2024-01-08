import 'package:firebase_auth_and_todo/cubit/todo_cubit/todo_cubit.dart';
import 'package:firebase_auth_and_todo/models/todo_model.dart';
import 'package:firebase_auth_and_todo/views/custom_text_fild.dart';
import 'package:firebase_auth_and_todo/views/scaffold_messages.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:uuid/uuid.dart';

class DetailPage extends StatefulWidget {
  final Todo? todo;
  const DetailPage({Key? key,this.todo}) : super(key: key);

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {

  final titleController = TextEditingController();
  final descController = TextEditingController();
  bool isLoading = false;
  bool isCheckInternet = true;

  void createTodo() async {
    String title = titleController.text;
    String description = descController.text;

    if(title.isEmpty || description.isEmpty) {
      KTScaffoldMessage.scaffoldMessage(context, "Field empty",);
      return;
    }
     if (widget.todo == null) {
       final todoCreate = Todo(id: const Uuid().v4(),
           title: title,
           description: description,
           time: DateTime.now(),
           isCompleted: false);
       if (todoCreate.title.isNotEmpty ||
           todoCreate.description.isNotEmpty && context.mounted) {
         KTScaffoldMessage.scaffoldMessage(
             context, "Successful create todo", color: Colors.green);
         debugPrint(todoCreate.toString());
         BlocProvider.of<TodoCubit>(context).createTodo(todoCreate);
         Navigator.of(context).pop("Done");
       }
     } else {
       KTScaffoldMessage.scaffoldMessage(
           context, "Successful edit todo", color: Colors.green);
       final todoEdit = Todo(id: widget.todo!.id,
         title: title,
         description: description,
         time: widget.todo!.time,
         isCompleted: widget.todo!.isCompleted,);
       BlocProvider.of<TodoCubit>(context).editTodo(todoEdit);
       Navigator.of(context).pop("Done");
     }
   }

  @override
  void initState() {
    super.initState();
    titleController.text = widget.todo?.title ?? "";
    descController.text = widget.todo?.description ?? "";
  }
 @override
  void dispose() {
    super.dispose();
    descController.dispose();
    titleController.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title:  Text(widget.todo == null ? "Create Todo" : "Edit Todo",style: const TextStyle(fontSize: 23),),
      ),
     body: Padding(
       padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 20),
       child: Column(
         mainAxisAlignment: MainAxisAlignment.center,
         children: [
          CustomTextField(controller: titleController, hintText: "title"),
          SizedBox(height: 15.h,),
          CustomTextField(controller: descController, hintText: "description"),
           const SizedBox(height: 15,),
           ElevatedButton(
               onPressed: createTodo,
             style: ElevatedButton.styleFrom(
               backgroundColor: Colors.blue,
               fixedSize: Size(
               MediaQuery.sizeOf(context).width * 2, 60),
             ),
               child: const Text("Save",style: TextStyle(fontSize: 23),),
           )
         ],
       ),
     ),
    );
  }
}


