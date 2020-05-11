import 'dart:async';


import 'package:app_breath/pages/dashboard.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:usb_serial/usb_serial.dart';

void main() => runApp(AddDevice());

class AddDevice extends StatefulWidget {
  @override
  _AddDeviceState createState() => _AddDeviceState();
}

class _AddDeviceState extends State<AddDevice> {

  String _status = "Idle";
  List<Widget> _ports = [];
  UsbDevice _device;
  int _deviceId;



  void _getPorts() async {
    _ports = [];
    List<UsbDevice> devices = await UsbSerial.listDevices();
    print("All devices: $devices");

    devices.forEach((device) {
      _ports.add(ListTile(
          leading: Icon(Icons.usb),
          title: Text("Arduino"),
          subtitle: Text(device.manufacturerName),
          trailing: RaisedButton(
            child:
                Text(_deviceId == device.deviceId ? "Disconnect" : "Connect"),
            onPressed: () {
              print("Device: $Type($device)");
              _device=device;
              setState(() {
                _status = "Connected";
                _deviceId = device.deviceId;
              });
                _getPorts();
            },
          )));
    });

    setState(() {
      print(_ports);
    });
  }

  @override
  void initState() {
    super.initState();

    UsbSerial.usbEventStream.listen((UsbEvent event) {
      _getPorts();
    });

    _getPorts();
  }


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          body: SafeArea(
            child: Center(
                child: Column(
                  mainAxisAlignment:  MainAxisAlignment.center,
                  children: <Widget>[
                    Text("BreathPainel",style: TextStyle(color: Colors.green,fontSize: 40,fontWeight: FontWeight.bold)),
                    Container(height: 150,),
                    Text(
                        _ports.length > 0
                            ? "Portas seriais disponível:"
                            : "Nenhum dispositivo encontrado",
                        style:TextStyle(fontSize: 20,fontWeight: FontWeight.bold)),
                    ..._ports,
                    Text('Status: $_status\n',style:TextStyle(fontSize: 17,fontWeight: FontWeight.bold) ,),
                    Container(height: 15,),
                    Text("Insira um dispositivo!",style:TextStyle(fontSize: 20,fontWeight: FontWeight.bold)),
                    Container(height: 100,),
                    RaisedButton(
                    child: Text("Ir para o painel",style:TextStyle(fontSize: 17,fontWeight: FontWeight.bold,color: Colors.white)),
                    color: Colors.green,
                    onPressed: _status == "Connected"
                      ? () => Navigator.push(context,MaterialPageRoute(builder: (context) => Dashboard(device: _device,)),)
                      : () => _showMyDialog(context) 
                      ),
                  ]),

              ), 
          )
        ));
  }

}
Future<void> _showMyDialog( context) async {
  return showDialog<void>(
    context: context,
    barrierDismissible: false, // user must tap button!
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Você não pode ir para o painel!'),
        content: SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              Text('Por favor adiocione um dispositivo antes de ir para o painel.'),
            ],
          ),
        ),
        actions: <Widget>[
          FlatButton(
            child: Text('Ok'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}