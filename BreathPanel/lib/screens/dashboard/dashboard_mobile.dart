import 'package:app_breath/screens/add_device.dart';
import 'package:app_breath/screens/dashboard/dashboard_bloc.dart';

import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';


import 'package:syncfusion_flutter_gauges/gauges.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import 'package:usb_serial/usb_serial.dart';

import 'package:app_breath/Widgets/Card.dart' as card;

import 'linear_pression.dart';


DashBoardBloc bloc = DashBoardBloc();
class DashboardMobilePortrait extends StatefulWidget {
  final UsbDevice device;
  DashboardMobilePortrait({this.device,});
  @override
  _DashboardMobilePortraitState createState() => _DashboardMobilePortraitState();
}

class _DashboardMobilePortraitState extends State<DashboardMobilePortrait> {

  @override
  void initState(){
    super.initState();
    if(widget.device == null){
      Navigator.push(context,MaterialPageRoute(builder: (context) => AddDevice()),);
    }
    bloc.connectTo(widget.device);
      }
  @override
  void dispose() {
    super.dispose();
    bloc.connectTo(null);
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
        "BreathPanel",
        style: TextStyle(color: Colors.white,fontSize: 25),
        ),
        centerTitle: true,
        backgroundColor: Theme.of(context).primaryColor,
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
                  card.Card(SfRadialGauge(
                    axes: <RadialAxis>[
                      RadialAxis(
                        minorTicksPerInterval: 9,
                        minimum: 0,
                        maximum: 50,
                        axisLabelStyle: GaugeTextStyle(
                        fontSize: 15, 
                        fontWeight: FontWeight.bold, ),
                        ranges: <GaugeRange>[
                          GaugeRange(startValue: 3, endValue: 30, color:Theme.of(context).primaryColor),
                          GaugeRange(startValue: 0,endValue: 3,color: Colors.orange),
                          GaugeRange(startValue: 30,endValue: 50,color: Colors.red)],
                        pointers: <GaugePointer>[
                          NeedlePointer(value: bloc.peep)],
                        annotations: <GaugeAnnotation>[
                          GaugeAnnotation(widget: Container(child: 
                            Text('${bloc.peep}',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold))),
                            angle: 90, positionFactor: 0.5
                          )]
                        )]),"Peep",225,true,20),
                  card.Card(Column(mainAxisAlignment:  MainAxisAlignment.center,children:[ Text("${bloc.porc_oxi}",style: TextStyle(fontSize: 50))]),"Porcentagem de Oxigênio",100,true,13),
                  card.Card(Column(mainAxisAlignment:  MainAxisAlignment.center,children:[ Text("${bloc.porc_pausa}%",style: TextStyle(fontSize: 50))]), "Porcentagem de Pausa",100,true,13),
                  card.Card(Column(mainAxisAlignment:  MainAxisAlignment.center,children:[ Text("${bloc.volume_tidal}",style: TextStyle(fontSize: 50))]), "Volume Tidal",100,true,13),
                  card.Card(Column(mainAxisAlignment:  MainAxisAlignment.center,children:[ Text("${bloc.frequencia}",style: TextStyle(fontSize: 50))]), "Frequência",100,true,13),
                  card.Card(Column(mainAxisAlignment:  MainAxisAlignment.center,children:[ Text("${bloc.pressao_max}",style: TextStyle(fontSize: 50))]), "Pressão máxima",100,true,13),
                  card.Card(Column(mainAxisAlignment:  MainAxisAlignment.center,children:[ Text("${bloc.temp_insp}",style: TextStyle(fontSize: 50))]), "Tempo Inspiratório(s)",100,true,13 ),
                  card.Card(Column( children:[
                    Container(
                      height: 300,
                      child: SfCartesianChart(
                        title: ChartTitle(
                          text: "Pressão/Segundos",
                          alignment: ChartAlignment.center,                  
                          textStyle: ChartTextStyle(
                          color: Colors.black,
                          fontFamily: 'Roboto',
                          fontWeight: FontWeight.bold,
                          fontSize: 13,
                      )),
                      tooltipBehavior: TooltipBehavior(
                        enable: true,
                        shouldAlwaysShow: true,
                        animationDuration: 100,
                        duration: 6000
                      ),
                        legend: Legend(isVisible: true,position: LegendPosition.bottom),
                        series: <ChartSeries>[
                          FastLineSeries<LinearPression, double>(enableTooltip: true,isVisibleInLegend: true,name: "Pressão/Segundos", legendItemText: "cm/H2O",animationDuration: 0.0,color: Theme.of(context).primaryColor, dataSource: bloc.pressao_graph,width: 3.0, xValueMapper: (LinearPression pression, _) => pression.second,yValueMapper: (LinearPression pression, _) => pression.value),
                        ]
                      ),
                    )
                  ]),"",300,false,13),
                  card.Card(Column(children:[
                     SfCartesianChart(
                       title: ChartTitle(
                          text: "Fluxo/Segundos",
                          alignment: ChartAlignment.center,                  
                          textStyle: ChartTextStyle(
                          color: Colors.black,
                          fontFamily: 'Roboto',
                          fontWeight: FontWeight.bold,
                          fontSize: 13,
                      )),
                      legend: Legend(isVisible: true,position: LegendPosition.bottom),
                      tooltipBehavior: TooltipBehavior(
                        enable: true
                      ),
                      series: <ChartSeries>[
                        FastLineSeries<LinearPression, double>(enableTooltip: true,isVisibleInLegend: true,name: "Fluxo/Segundos", legendItemText: "Litros/Minuto",animationDuration: 0.0,color: Theme.of(context).primaryColor, dataSource: bloc.fluxo_graph,width: 3.0, xValueMapper: (LinearPression pression, _) => pression.second,yValueMapper: (LinearPression pression, _) => pression.value),
                      ]
                    )
                  ]),"Fluxo/Tempo",300,false,13),
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

class DashboardMobileLandscape extends StatefulWidget {
  final UsbDevice device;
  DashboardMobileLandscape({this.device,});
  @override
  _DashboardMobileLandscapeState createState() => _DashboardMobileLandscapeState();
}

class _DashboardMobileLandscapeState extends State<DashboardMobileLandscape> {

  @override
  void initState(){
    super.initState();
    if(widget.device == null){
      Navigator.push(context,MaterialPageRoute(builder: (context) => AddDevice()),);
    }
    bloc.connectTo(widget.device);
      }
  @override
  void dispose() {
    super.dispose();
    bloc.connectTo(null);
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
        "BreathPanel",
        style: TextStyle(color: Colors.white,fontSize: 25),
        ),
        centerTitle: true,
        backgroundColor: Theme.of(context).primaryColor,
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
                  card.Card(SfRadialGauge(
                    axes: <RadialAxis>[
                      RadialAxis(
                        minorTicksPerInterval: 9,
                        minimum: 0,
                        maximum: 50,
                        axisLabelStyle: GaugeTextStyle(
                        fontSize: 15, 
                        fontWeight: FontWeight.bold, ),
                        ranges: <GaugeRange>[
                          GaugeRange(startValue: 3, endValue: 30, color:Theme.of(context).primaryColor),
                          GaugeRange(startValue: 0,endValue: 3,color: Colors.orange),
                          GaugeRange(startValue: 30,endValue: 50,color: Colors.red)],
                        pointers: <GaugePointer>[
                          NeedlePointer(value: bloc.peep)],
                        annotations: <GaugeAnnotation>[
                          GaugeAnnotation(widget: Container(child: 
                            Text('${bloc.peep}',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold))),
                            angle: 90, positionFactor: 0.5
                          )]
                        )]),"Peep",225,true,13),
                  card.Card(Column(mainAxisAlignment:  MainAxisAlignment.center,children:[ Text("${bloc.porc_oxi}",style: TextStyle(fontSize: 45))]),"Porcentagem de Oxigênio",100,true,13),
                  card.Card(Column(mainAxisAlignment:  MainAxisAlignment.center,children:[ Text("${bloc.porc_pausa}%",style: TextStyle(fontSize: 45))]), "Porcentagem de Pausa",100,true,13),
                  card.Card(Column(mainAxisAlignment:  MainAxisAlignment.center,children:[ Text("${bloc.volume_tidal}",style: TextStyle(fontSize: 45))]), "Volume Tidal",100,true,13),
                  card.Card(Column(mainAxisAlignment:  MainAxisAlignment.center,children:[ Text("${bloc.frequencia}",style: TextStyle(fontSize: 45))]), "Frequência",100,true,13),
                  card.Card(Column(mainAxisAlignment:  MainAxisAlignment.center,children:[ Text("${bloc.pressao_max}",style: TextStyle(fontSize: 45))]), "Pressão máxima",100,true,13),
                  card.Card(Column(mainAxisAlignment:  MainAxisAlignment.center,children:[ Text("${bloc.temp_insp}",style: TextStyle(fontSize: 45))]), "Tempo Inspiratório(s)",100,true,13 ),
                  card.Card(Column( children:[
                    Container(
                      height: 300,
                      child: SfCartesianChart(
                        title: ChartTitle(
                          text: "Pressão/Segundos",
                          alignment: ChartAlignment.center,                  
                          textStyle: ChartTextStyle(
                          color: Colors.black,
                          fontFamily: 'Roboto',
                          fontWeight: FontWeight.bold,
                          fontSize: 13,
                      )),
                      tooltipBehavior: TooltipBehavior(
                        enable: true,
                        shouldAlwaysShow: true,
                        animationDuration: 100,
                        duration: 6000
                      ),
                        legend: Legend(isVisible: true,position: LegendPosition.bottom),
                        series: <ChartSeries>[
                          FastLineSeries<LinearPression, double>(enableTooltip: true,isVisibleInLegend: true,name: "Pressão/Segundos", legendItemText: "cm/H2O",animationDuration: 0.0,color: Theme.of(context).primaryColor, dataSource: bloc.pressao_graph,width: 3.0, xValueMapper: (LinearPression pression, _) => pression.second,yValueMapper: (LinearPression pression, _) => pression.value),
                        ]
                      ),
                    )
                  ]),"",300,false,13),
                  card.Card(Column(children:[
                     SfCartesianChart(
                       title: ChartTitle(
                          text: "Fluxo/Segundos",
                          alignment: ChartAlignment.center,                  
                          textStyle: ChartTextStyle(
                          color: Colors.black,
                          fontFamily: 'Roboto',
                          fontWeight: FontWeight.bold,
                          fontSize: 13,
                      )),
                      legend: Legend(isVisible: true,position: LegendPosition.bottom),
                      tooltipBehavior: TooltipBehavior(
                        enable: true
                      ),
                      series: <ChartSeries>[
                        FastLineSeries<LinearPression, double>(enableTooltip: true,isVisibleInLegend: true,name: "Fluxo/Segundos", legendItemText: "Litros/Minuto",animationDuration: 0.0,color: Theme.of(context).primaryColor, dataSource: bloc.fluxo_graph,width: 3.0, xValueMapper: (LinearPression pression, _) => pression.second,yValueMapper: (LinearPression pression, _) => pression.value),
                      ]
                    )
                  ]),"Fluxo/Tempo",300,false,13),
                  Container(height: 50,width: MediaQuery.of(context).size.width,color: Theme.of(context).primaryColor,
                    child: Row(mainAxisAlignment: MainAxisAlignment.center,children: [Text("InjeVent",style: TextStyle(color: Colors.white,fontSize: 23, fontFamily: "Roboto", fontWeight: FontWeight.bold),)],),)
                  
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
          )
        );
  }
  
}