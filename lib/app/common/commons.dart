import 'package:flutter/material.dart';

class Commons{
  Commons();
  String appName = "Todo List";
  Color appColor = Color(0XFF436ca8);
  Color white = Color(0XFFf3f3f3);

  String title = "Title";
  String description = "Description";
  String save = "Save";
  String developer = "Developed by: Max Bryan C. Bauzon";
  String emailDeveloper = "mrbryanbauzon@gmail.com";
  var  currentDate = DateTime.now();

  //priority Color and Strings
  String priority = "Priority: ";
  Color lowPriority = Color(0XFF36cf32);
  Color mediumPriority = Color(0xffcfc232);
  Color highPriority = Color(0XFFcf7832);
  Color urgentPriority = Color(0xffcf3232);

  Color saveColor = Color(0XFF255499);
  Color dateColor = Color(0XFF595959);


  Color error = Color(0XFFe61e1e);

  String low = "Low Priority";
  String med = "Medium Priority";
  String high = "High Priority";
  String urgent = "Urgent Priority";
}