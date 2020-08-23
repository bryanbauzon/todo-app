import 'package:flutter/material.dart';
import 'package:todo_list/app/common/commons.dart';
import 'package:todo_list/app/view/todo.dart';

class Widgets{
  Widgets();
  Widget appbar(BuildContext context,String headerTitle,bool isMain)=>
    SafeArea(
      child: Padding(
        padding: const EdgeInsets.only(top:10,left:10,right:10),
        child: Container(
        height: 45,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          color: Commons().appColor,
          borderRadius: BorderRadius.circular(50)
        ),
        child:Padding(
          padding: const EdgeInsets.only(left:20, right:20),
          child:  Row(
          children: [
            isMain?Icon(Icons.no_encryption,
              color:Commons().appColor
            ):IconButton(
              onPressed: (){
                  Widgets().navigateToScreen(context, Todo());
              },
              icon: Icon(Icons.arrow_back,
                 color:Commons().white
              ),
            ),
            Container(
              height: 40,
              width: 150,
              child:Center(
                child: Text(
                  headerTitle,
                  style: TextStyle(
                    color: Commons().white,
                    fontWeight: FontWeight.bold,
                    fontSize: 20
                  ),
                ),
              )
            )
          ],
        ),
        )
      ),
      )
    );

  navigateToScreen(BuildContext context,Widget screenDestination)=>
    Navigator.push(context, 
            MaterialPageRoute(builder: (_)=>screenDestination)
    );
}