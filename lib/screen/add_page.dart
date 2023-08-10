import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/services/todo_service.dart';
import 'package:http/http.dart' as http;

import '../utils/snackbar_helper.dart';

class AddTodoPage extends StatefulWidget {
  final Map? todo;
  const AddTodoPage({Key? key, this.todo}) : super(key: key);

  @override
  _AddTodoPageState createState() => _AddTodoPageState();
}

class _AddTodoPageState extends State<AddTodoPage> {
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  bool isEdit = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    final todo = widget.todo;
    if(todo != null){
      isEdit = true;
      final title = todo['title'];
      final description = todo['description'];
      titleController.text = title;
      descriptionController.text = description;
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(isEdit? 'Edit Todo':'Add Todo'),
      ),
      body: ListView(
        padding: EdgeInsets.all(20),
        children: [
          TextField(
            controller: titleController,
            decoration: InputDecoration(hintText: 'Title'),
          ),
          TextField(
            controller: descriptionController,
            decoration: InputDecoration(hintText: 'Description'),
            keyboardType: TextInputType.multiline,
            minLines: 5,
            maxLines: 8,
          ),
          SizedBox(
            height: 20,
          ),
          ElevatedButton(
            onPressed: isEdit? updateData: submitData,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(isEdit?'Update':'Submit')),
          )
        ],
      ),
    );
  }

  Future<void> updateData() async {
    final todo = widget.todo;
    if(todo == null ){
      print('You can not updated without todo data');
      return;
    }
    final id = todo['_id'];
    final isCompleted = todo['is_completed'];
    final title = titleController.text;
    final description = descriptionController.text;
    final body = {
      "title": title,
      "description": description,
      "is_complete": false,
    };
    final isSuccess = await TodoSevice.updateTodo(id, body);
    if (isSuccess) {      
      showSuccessMessage(context, message: 'Updation Success');
    } else {
      showErroMessage(context, message: 'Updation Failed');
    }
  }

  Future<void> submitData() async {
    final title = titleController.text;
    final description = descriptionController.text;
    final body = {
      "title": title,
      "description": description,
      "is_complete": false,
    };
    final isSuccess = await TodoSevice.addTodo(body);
    if (isSuccess) {
      print('Creation Success');
      titleController.text = '';
      descriptionController.text = '';
      showSuccessMessage(context, message: 'Creation Success');
    } else {
      print('Creation Failed');
      showErroMessage(context, message: 'Creation Failed');
    }
  }
}
