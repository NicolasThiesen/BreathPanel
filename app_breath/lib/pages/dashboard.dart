import 'dart:async';
import 'dart:ffi';
import 'dart:typed_data';

import 'package:app_breath/Models/Dados.dart';
import 'package:app_breath/helpers/database_helper.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_sparkline/flutter_sparkline.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:syncfusion_flutter_gauges/gauges.dart';
import 'package:usb_serial/transaction.dart';
import 'package:usb_serial/usb_serial.dart';

import 'graph_dashboard.dart';

class Dashboard extends StatefulWidget {
  UsbDevice device;
  Dashboard({this.device,});
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  UsbPort _port;
  String _status = "Connected";
  List<Widget> _serialData = [];
  StreamSubscription<String> _subscription;
  Transaction<String> _transaction;
  int _deviceId;

  List data;
  var porc_oxi = 0.0;
  var pressao_max=0.0;
  var porc_pausa=0.0;
  var volume_tidal=0.0;
  var frequencia=0.0;
  var peep=0.0;
  var temp_insp=0.0;
  var pressao=0.0;
  var fluxo=0.0;
  var pressao_pico = 0.0;
  var timestamp = new DateTime.now().microsecondsSinceEpoch -10000000;
  DatabaseHelper db = DatabaseHelper();



  Future insertDB(line) async {
    await db.insertItems(line);
    setState(() {
      data.add(line);
      print(data);
    });
  }

  Future<bool> connectTo(device) async {
    _serialData.clear();

    if (_subscription != null) {
      _subscription.cancel();
      _subscription = null;
    }

    if (_transaction != null) {
      _transaction.dispose();
      _transaction = null;
    }

    if (_port != null) {
      _port.close();
      _port = null;
    }

    if (device == null) {
      _deviceId = null;
      setState(() {
        _status = "Disconnected";
      });
      return true;
    }

    _port = await device.create();
    if (!await _port.open()) {
      setState(() {
        _status = "Failed to open port";
      });
      return false;
    }

    _deviceId = device.deviceId;
    await _port.setDTR(true);
    await _port.setRTS(true);
    await _port.setPortParameters(
        115200, UsbPort.DATABITS_8, UsbPort.STOPBITS_1, UsbPort.PARITY_NONE);

    _transaction = Transaction.stringTerminated(
        _port.inputStream, Uint8List.fromList([13, 10]));
    
    _subscription = _transaction.stream.listen((String line) {
      setState(() {
        data = line.split(","); 
        try{
          porc_oxi = double.parse(data[0]);
          pressao_max = double.parse(data[1]);
          pressao = double.parse(data[2]);
          fluxo = double.parse(data[3]);
          porc_pausa = double.parse(data[4]);
          volume_tidal = double.parse(data[5]);
          frequencia = double.parse(data[6]);
          peep = double.parse(data[7]);
          temp_insp = double.parse(data[8]);
        }catch (e){
          print(e);
        }
        
        
      });
    });

    setState(() {
      _status = "Connected";
    });
    return true;
  }


  @override
  void initState(){
    print(timestamp.runtimeType);
    super.initState();
    connectTo(widget.device);
      }
  @override
  void dispose() {
    super.dispose();
    connectTo(null);
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
        "BreathPainel",
        style: TextStyle(color: Colors.white,),
        ),
        centerTitle: true,
        actions: <Widget>[
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 0),
            child: Container(
              width: 300,
              height: 30,
              child: Center(
                child: Text("Respirador: InjeVent",style: TextStyle(fontSize: 23,fontWeight: FontWeight.bold),),
              ),
            ),
            )
        ],
        backgroundColor: Colors.green,
        ),
        body: SafeArea(
          child: StaggeredGridView.count( 
            crossAxisCount: 8,
            crossAxisSpacing: 15.0,
            mainAxisSpacing: 10.0,
            padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            children: <Widget>[
              Card(SfRadialGauge(
                axes: <RadialAxis>[
                  RadialAxis(
                    minorTicksPerInterval: 9,
                    minimum: 0,
                    maximum: 50,
                    axisLabelStyle: GaugeTextStyle(
                    fontSize: 17, 
                    fontWeight: FontWeight.bold, ),
                    ranges: <GaugeRange>[
                      GaugeRange(startValue: 3, endValue: 30, color:Colors.green),
                      GaugeRange(startValue: 0,endValue: 3,color: Colors.orange),
                      GaugeRange(startValue: 30,endValue: 50,color: Colors.red)],
                    pointers: <GaugePointer>[
                      NeedlePointer(value: peep)],
                    annotations: <GaugeAnnotation>[
                      GaugeAnnotation(widget: Container(child: 
                        Text('$peep',style: TextStyle(fontSize: 37,fontWeight: FontWeight.bold))),
                        angle: 90, positionFactor: 0.5
                      )]
                    )]),"Peep",225),
              Card(Column(mainAxisAlignment:  MainAxisAlignment.center,children:[ Text("$porc_oxi",style: TextStyle(fontSize: 60))]),"Porcentagem de Oxigênio",100),
              Card(Column(mainAxisAlignment:  MainAxisAlignment.center,children:[ Text("$porc_pausa%",style: TextStyle(fontSize: 60))]), "Porcentagem de Pausa",100),
              Card(Column(mainAxisAlignment:  MainAxisAlignment.center,children:[ Text("$volume_tidal",style: TextStyle(fontSize: 60))]), "Volume Tidal",100),
              Card(Column(mainAxisAlignment:  MainAxisAlignment.center,children:[ Text("$frequencia",style: TextStyle(fontSize: 60))]), "Frequência",100),
              Card(Column(mainAxisAlignment:  MainAxisAlignment.center,children:[ Text("$pressao_max",style: TextStyle(fontSize: 60))]), "Pressão máxima",100),
              Card(Column(mainAxisAlignment:  MainAxisAlignment.center,children:[ Text("$temp_insp",style: TextStyle(fontSize: 60))]), "Tempo Inspiratório(s)",100 ),
              Card(Column( mainAxisAlignment:  MainAxisAlignment.center,children:[Text("Pressão/Tempo")]),"Pressão/Tempo",100),
              Card(Column( mainAxisAlignment:  MainAxisAlignment.center,children:[Text("Fluxo/Tempo")]),"Fluxo/Tempo",100),
              
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
              ],
    ),
          )
        );
  }
  Material Card(Widget item, String info, double height){
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
              Container(child: item,height: height,),
              Center(child: Text("$info",style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),),
              
          ],
          ),
         ),
      );
    }
}