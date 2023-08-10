import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/screen/add_page.dart';
import 'package:flutter_application_1/services/todo_service.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../utils/snackbar_helper.dart';


class TodoList extends StatefulWidget {
  const TodoList({ Key? key }) : super(key: key);

  @override
  _TodoListState createState() => _TodoListState();
}

class _TodoListState extends State<TodoList> {
  bool isLoading = true;
  List items = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchTodo();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Todo List')),
      body: Visibility(
        visible: isLoading,
        child: Center(
          child: CircularProgressIndicator(),
        ),
        replacement: RefreshIndicator(
          onRefresh: fetchTodo, 
            child: ListView.builder(
            itemCount: items.length,
            padding: EdgeInsets.all(8),
            itemBuilder: (context, index){
            final item = items[index] as Map;
            final id = item['_id'] as String;
            return Card(
              child: ListTile(
                leading: CircleAvatar(child: Text('${index+1}'),),
                subtitle: Text(item['description']),
                title: Text(item['title']),
                trailing: PopupMenuButton(
                  onSelected: (value){
                    if(value == 'edit'){
                      navigateToEditPage(item);
                    }else if (value == 'delete'){
                      deleteById(id);
                    }
                  },
                  itemBuilder: (context){
                    return[
                      PopupMenuItem(child: Text('Edit'),
                      value: 'edit',),
                      PopupMenuItem(child: Text('Delete'),
                      value: 'delete',),
                      
                    ];
                  },
                ),),
            );
                  }),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(onPressed: navigateToAddPage, label: const Text('Add Todo')),
    );
  }

  Future<void> navigateToAddPage() async {
    await Get.to(AddTodoPage(),duration: Duration(milliseconds: 500),);
    setState(() {
      isLoading = true;
    });
    fetchTodo();
  }

  Future<void> navigateToEditPage(Map item) async {
    await Get.to(AddTodoPage(todo: item,));
    setState(() {
      isLoading = true;
    });
    fetchTodo();
  }

  Future<void> fetchTodo() async {
    final response = await TodoSevice.fetchTodos();
    if(response != null){
      setState(() {
        items = response;
      }); 
    }else{
      showErroMessage(context, message: 'Something went wrong');
    }
    setState(() {
      isLoading = false;
    });
    
  }

  Future<void> deleteById(String id) async {
    final isSuccess = await TodoSevice.deleteById(id);
    if(isSuccess){
      showSuccessMessage(context,message: 'Delete successful');
      final filtered = items.where((element) => element['_id'] != id).toList();
      setState(() {
        items = filtered;
      });
    }
    else{
      showErroMessage(context, message:'Deletion Failed');
    }
  }
}