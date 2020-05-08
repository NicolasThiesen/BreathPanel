import 'package:app_breath/helpers/database_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_gauge/flutter_gauge.dart';
import 'package:flutter_sparkline/flutter_sparkline.dart';
import 'package:charts_flutter/flutter.dart' as charts;

import 'Models/Dados.dart';
class Dashboard extends StatefulWidget {
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  var data = [0.0,10.0,20.0,30.0,40.0,50.0,50.0,50.0,50.0,50.0,50.0,40.0,30.0,20.0,10.0,0.0];
  var index = 59;
  var timestamp = new DateTime.now().microsecondsSinceEpoch -10000000;
  DatabaseHelper db = DatabaseHelper();

  List<Dados> dados = List<Dados>();

  @override
  void initState(){
    print(timestamp.runtimeType);
    super.initState();
    db.getItems(timestamp).then((lista){
      print(lista);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(
          "BreathPainel",
          style: TextStyle(color: Colors.white,),
          ),
        ),
        backgroundColor: Colors.green,
        ),
        body: SafeArea(
          child:  StaggeredGridView.count(
            crossAxisCount: 4,
            crossAxisSpacing: 15.0,
            mainAxisSpacing: 0,
            padding: EdgeInsets.symmetric(horizontal: 50, vertical: 30),
            children: <Widget>[
                FlutterGauge(circleColor: Colors.green,index:50 ,counterStyle : TextStyle(color: Colors.black,fontSize: 30,),secondsMarker: SecondsMarker.secondsAndMinute,number: Number.endAndCenterAndStart,),
                FlutterGauge(circleColor: Colors.green,index: 40.0,counterStyle : TextStyle(color: Colors.black,fontSize: 30,),secondsMarker: SecondsMarker.secondsAndMinute,number: Number.endAndCenterAndStart,),
                Padding(padding:  EdgeInsets.symmetric(horizontal: 100, vertical: 50), child: Sparkline(data: data,fillColor: Colors.green,sharpCorners: true,lineColor: Colors.green,),),
                Center(child: Text("Nível de oxigênio",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),),
                Center(child: Text("Quantidade de Oxigênio",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),),
                Center(child: Text("Gráfico de respiração",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),),
                Center(child: Text("$timestamp"),)
            ],  
            staggeredTiles: [
              StaggeredTile.extent(1, 225),
              StaggeredTile.extent(1, 225),
              StaggeredTile.extent(2, 225),
              StaggeredTile.extent(1, 50),
              StaggeredTile.extent(1, 50),
              StaggeredTile.extent(2, 50),
              StaggeredTile.extent(2, 50),
              StaggeredTile.extent(2, 50),

            ],
            )
        ),
    );
  }
}