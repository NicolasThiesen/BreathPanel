import 'dart:async';
import 'dart:typed_data';

import 'package:app_breath/Models/Dados.dart';
import 'package:app_breath/Widgets/Cards.dart';
import 'package:app_breath/helpers/database_helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:usb_serial/transaction.dart';
import 'package:usb_serial/usb_serial.dart';

import 'linear_pression.dart';


class DashBoardBloc{
  UsbPort _port;
  String _status = "Connected";
  List<Widget> _serialData = [];
  StreamSubscription<String> _subscription;
  Transaction<String> _transaction;
  int _deviceId;
  String mode; 

  List data;
  double last_update =DateTime.now().millisecondsSinceEpoch.toDouble() ;
  List<LinearPression> pressao_graph = List<LinearPression>();
  List<LinearPression> current_pressao_graph = List<LinearPression>();
  List<LinearPression> fluxo_graph = List<LinearPression>();
  List<LinearPression> current_fluxo_graph = List<LinearPression>();
  double new_time;
  int count = 0;

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

  DatabaseHelper db = DatabaseHelper();
  List<Dados> dados = List<Dados>();

  final StreamController _stream = StreamController.broadcast();

  Sink get input => _stream.sink;
  Stream get output => _stream.stream;

  List<Widget> cards;

  insertDB(timestamp,porc_oxi,pressao_max,pressao,fluxo,porc_pausa,volume_tidal,frequencia,peep,temp_insp) async {
    Dados d = Dados(timestamp,porc_oxi,pressao_max,porc_pausa,volume_tidal,frequencia,peep,temp_insp,pressao,fluxo);
    await db.insertItems(d);
  }

  Future<bool> connectTo(device,context,screen, orientation) async {
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
      _status = "Disconnected";
      input.add(_status);
      return true;
    }

    _port = await device.create();
    if (!await _port.open()) {
      _status = "Failed to open port";
      input.add(_status);
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
        data = line.split(","); 
        Cards.color = Theme.of(context).primaryColor;
        cards = Cards().vsv( screen, orientation);
        input.add(cards);
        try{
          mode = data[data.length-1];
          porc_oxi = double.parse(data[0]);
          pressao_max = double.parse(data[1]);
          pressao = double.parse(data[2]);
          fluxo = double.parse(data[3]);
          porc_pausa = double.parse(data[4]);
          volume_tidal = double.parse(data[5]);
          frequencia = double.parse(data[6]);
          peep = double.parse(data[7]);
          temp_insp = double.parse(data[8])/1000;

          if (count==300){
            pressao_graph = []..addAll(current_pressao_graph);
            fluxo_graph = []..addAll(current_fluxo_graph);
            count = 0;
            last_update = DateTime.now().millisecondsSinceEpoch.toDouble();
            current_pressao_graph = List<LinearPression>();
            current_fluxo_graph = List<LinearPression>();
            input.add(current_pressao_graph);
            input.add(current_fluxo_graph);
          }

          new_time = (DateTime.now().millisecondsSinceEpoch-last_update)/1000;
          insertDB(DateTime.now().millisecondsSinceEpoch.toDouble(),porc_oxi,pressao_max,pressao,fluxo,porc_pausa,volume_tidal,frequencia,peep,temp_insp);
          
          current_pressao_graph.add(LinearPression(new_time,pressao));
          current_fluxo_graph.add(LinearPression(new_time,fluxo));
          count+=1;
          input.add(porc_oxi);
          input.add(pressao_max);
          input.add(pressao);
          input.add(fluxo);
          input.add(porc_pausa);
          input.add(volume_tidal);
          input.add(frequencia);
          input.add(peep);
          input.add(temp_insp);
        }catch (e){
          print(e);
        }
    });
   _status = "Connected";
    input.add(_status);
    return true;
}
}