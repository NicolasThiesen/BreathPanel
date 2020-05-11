import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:charts_flutter/flutter.dart' as charts;

class GraphDashboard extends StatefulWidget {
  final List<double> pressao;
  final List<double> fluxo;
  GraphDashboard({this.pressao,this.fluxo});
  @override
  _GraphDashboardState createState() => _GraphDashboardState();
}

class _GraphDashboardState extends State<GraphDashboard> {
  @override
  Widget build(BuildContext context) {
    return  StaggeredGridView.count(
      crossAxisCount: 7,
      crossAxisSpacing: 15.0,
      mainAxisSpacing: 15.0,
      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
        children: <Widget>[
          Container(),
          Card(Column( mainAxisAlignment:  MainAxisAlignment.center,children:[Text("Pressão/Tempo")]),"Pressão/Tempo"),
          Container(),
          Container(),
          Card(Column( mainAxisAlignment:  MainAxisAlignment.center,children:[Text("Fluxo/Tempo")]),"Fluxo/Tempo"),
          Container(),

            
        ],  
        staggeredTiles: [
          StaggeredTile.extent(1, 300),
          StaggeredTile.extent(5, 300),
          StaggeredTile.extent(1, 300),
          StaggeredTile.extent(1, 300),
          StaggeredTile.extent(5, 300),
          StaggeredTile.extent(1, 300),



        ],
      );
  }
  Material Card(Widget item, String info){
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
              Center(child: Text("$info",style: TextStyle(fontSize: 23,fontWeight: FontWeight.bold),),),
              Container(child: item,height: 225,),
              
          ],
          ),
         ),
      );
  }
}