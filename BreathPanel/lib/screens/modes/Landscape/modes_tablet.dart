import 'package:app_breath/screens/dashboard/dashboard_bloc.dart';
import 'package:app_breath/screens/dashboard/linear_pression.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';
import 'package:app_breath/Widgets/Card.dart' as card;

DashBoardBloc bloc = DashBoardBloc();


class PSVLandscapeTablet extends StatelessWidget {
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
                  card.Card(SfRadialGauge(
                    axes: <RadialAxis>[
                      RadialAxis(
                        minorTicksPerInterval: 9,
                        minimum: 0,
                        maximum: 50,
                        axisLabelStyle: GaugeTextStyle(
                        fontSize: 17, 
                        fontWeight: FontWeight.bold, ),
                        ranges: <GaugeRange>[
                          GaugeRange(startValue: 3, endValue: 30, color:Theme.of(context).primaryColor),
                          GaugeRange(startValue: 0,endValue: 3,color: Colors.orange),
                          GaugeRange(startValue: 30,endValue: 50,color: Colors.red)],
                        pointers: <GaugePointer>[
                          NeedlePointer(value: bloc.peep)],
                        annotations: <GaugeAnnotation>[
                          GaugeAnnotation(widget: Container(child: 
                            Text('${bloc.peep}',style: TextStyle(fontSize: 37,fontWeight: FontWeight.bold))),
                            angle: 90, positionFactor: 0.5
                          )]
                        )]),"Peep",225,true,17),
                  card.Card(Column(mainAxisAlignment:  MainAxisAlignment.center,children:[ Text("${bloc.porc_oxi}",style: TextStyle(fontSize: 60))]),"Porcentagem de Oxigênio",100,true,17),
                  card.Card(Column(mainAxisAlignment:  MainAxisAlignment.center,children:[ Text("${bloc.porc_pausa}%",style: TextStyle(fontSize: 60))]), "Porcentagem de Pausa",100,true,17),
                  card.Card(Column(mainAxisAlignment:  MainAxisAlignment.center,children:[ Text("${bloc.volume_tidal}",style: TextStyle(fontSize: 60))]), "Volume Tidal",100,true,17),
                  card.Card(Column(mainAxisAlignment:  MainAxisAlignment.center,children:[ Text("${bloc.frequencia}",style: TextStyle(fontSize: 60))]), "Frequência",100,true,17),
                  card.Card(Column(mainAxisAlignment:  MainAxisAlignment.center,children:[ Text("${bloc.pressao_max}",style: TextStyle(fontSize: 60))]), "Pressão máxima",100,true,17),
                  card.Card(Column(mainAxisAlignment:  MainAxisAlignment.center,children:[ Text("${bloc.temp_insp}",style: TextStyle(fontSize: 60))]), "Tempo Inspiratório(s)",100,true,17 ),
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
                  ]),"",300,false,17),
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
                  ]),"Fluxo/Tempo",300,false,17),
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
                  StaggeredTile.extent(4, 300),
                  StaggeredTile.extent(4, 300),
                  StaggeredTile.extent(8, 50),
                  ],
    );
            }
          ),
          );
  }
}

class VCVLandscapeTablet extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      
    );
  }
}


class PCVLandscapeTablet extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      
    );
  }
}

class ACLandscapeTablet extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      
    );
  }
}