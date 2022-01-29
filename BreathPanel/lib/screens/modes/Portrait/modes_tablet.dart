import 'package:app_breath/screens/dashboard/dashboard_bloc.dart';
import 'package:app_breath/screens/dashboard/linear_pression.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';
import 'package:app_breath/Widgets/Card.dart' as card;

DashBoardBloc bloc = DashBoardBloc();

class PSVPortraitTablet extends StatefulWidget {
  @override
  _PSVPortraitTabletState createState() => _PSVPortraitTabletState();
}

class _PSVPortraitTabletState extends State<PSVPortraitTablet> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
          child: StreamBuilder(
            stream: bloc.output,
            builder: (context, snapshot) {
              return StaggeredGridView.count( 
                crossAxisCount: 8,
                crossAxisSpacing: 15.0,
                mainAxisSpacing: 5.0,
                padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                children: <Widget>[
                  
                ],  
                staggeredTiles: [
                  StaggeredTile.extent(2, 300),
                  StaggeredTile.extent(2, 150),
                  StaggeredTile.extent(2, 150),
                  StaggeredTile.extent(2, 150),
                  StaggeredTile.extent(2, 150),
                  StaggeredTile.extent(2, 150),
                  StaggeredTile.extent(2, 150),
                  StaggeredTile.extent(8, 300),
                  StaggeredTile.extent(8, 300),
                  StaggeredTile.extent(8, 50),
                  ],
    );
            }
          ),
          );
  }
}

class VCVPortraitTablet extends StatefulWidget {
  @override
  _VCVPortraitTabletState createState() => _VCVPortraitTabletState();
}

class _VCVPortraitTabletState extends State<VCVPortraitTablet> {
  @override
  Widget build(BuildContext context) {
    return Container(
    );
  }
}

class PCVPortraitTablet extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      
    );
  }
}


class ACPortraitTablet extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      
    );
  }
}
