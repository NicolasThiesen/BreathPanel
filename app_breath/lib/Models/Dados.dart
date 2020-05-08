class Dados{
  int timestamp;
  double nivel_oxi;
  double quant_oxi;
  double resp;
  double graph;

  Dados(this.timestamp,this.nivel_oxi,this.quant_oxi,this.resp,this.graph);

  Map<String,dynamic> toMap(){
    var map = <String,dynamic>{
      "timestamp": timestamp,
      "nivel_oxi": nivel_oxi,
      "quant_oxi": quant_oxi,
      "resp": resp,
      "graph": graph
    };
    return map;
  }

  Dados.fromMap(Map<String,dynamic> map){
    timestamp = map["timestamp"]; 
    nivel_oxi = map["nivel_oxi"];
    quant_oxi = map["quant_oxi"];
    resp = map["resp"];
    graph = map["graph"];
  }
}