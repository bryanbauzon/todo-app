import 'package:flutter/material.dart';
import 'package:todo_list/app/common/commons.dart';
import 'package:todo_list/app/common/widgets.dart';
import 'package:todo_list/app/database/db_helper.dart';
import 'package:todo_list/app/model/todos.dart';
import 'package:todo_list/app/provider/provider.dart';
import 'package:todo_list/app/view/action.dart';
class Todo extends StatefulWidget{
  @override
  _TodoState createState() =>_TodoState();
}
class _TodoState extends State<Todo>{

  var dbHelper;
  Future<List<Todos>>getTodoList;

  @override
  void initState(){
    super.initState();
    dbHelper = DBHelper();
    setState(() {
      getTodoList = Provider().getTodoList();
    });
  }
 Color flagChanger(String val){
    if(val == Commons().urgent){
     return Commons().urgentPriority; 
    }else if(val == Commons().high){
     return Commons().highPriority; 
    }else if(val == Commons().med){
     return Commons().mediumPriority; 
    }
  return Commons().lowPriority; 
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WillPopScope(
        child: Column(
          children: [
            Widgets().appbar(context, Commons().appName,true),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Container(
                  child: FutureBuilder<List<Todos>>(
                    future: getTodoList,
                    builder: (context, snapshot){
                       if(snapshot.connectionState != ConnectionState.done){

                      }
                      if(snapshot.hasError){
                        print("ERROR!!");
                        print(snapshot.error);
                        print(snapshot.hashCode);
                      }

                      List<Todos> todoList = snapshot.data??[];

                      return ListView.builder(
                        itemCount: todoList.length,
                        itemBuilder: (context,index){
                          Todos todo = todoList[index];
                          return Padding(
                            padding: const EdgeInsets.only(top:5),
                            child: Container(
                            height: 120,
                            decoration: BoxDecoration(
                              border:Border.all(color:Commons().appColor,),
                              borderRadius: BorderRadius.circular(20)
                            ),
                            child:Padding(
                              padding: const EdgeInsets.only(left:20),
                              child:  Row(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Icon(Icons.flag,color: flagChanger(todo.priority),),
                                  Column(
                                   mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                     Text(todo.title,
                                      style:TextStyle(
                                        color: Commons().appColor,
                                        fontWeight: FontWeight.w400,
                                        fontSize: 20
                                      )
                                    ),
                                   Divider(
                                     height: 5,
                                     color: Commons().appColor,
                                   ),
                                    Text(todo.description,
                                      style:TextStyle(
                                        fontWeight: FontWeight.w300,
                                        fontSize: 14
                                      )
                                    ),
                                     Text(todo.updDate,
                                        style:TextStyle(
                                        fontWeight: FontWeight.w300,
                                        fontSize: 12
                                      )
                                )
                                  ],
                                ),
                               IconButton(
                                 icon: Icon(Icons.delete_outline,
                                  color: Commons().appColor,
                                 ),
                                 onPressed: (){
                                   Provider().deleteTodoById(todo.id);
                                   setState(() {
                                    getTodoList = Provider().getTodoList();
                                  });
                                 },
                               )
                               
                              ],
                            ),
                            )
                          ),
                          );
                      });
                    },
                  ),
                ),
              ),
            )
          ],
        ),
        onWillPop: ()async=> false
      ),
      floatingActionButton: FloatingActionButton(
        tooltip: 'Add Todo',
        onPressed: (){
          Widgets().navigateToScreen(context, ActionsScreen(title: Commons().appName,));
        },
        backgroundColor: Commons().appColor,
        child: Center(
          child: Icon(Icons.add),
        ),
      ),
    );
  }
}