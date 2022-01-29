import 'package:app_breath/screens/dashboard/dashboard_bloc.dart';
import 'package:app_breath/screens/dashboard/linear_pression.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';
import 'package:app_breath/Widgets/Card.dart' as card;
import 'package:app_breath/Widgets/CardsItems.dart';


class Cards{
  static Color color;
  List<Widget> vsv(screen,orientation){
    if(orientation=="portrait"){
      if(screen=="tablet"){
        return [
          CardsItems().peep(17, 180, 20, 20), 
          CardsItems().volume_tidal(45, 80,13),
          CardsItems().frequencia(45, 80,13),
          CardsItems().porc_oxi(45, 80, 13), 
          CardsItems().pressao_maxima(45, 80,13),
          CardsItems().tempo_inspiratorio(45, 80,13),
          CardsItems().tempo_pausa(45, 80,13),
          CardsItems().chart(13, 300, "Pressão/Segundos", "", "cm/H2O", 17),
          CardsItems().chart(13, 300, "Fluxo/Segundos", "Fluxo/Tempo", "Litros/Minuto", 17)
          ];
      }
      else if(screen=="mobile"){
        return [
          CardsItems().peep(15, 225, 20, 20), 
          CardsItems().volume_tidal(50, 100,13),
          CardsItems().frequencia(50, 100,13),
          CardsItems().porc_oxi(50, 100, 13), 
          CardsItems().pressao_maxima(50, 100,13),
          CardsItems().tempo_inspiratorio(50, 100,13),
          CardsItems().tempo_pausa(50, 100,13),
          CardsItems().chart(13, 300, "Pressão/Segundos", "", "cm/H2O", 13),
          CardsItems().chart(13, 300, "Fluxo/Segundos", "Fluxo/Tempo", "Litros/Minuto", 13)
        ];
      }else if(screen=="smallPhone"){
        return [
          CardsItems().peep(15, 225, 20,13), 
          CardsItems().volume_tidal(40, 100,13),
          CardsItems().frequencia(40, 100,13),
          CardsItems().porc_oxi(40, 100, 13), 
          CardsItems().pressao_maxima(40, 100,13),
          CardsItems().tempo_inspiratorio(40, 100,13),
          CardsItems().tempo_pausa(40, 100,13),
          CardsItems().chart(13, 300, "Pressão/Segundos", "", "cm/H2O", 13),
          CardsItems().chart(13, 300, "Fluxo/Segundos", "Fluxo/Tempo", "Litros/Minuto", 13)
        ];
      }
    }else{
      if(screen=="tablet"){
        return [
          CardsItems().peep(17, 225, 37, 17), 
          CardsItems().volume_tidal(60, 100,17),
          CardsItems().frequencia(60, 100,17),
          CardsItems().porc_oxi(60, 100,17), 
          CardsItems().pressao_maxima(60, 100,17),
          CardsItems().tempo_inspiratorio(60, 100,17),
          CardsItems().tempo_pausa(60, 100,17),
          CardsItems().chart(13, 300, "Pressão/Segundos", "", "cm/H2O", 17),
          CardsItems().chart(13, 300, "Fluxo/Segundos", "Fluxo/Tempo", "Litros/Minuto", 17)
          ];
      }
      else if(screen=="mobile"){
        return [
          CardsItems().peep(15, 225, 20, 13), 
          CardsItems().volume_tidal(45, 100, 13),
          CardsItems().frequencia(45, 100, 13),
          CardsItems().porc_oxi(45, 100, 13), 
          CardsItems().pressao_maxima(45, 100, 13),
          CardsItems().tempo_inspiratorio(45, 100, 13),
          CardsItems().tempo_pausa(45, 100, 13),
          CardsItems().chart(13, 300, "Pressão/Segundos", "", "cm/H2O", 13),
          CardsItems().chart(13, 300, "Fluxo/Segundos", "Fluxo/Tempo", "Litros/Minuto", 13)
        ];
      }else if(screen=="smallPhone"){
        return [
          CardsItems().peep(10, 125, 15,9), 
          CardsItems().volume_tidal(35, 100, 10),
          CardsItems().frequencia(35, 100, 10),
          CardsItems().porc_oxi(35, 100, 10), 
          CardsItems().pressao_maxima(35, 100, 10),
          CardsItems().tempo_inspiratorio(35, 100, 10),
          CardsItems().tempo_pausa(35, 100, 10),
          CardsItems().chart(13, 300, "Pressão/Segundos", "", "cm/H2O", 13),
          CardsItems().chart(13, 300, "Fluxo/Segundos", "Fluxo/Tempo", "Litros/Minuto", 13)
        ];
      }
    }
    
  }
  
} 
