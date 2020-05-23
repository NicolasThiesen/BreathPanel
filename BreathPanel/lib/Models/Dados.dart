class Dados{
  double timestamp;
  double porc_oxi;
  double fluxo;
  double volume_tidal;
  double frequencia;
  double temp_insp;
  double pressao_max;
  double peep;
  double tempo_insp;
  double perc_pausa;

  Dados(this.timestamp,this.porc_oxi,this.fluxo,this.volume_tidal,this.frequencia,this.temp_insp,this.pressao_max,this.peep,this.tempo_insp,this.perc_pausa);

  Map<String,dynamic> toMap(){
    var map = <String,dynamic>{
      "timestamp": timestamp,
      "porc_oxi": porc_oxi,
      "pressao_max": fluxo,
      "porc_pausa": volume_tidal,
      "volume_tidal": frequencia,
      "frequencia": temp_insp,
      "peep":pressao_max,
      "temp_insp": peep,
      "pressao": tempo_insp,
      "fluxo": perc_pausa
    };
    return map;
  }

  Dados.fromMap(Map<String,dynamic> map){
    timestamp = map["timestamp"]; 
    porc_oxi = map["porc_oxi"];
    fluxo = map["fluxo"];
    volume_tidal = map["volume_tidal"];
    frequencia = map["frequencia"];
    temp_insp = map["temp_insp"];
    pressao_max = map["pressao_max"];
    peep = map["peep"];
    perc_pausa = map["perc_pausa"];
  }
}