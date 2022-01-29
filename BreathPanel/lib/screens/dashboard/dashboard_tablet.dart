import 'package:app_breath/Widgets/popUpMenu.dart';
import 'package:app_breath/screens/add_device.dart';
import 'package:app_breath/screens/dashboard/dashboard_bloc.dart';
import 'package:app_breath/screens/modes/Landscape/modes_tablet.dart';
import 'package:app_breath/screens/modes/Portrait/modes_tablet.dart';

import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';


import 'package:usb_serial/usb_serial.dart';

DashBoardBloc bloc = DashBoardBloc();
class DashboardTabletPortrait extends StatefulWidget {
  @override
  _DashboardTabletPortraitState createState() => _DashboardTabletPortraitState();
}

class _DashboardTabletPortraitState extends State<DashboardTabletPortrait> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        title: Text(
        "BreathPanel",
        style: TextStyle(color: Colors.white,fontSize: 25),
        ),
        centerTitle: true,
        backgroundColor: Theme.of(context).primaryColor,
        actions: [
          DashPopupMenu()
        ],
        ),
        body: SafeArea(
          child: StreamBuilder(
            stream: bloc.output,
            builder: (context, snapshot) {
              return StaggeredGridView.count( 
                crossAxisCount: 8,
                crossAxisSpacing: 15.0,
                mainAxisSpacing: 5.0,
                padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                children: <Widget>[
                  ...bloc.cards,
                  Container(height: 50,width: MediaQuery.of(context).size.width,color: Theme.of(context).primaryColor,
                    child: Row(mainAxisAlignment: MainAxisAlignment.center,children: [Text("InjeVent",style: TextStyle(color: Colors.white,fontSize: 23, fontFamily: "Roboto", fontWeight: FontWeight.bold),)],),)
                  
                ],  
                staggeredTiles: [
                  StaggeredTile.extent(4, 300),
                  StaggeredTile.extent(4, 150),
                  StaggeredTile.extent(4, 150),
                  StaggeredTile.extent(4, 150),
                  StaggeredTile.extent(4, 150),
                  StaggeredTile.extent(4, 150),
                  StaggeredTile.extent(4, 150),
                  StaggeredTile.extent(8, 300),
                  StaggeredTile.extent(8, 300),
                  StaggeredTile.extent(8, 50),
                  ],
            );
          }
        ),
      )
    );
  }
  
}

class DashboardTabletLandscape extends StatefulWidget {
  @override
  _DashboardTabletLandscapeState createState() => _DashboardTabletLandscapeState();
}

class _DashboardTabletLandscapeState extends State<DashboardTabletLandscape> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        title: Text(
        "BreathPanel",
        style: TextStyle(color: Colors.white,fontSize: 25),
        ),
        centerTitle: true,
        backgroundColor: Theme.of(context).primaryColor,
        actions: [
          DashPopupMenu()
        ],
        ),
        body: Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        title: Text(
        "BreathPanel",
        style: TextStyle(color: Colors.white,fontSize: 25),
        ),
        centerTitle: true,
        backgroundColor: Theme.of(context).primaryColor,
        actions: [
          DashPopupMenu()
        ],
        ),
        body: SafeArea(
          child: StreamBuilder(
            stream: bloc.output,
            builder: (context, snapshot) {
              return StaggeredGridView.count( 
                crossAxisCount: 8,
                crossAxisSpacing: 15.0,
                mainAxisSpacing: 5.0,
                padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                children: <Widget>[
                  ...bloc.cards,
                  Container(height: 50,width: MediaQuery.of(context).size.width,color: Theme.of(context).primaryColor,
                    child: Row(mainAxisAlignment: MainAxisAlignment.center,children: [Text("InjeVent",style: TextStyle(color: Colors.white,fontSize: 23, fontFamily: "Roboto", fontWeight: FontWeight.bold),)],),)
                  
                ],  
                staggeredTiles: [
                  StaggeredTile.extent(4, 300),
                  StaggeredTile.extent(4, 150),
                  StaggeredTile.extent(4, 150),
                  StaggeredTile.extent(4, 150),
                  StaggeredTile.extent(4, 150),
                  StaggeredTile.extent(4, 150),
                  StaggeredTile.extent(4, 150),
                  StaggeredTile.extent(8, 300),
                  StaggeredTile.extent(8, 300),
                  StaggeredTile.extent(8, 50),
                  ],
            );
          }
        )
      ))
    );
  }
  
}