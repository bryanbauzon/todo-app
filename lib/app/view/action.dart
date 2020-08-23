import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:todo_list/app/common/commons.dart';
import 'package:todo_list/app/common/widgets.dart';
import 'package:todo_list/app/database/db_helper.dart';
import 'package:todo_list/app/model/todos.dart';
import 'package:todo_list/app/provider/provider.dart';
import 'package:todo_list/app/view/todo.dart';

enum FlagEvent{urgent,high,med,low}

class FlagColorChangerBloc extends Bloc<FlagEvent,Color>{
  FlagColorChangerBloc() : super(Commons().urgentPriority);

  @override
  Stream<Color> mapEventToState(FlagEvent event)async*{
    switch(event){
      case FlagEvent.urgent:
        yield Commons().urgentPriority;
        break;
       case FlagEvent.high:
        yield Commons().highPriority;
        break;
       case FlagEvent.med:
        yield Commons().mediumPriority;
        break;
       case FlagEvent.low:
        yield Commons().lowPriority;
        break;
    }
  }
  @override
  void onChange(Change<Color> change) {
    print(change);
    super.onChange(change);
  }
}
class ActionsScreen extends StatefulWidget{
  final String title;
  ActionsScreen({
    Key key,
    @required this.title
  }):super(key:key);

  @override
  _ActionsScreenState createState() => _ActionsScreenState();
}
class _ActionsScreenState extends State<ActionsScreen>{

   final _formKey = GlobalKey<FormState>();
  String dropdownValue = Commons().urgent;
  TextEditingController _titleController;
  TextEditingController _descriptionController;
  var dbHelper;

  @override
  void initState(){
    super.initState();
    dbHelper = DBHelper();
    _titleController = TextEditingController();
    _descriptionController = TextEditingController();
  }

  Widget priorities(BuildContext context)=>DropdownButton<String>(
                      value: dropdownValue,
                      icon: Icon(Icons.arrow_drop_down),
                      iconSize: 24,
                      elevation: 16,
                      style: TextStyle(color: Commons().appColor),
                      onChanged: (String newValue) {
                        if(newValue ==  Commons().urgent){
                              context.bloc<FlagColorChangerBloc>().add(FlagEvent.urgent);
                        }else if(newValue ==  Commons().high){
                             context.bloc<FlagColorChangerBloc>().add(FlagEvent.high);
                        }else if(newValue ==  Commons().med){
                             context.bloc<FlagColorChangerBloc>().add(FlagEvent.med);
                        }else if(newValue ==  Commons().low){
                             context.bloc<FlagColorChangerBloc>().add(FlagEvent.low);
                        }
                       
                        setState(() {
                          dropdownValue = newValue;
                        });
                      },
                    items: <String>[Commons().urgent,Commons().high, Commons().med, Commons().low]
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                   );

  Widget textfield(String textFieldName,bool isDescription, TextEditingController controller)=>
  Padding(
    padding: const EdgeInsets.only(top:10),
    child: TextFormField(
    keyboardType: !isDescription?TextInputType.text:TextInputType.multiline,
    maxLines: !isDescription?1:5,
    validator: (text){
      return text.isEmpty?textFieldName+ " is empty.":null;
    },
    controller: controller,
     decoration: InputDecoration(
      labelText: textFieldName,
      enabledBorder:OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(10)),
         borderSide: BorderSide(width: 1,color:Commons().appColor),
      ),
     focusedBorder:OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(10)),
         borderSide: BorderSide(width: 1,color:Commons().appColor),
      ),
     errorBorder:OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(10)),
         borderSide: BorderSide(width: 1,color:Commons().error),
      ),
    focusedErrorBorder:OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(10)),
         borderSide: BorderSide(width: 1,color:Commons().appColor),
      ),
     ),
  ),
  );

  @override
  Widget build(BuildContext context) {
    final DateFormat formatter = DateFormat('dd MMMM yyyy hh:mm');
    final String formattedDate = formatter.format(Commons().currentDate);
    return BlocProvider(
      create: (_)=>FlagColorChangerBloc(),
      child: Scaffold(
      body: WillPopScope(
        child: BlocBuilder<FlagColorChangerBloc, Color>(
          builder: (context,state){
             return Column(
          children: [
            Widgets().appbar(context, widget.title, false),
           Padding(padding: const EdgeInsets.only(left:20,right:20,top:10),
            child: Form(
                key: _formKey,
                child: Column(
                  children: [
                   Align(
                     alignment: Alignment.centerLeft,
                     child: Container(
                     width: 170,
                     child: Row(
                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                     children: [
                       Icon(Icons.flag,
                        color: state,
                       ),
                       Text(Commons().priority,
                        style: TextStyle(
                          fontWeight: FontWeight.bold
                        ),
                       ), priorities(context)
                     ],
                    ),
                   ),
                   ),
                    textfield(Commons().title,false,_titleController),
                    textfield(Commons().description,true,_descriptionController),

                    Padding(
                      padding: const EdgeInsets.only(top:10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(formattedDate,
                          style: TextStyle(
                            color: Commons().dateColor,
                          ),
                          ),
                          Column(
                            children: [
                             // Text(Commons().developer),
                              Text(Commons().emailDeveloper, style: TextStyle(
                            color: Commons().dateColor,
                            fontSize: 12
                          ),)
                            ],
                          )
                        ],
                      )
                    ),
                
                    
                  ],
                ),
              ),
           ),
           Expanded(
                      child: Container(
                        height: MediaQuery.of(context).size.height,
                        width: MediaQuery.of(context).size.width,
                        child: Align(
                      alignment: Alignment.bottomCenter,
                      child:  Container(
                        height: 60,
                        child: GestureDetector(
                          onTap: (){
                            if(_formKey.currentState.validate()){
                              Todos todos = Todos(
                                id:null,
                                priority:dropdownValue ,
                                title: _titleController.text,
                                description: _descriptionController.text,
                                updDate:formattedDate
                              );
                               
                              Provider().createTodo(todos);
                                Widgets().navigateToScreen(context, Todo());
                              
                            }
                          },
                          child: Container(
                            height: 40,
                            decoration: BoxDecoration(
                              color:Commons().saveColor
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.check,
                                  color: Commons().white,
                                ),
                                SizedBox(width: 20,),
                                Text(Commons().save,
                              style:TextStyle(
                                color: Commons().white,
                                fontWeight: FontWeight.bold
                              )
                            ),
                              ],
                            )
                          )
                          ),
                      )
                    ),
                      ),
                    )
          ],
        );
          },
        ),
        onWillPop: ()async=>false
    ),
    ),
    );
  }
  
}