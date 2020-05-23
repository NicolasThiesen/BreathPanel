
import 'package:flutter/material.dart';

class Card extends StatelessWidget {
  final Widget item;
  final bool text; 
  final double height;
  final String info;
  final double fontSize;
  Card(this.item,this.info,this.height,this.text,this.fontSize);
  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
       elevation: 14,
       shadowColor: Color(0x802196f3),
       borderRadius: BorderRadius.circular(24),
       child: Padding(
         padding: EdgeInsets.symmetric(horizontal: 10), 
         child: Column(
          mainAxisAlignment:  MainAxisAlignment.center,
          children: [
              Container(child: item,height: height,),
              text ? Center(child: Text("$info",style: TextStyle(fontSize: fontSize,fontWeight: FontWeight.bold),),)
              : Container(width: 0,height: 0,),
          ],
          ),
         ),
      );
    
  }

}

