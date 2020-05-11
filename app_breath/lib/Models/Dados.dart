class Dados{
  int timestamp;
  double graph_pressao;
  double fluxo;
  double volume_tidal;
  double frequencia;
  double oxigenio;
  double pressao_max;
  double peep;
  double tempo_insp;
  double perc_pausa;

  Dados(this.timestamp,this.graph_pressao,this.fluxo,this.volume_tidal,this.frequencia,this.oxigenio,this.pressao_max,this.peep,this.tempo_insp,this.perc_pausa);

  Map<String,dynamic> toMap(){
    var map = <String,dynamic>{
      "timestamp": timestamp,
      "graph_pressao": graph_pressao,
      "fluxo": fluxo,
      "volume_tidal": volume_tidal,
      "frequencia": frequencia,
      "oxigenio": oxigenio,
      "pressao_max":pressao_max,
      "peep": peep,
      "tempo_insp": tempo_insp,
      "perc_pausa": perc_pausa
    };
    return map;
  }

  Dados.fromMap(Map<String,dynamic> map){
    timestamp = map["timestamp"]; 
    graph_pressao = map["graph_pressao"];
    fluxo = map["fluxo"];
    volume_tidal = map["volume_tidal"];
    frequencia = map["frequencia"];
    oxigenio = map["oxigenio"];
    pressao_max = map["pressao_max"];
    peep = map["peep"];
    perc_pausa = map["perc_pausa"];
  }
}