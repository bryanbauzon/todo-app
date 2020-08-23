import 'package:flutter/material.dart';

class Todos{
  int id;
  String priority;
  String title;
  String description;
  String updDate;

  Todos({
    Key key,
    @required this.id,
    @required this.priority,
    @required this.title,
    @required this.description,
    @required this.updDate,
  });

  Todos.fromMap(Map<String, dynamic>map){
    id  = map['id'];
    priority = map['priority'];
    title = map['title'];
    description = map['description'];
    updDate = map['updDate'];
  }

  Map<String, dynamic>toMap(){
    var map = <String, dynamic>{
      'id':id,
      'priority':priority,
      'title':title,
      'description':description,
      'updDate':updDate,
    };
    return map;
  }
}