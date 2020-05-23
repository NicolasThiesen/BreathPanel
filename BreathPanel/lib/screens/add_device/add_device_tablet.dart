import 'package:app_breath/screens/add_device/add_device_bloc.dart';
import 'package:app_breath/screens/dashboard.dart';
import 'package:flutter/material.dart';
import 'package:usb_serial/usb_serial.dart';
import 'package:app_breath/Widgets/alertDialog.dart';

AddDeviceBloc bloc = AddDeviceBloc();

class AddDeviceTabletPortrait extends StatefulWidget {
  AddDeviceTabletPortrait({Key key}):super(key:key);

  @override
  _AddDeviceTabletPortraitState createState() => _AddDeviceTabletPortraitState();
}

class _AddDeviceTabletPortraitState extends State<AddDeviceTabletPortrait> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  void initState() {
    super.initState();

    UsbSerial.usbEventStream.listen((UsbEvent event) {
      bloc.getPorts();
    });

    bloc.getPorts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
            key: _scaffoldKey,
            body: SafeArea(
              child: Center(
                  child: StreamBuilder(
                    stream: bloc.output,
                    builder: (context, snapshot) {
                      return Column(
                        mainAxisAlignment:  MainAxisAlignment.center,
                        children: <Widget>[
                          Container(
                            child: Column(children: [
                              Text("BreathPanel",style: TextStyle(color: Theme.of(context).primaryColor,fontSize: 50,fontWeight: FontWeight.bold)),
                              Image(width: 256, height: 256,image: AssetImage("Assets/icon.png"),),
                              Text("InjeVent",style: TextStyle(color: Theme.of(context).primaryColor,fontSize: 40,fontWeight: FontWeight.bold)),
                            ],),
                          ),
                          Container(height: MediaQuery.of(context).size.height/15,),
                          Container(
                            
                            child: Column(
                              children: [
                                Container(
                                  height: 200,
                                  width: 400,
                                  decoration: BoxDecoration(
                                    color: Theme.of(context).primaryColor,
                                    borderRadius: BorderRadius.circular(20)
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: Column(
                                    children: [
                                      Text("Portas seriais disponíveis:",style:TextStyle(color: Colors.white,fontSize: 25,fontWeight: FontWeight.bold)),
                                      ...bloc.ports,
                                      Text("Status: ${bloc.status}",style:TextStyle(color: Colors.white,fontSize: 20,fontWeight: FontWeight.bold)),

                                    ],
                                  ),
                                )),
                            Container(height: MediaQuery.of(context).size.height/10,),
                            RaisedButton(
                            
                            child: Text("Ir para o painel",style:TextStyle(fontSize: 25,fontWeight: FontWeight.bold,color: Colors.white)),
                            color: Theme.of(context).primaryColor,
                            onPressed: bloc.status == "Connected"
                              ? () => Navigator.push(context,MaterialPageRoute(builder: (context) => Dashboard(device: bloc.main_device,)),)
                              : () => showMyDialog(context) 
                              ),
                              ],
                            ),),

                        ]);
                    }
                  ),

                ), 
            )
          );
  }
}



class AddDeviceTabletLandscape extends StatefulWidget {
  AddDeviceTabletLandscape({Key key}):super(key:key);
  @override
  _AddDeviceTabletLandscapeState createState() => _AddDeviceTabletLandscapeState();
}

class _AddDeviceTabletLandscapeState extends State<AddDeviceTabletLandscape> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  void initState() {
    super.initState();

    UsbSerial.usbEventStream.listen((UsbEvent event) {
      bloc.getPorts();
    });

    bloc.getPorts();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
            key: _scaffoldKey,
            body: Row(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width/2,
                  child: Center(
                      child: Column(
                            mainAxisAlignment:  MainAxisAlignment.center,
                            children: <Widget>[
                              Text("BreathPanel",style: TextStyle(color: Theme.of(context).primaryColor,fontSize: 50,fontWeight: FontWeight.bold)),
                              Image(width: 256, height: 256,image: AssetImage("Assets/icon.png"),),
                              Text("InjeVent",style: TextStyle(color: Theme.of(context).primaryColor,fontSize: 40,fontWeight: FontWeight.bold)),
                      ])
                    ),
                ),
                ClipPath(
                  clipper: _Clipper(),
                  child: Container(
                    width: MediaQuery.of(context).size.width/2,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                        colors: [Color.fromRGBO(0, 202, 3, 1),Color.fromRGBO(4, 250, 0, 0.7)]),
                      image: DecorationImage(image: AssetImage("Assets/virus.png")),
                    ),
                    child: Center(
                        child: StreamBuilder(
                          stream: bloc.output,
                          builder: (context, snapshot) {
                            return Column(
                              mainAxisAlignment:  MainAxisAlignment.center,
                              children: <Widget>[
                                Text("Portas seriais disponíveis:",style:TextStyle(color: Colors.white,fontSize: 30,fontWeight: FontWeight.bold)),
                                Container(height: MediaQuery.of(context).size.height/30,),
                                ...bloc.ports,
                                Container(height: MediaQuery.of(context).size.height/10,),
                                StreamBuilder(
                                  stream: bloc.output,
                                  builder: (context, snapshot) {
                                    return RaisedButton(
                                    child: Text("Ir para o painel",style:TextStyle(fontSize: 25,fontWeight: FontWeight.bold,color: Colors.white)),
                                    color: Colors.green[900],
                                    onPressed: bloc.status == "Connected"
                                      ? () => Navigator.push(context,MaterialPageRoute(builder: (context) => Dashboard(device: bloc.main_device,)),)
                                      : () => showMyDialog(context) 
                                      );
                                  }
                                ),
                  
                               
                              ]);
                          }
                        ),

                      ),
                  ),
                ),
              ],
            )
          );
  }
}
class _Clipper extends CustomClipper<Path>{
  @override
  Path getClip(Size size){
    var path = Path();
    path.lineTo(size.width, 0);
    path.quadraticBezierTo(size.width, size.height, size.width, size.height);
    path.lineTo(120, size.height);

    path.close();
    return path;
  }
  @override
  bool shouldReclip(CustomClipper<Path> oldClipper){
    return false;
  }
}