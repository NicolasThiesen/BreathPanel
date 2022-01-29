import "package:flutter/material.dart";

class ApplicationToolbar extends StatelessWidget with PreferredSizeWidget{
  @override
  Widget build(BuildContext context) {
    return AppBar(
        title: Text(
        "BreathPanel",
        style: TextStyle(color: Colors.white,fontSize: 25),
        ),
        centerTitle: true,
        backgroundColor: Theme.of(context).primaryColor,
        actions: [
          PopupMenuButton(itemBuilder: null)
        ],
        );
  }
  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}