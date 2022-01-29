import 'package:app_breath/screens/dashboard/dashboard_bloc.dart';
import 'package:app_breath/screens/dashboard/linear_pression.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';
import 'package:app_breath/Widgets/Card.dart' as card;

DashBoardBloc bloc = DashBoardBloc();

class CardsItems{
  static Color color; 
  Widget volume_tidal(fontSize,height,fontSizeB){
    return card.Card(Column(mainAxisAlignment:  MainAxisAlignment.center,children:[ Text("${bloc.volume_tidal}",style: TextStyle(fontSize: fontSize))]), "Volume Tidal",height,true,fontSizeB);
  }
  Widget frequencia(fontSize,height,fontSizeB){
    return card.Card(Column(mainAxisAlignment:  MainAxisAlignment.center,children:[ Text("${bloc.frequencia}",style: TextStyle(fontSize: fontSize))]), "Frequência",height,true,fontSizeB);
  }
  Widget porc_oxi(fontSize,height,fontSizeB){
    return card.Card(Column(mainAxisAlignment:  MainAxisAlignment.center,children:[ Text("${bloc.porc_oxi}",style: TextStyle(fontSize: fontSize))]),"Porcentagem de Oxigênio",height,true,fontSizeB);
  }
  Widget pressao_maxima(fontSize,height,fontSizeB){
    return card.Card(Column(mainAxisAlignment:  MainAxisAlignment.center,children:[ Text("${bloc.pressao_max}",style: TextStyle(fontSize: fontSize))]), "Pressão máxima",height,true,fontSizeB);
  }
  Widget peep(fontSize,height,fontSizeB,fontSizeC){
    return card.Card(SfRadialGauge(
      axes: <RadialAxis>[
        RadialAxis(
          minorTicksPerInterval: 9,
          minimum: 0,
          maximum: 50,
          axisLabelStyle: GaugeTextStyle(
          fontSize: fontSize, 
          fontWeight: FontWeight.bold, ),
          ranges: <GaugeRange>[
            GaugeRange(startValue: 3, endValue: 30, color:color),
            GaugeRange(startValue: 0,endValue: 3,color: Colors.orange),
            GaugeRange(startValue: 30,endValue: 50,color: Colors.red)],
          pointers: <GaugePointer>[
            NeedlePointer(value: bloc.peep)],
          annotations: <GaugeAnnotation>[
            GaugeAnnotation(widget: Container(child: 
              Text('${bloc.peep}',style: TextStyle(fontSize: fontSizeB,fontWeight: FontWeight.bold))),
              angle: 90, positionFactor: 0.5
            )]
          )]),"Peep",height,true,fontSizeC);
  }
  Widget tempo_inspiratorio(fontSize,height,fontSizeB){
    return card.Card(Column(mainAxisAlignment:  MainAxisAlignment.center,children:[ Text("${bloc.temp_insp}",style: TextStyle(fontSize: fontSize))]), "Tempo Inspiratório(s)",height,true,fontSizeB );
  }
  Widget tempo_pausa(fontSize,height,fontSizeB){
    return card.Card(Column(mainAxisAlignment:  MainAxisAlignment.center,children:[ Text("${bloc.temp_insp}",style: TextStyle(fontSize: fontSize))]), "Tempo Pausa(s)",height,true,fontSizeB );
  }
  Widget plato(fontSize,height,fontSizeB){
    return card.Card(Column(mainAxisAlignment:  MainAxisAlignment.center,children:[ Text("${bloc.temp_insp}",style: TextStyle(fontSize: fontSize))]), "Pressão Platô",height,true,fontSizeB );
  }
  Widget volume_min(fontSize,height,fontSizeB){
    return card.Card(Column(mainAxisAlignment:  MainAxisAlignment.center,children:[ Text("${bloc.temp_insp}",style: TextStyle(fontSize: fontSize))]), "Tempo Inspiratório(s)",height,true,fontSizeB );
  }
  Widget volume_inspiratorio(fontSize,height,fontSizeB){
    return card.Card(Column(mainAxisAlignment:  MainAxisAlignment.center,children:[ Text("${bloc.temp_insp}",style: TextStyle(fontSize: fontSize))]), "Tempo Inspiratório(s)",height,true,fontSizeB );
  }
  Widget trigger_pressao(fontSize,height,fontSizeB){
    return card.Card(Column(mainAxisAlignment:  MainAxisAlignment.center,children:[ Text("${bloc.temp_insp}",style: TextStyle(fontSize: fontSize))]), "Tempo Inspiratório(s)",height,true,fontSizeB );
  }
  Widget chart(fontSize, height,title,titleB,legend, fontSizeB){
    card.Card(Column( children:[
      Container(
        height: height,
        child: SfCartesianChart(
          title: ChartTitle(
            text: title,
            alignment: ChartAlignment.center,                  
            textStyle: ChartTextStyle(
            color: Colors.black,
            fontFamily: 'Roboto',
            fontWeight: FontWeight.bold,
            fontSize: fontSize,
        )),
        tooltipBehavior: TooltipBehavior(
          enable: true,
          shouldAlwaysShow: true,
          animationDuration: 100,
          duration: 6000
        ),
          legend: Legend(isVisible: true,position: LegendPosition.bottom),
          series: <ChartSeries>[
            FastLineSeries<LinearPression, double>(enableTooltip: true,isVisibleInLegend: true, legendItemText: legend,animationDuration: 0.0,color: color, dataSource: bloc.pressao_graph,width: 3.0, xValueMapper: (LinearPression pression, _) => pression.second,yValueMapper: (LinearPression pression, _) => pression.value),
          ]
        ),
      )
    ]),titleB,height,false,fontSizeB);
  }
}