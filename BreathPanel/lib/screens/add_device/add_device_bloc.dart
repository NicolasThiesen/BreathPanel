import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:usb_serial/usb_serial.dart';

class AddDeviceBloc {
  String status = "Idle";
  List<Widget> ports = [];
  UsbDevice main_device;
  int deviceId;

  final StreamController _stream = StreamController.broadcast();

  Sink get input => _stream.sink;
  Stream get output => _stream.stream;

  void getPorts() async {
    ports = [];
    List<UsbDevice> devices = await UsbSerial.listDevices();
    if(devices.length == 0){
      ports.add(Padding(padding: EdgeInsets.symmetric(vertical: 20),child: Text("Nenhum dispositivo encontrado...\nInsira um dispositivo!",style:TextStyle(color: Colors.white,fontSize: 17,fontWeight: FontWeight.bold))),);
      input.add(ports);
    }
    devices.forEach((device) {
      ports.add(ListTile(
          leading: Icon(Icons.usb,color: Colors.white,),
          title: Text("InjeVent",style: TextStyle(color: Colors.white,fontSize: 17,fontWeight: FontWeight.bold),),
          subtitle: Text(device.manufacturerName == null ? "arduino" : device.manufacturerName, style:TextStyle(color: Colors.white,fontSize: 17,fontWeight: FontWeight.bold)),
          trailing: RaisedButton(
            color: Colors.white,
            child:
                Text(deviceId == device.deviceId ? "Desconectar" : "Conectar",),
            onPressed: () {
              if(status == "Idle"){
                main_device=device;
                status = "Connected";
                deviceId = device.deviceId;
                input.add(status);
                input.add(deviceId);
                input.add(main_device);
                getPorts();
            }else{
                main_device=null;
                status = "Idle";
                deviceId = null;
                input.add(status);
                input.add(deviceId);
                input.add(main_device);
                getPorts();
            }
              print(status);

              }
              
          )));
      input.add(ports);
    });
    
  }
  @override
  void dispose() {
    _stream.close();
  }

}