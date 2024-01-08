
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../models/todo_model.dart';
import '../pages/detail_page.dart';

class KTListTile extends StatelessWidget {
  final Todo todo;
  final VoidCallback onPressed;
  const KTListTile({super.key,required this.todo,required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return  ListTile(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(builder: (context) => DetailPage(todo: todo,)));
      },
      leading: const Icon(Icons.edit_calendar,color: Colors.grey,size: 35,),
      title: Text(
        todo.title,
        style: const TextStyle(fontSize: 20),
      ),
      subtitle: Column(
        children: [
          const SizedBox(height: 10,),
          Row(
            children: [
              const Icon(Icons.watch_later_outlined),
              const SizedBox(width: 5,),
              Text(
                "${todo.time.hour}:${todo.time.minute < 10 ? "0${todo.time.minute}" : todo.time.minute}",
                style: const TextStyle(fontSize: 20),
              ),
            ],
          ),
          const SizedBox(height: 10,),
          const Row(
            children: [
              Icon(Icons.cloud_done_outlined),
              SizedBox(width: 5,),
              Text(
                "Change clouded",
                style: TextStyle(fontSize: 15),
              ),
            ],
          ),
        ],
      ),
      trailing: IconButton(
        onPressed: onPressed,
        icon: const Icon(CupertinoIcons.delete,color: Colors.red,),
      ),
    );
  }
}
