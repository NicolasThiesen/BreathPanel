import 'package:app_breath/Widgets/PopUp.dart';
import 'package:flutter/material.dart';

class DashPopupMenu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
  return PopupMenuButton(
        color: Colors.white,
        itemBuilder: (BuildContext context){
          return PopUpMenu.choices.map((String choice){
            return PopupMenuItem<String>(
              value: choice,
              child: Text(choice),);
          }).toList();
        },
      );
  }
}
