import 'package:app_breath/Widgets/info.dart';
import 'package:app_breath/screens/add_device/add_device_bloc.dart';
import 'package:app_breath/screens/dashboard.dart';
import 'package:flutter/material.dart';
import 'package:usb_serial/usb_serial.dart';
import 'package:app_breath/Widgets/alertDialog.dart';

AddDeviceBloc bloc = AddDeviceBloc();

class AddDeviceMobilePortrait extends StatefulWidget {
  AddDeviceMobilePortrait({Key key}) : super(key: key);

  @override
  _AddDeviceMobilePortraitState createState() =>
      _AddDeviceMobilePortraitState();
}

class _AddDeviceMobilePortraitState extends State<AddDeviceMobilePortrait> {
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
        floatingActionButton: FloatingActionButton(
            child: Icon(Icons.info_outline),
            backgroundColor: Theme.of(context).primaryColor,
            foregroundColor: Colors.white,
            onPressed: () {
              infoDialog(context);
            }),
        key: _scaffoldKey,
        body: SafeArea(
          child: Center(
            child: StreamBuilder(
                stream: bloc.output,
                builder: (context, snapshot) {
                  return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          child: Column(
                            children: [
                              Text("BreathPanel",
                                  style: TextStyle(
                                      color: Theme.of(context).primaryColor,
                                      fontSize: 40,
                                      fontWeight: FontWeight.bold)),
                              Image(
                                width: 200,
                                height: 200,
                                image: AssetImage("Assets/icon.png"),
                              ),
                              Text("InjeVent",
                                  style: TextStyle(
                                      color: Theme.of(context).primaryColor,
                                      fontSize: 25,
                                      fontWeight: FontWeight.bold)),
                            ],
                          ),
                        ),
                        Container(
                          height: MediaQuery.of(context).size.height / 10,
                        ),
                        Container(
                          child: Column(
                            children: [
                              Container(
                                  height: 170,
                                  width: 300,
                                  decoration: BoxDecoration(
                                      color: Theme.of(context).primaryColor,
                                      borderRadius: BorderRadius.circular(20)),
                                  child: Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: Column(
                                      children: [
                                        Text("Portas seriais disponíveis:",
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold)),
                                        ...bloc.ports,
                                        Text("Status: ${bloc.status}",
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 17,
                                                fontWeight: FontWeight.bold)),
                                      ],
                                    ),
                                  )),
                              Container(
                                height: 50,
                              ),
                              RaisedButton(
                                  child: Text("Ir para o painel",
                                      style: TextStyle(
                                          fontSize: 17,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white)),
                                  color: Theme.of(context).primaryColor,
                                  onPressed: bloc.status == "Connected"
                                      ? () => Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) => Dashboard(
                                                      device: bloc.main_device,
                                                    )),
                                          )
                                      : () => showMyDialog(context)),
                            ],
                          ),
                        ),
                      ]);
                }),
          ),
        ));
  }
}

class AddDeviceMobileLandscape extends StatefulWidget {
  AddDeviceMobileLandscape({Key key}) : super(key: key);
  @override
  _AddDeviceMobileLandscapeState createState() =>
      _AddDeviceMobileLandscapeState();
}

class _AddDeviceMobileLandscapeState extends State<AddDeviceMobileLandscape> {
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
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: FloatingActionButton.extended(
            icon: Icon(Icons.info_outline),
            backgroundColor: Theme.of(context).primaryColor,
            foregroundColor: Colors.white,
            label: Text(
              "Como Usar?",
              style: TextStyle(fontSize: 17),
            ),
            onPressed: () {
              infoDialog(context);
            }),
        key: _scaffoldKey,
        body: Row(
          children: [
            Container(
              width: MediaQuery.of(context).size.width / 2,
              child: Center(
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                    Text("BreathPanel",
                        style: TextStyle(
                            color: Theme.of(context).primaryColor,
                            fontSize: 40,
                            fontWeight: FontWeight.bold)),
                    Image(
                      width: 200,
                      height: 200,
                      image: AssetImage("Assets/icon.png"),
                    ),
                    Text("InjeVent",
                        style: TextStyle(
                            color: Theme.of(context).primaryColor,
                            fontSize: 25,
                            fontWeight: FontWeight.bold)),
                  ])),
            ),
            ClipPath(
              clipper: _Clipper(),
              child: Container(
                width: MediaQuery.of(context).size.width / 2,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                      colors: [
                        Color.fromRGBO(0, 202, 3, 1),
                        Color.fromRGBO(4, 250, 0, 0.7)
                      ]),
                  image: DecorationImage(image: AssetImage("Assets/virus.png")),
                ),
                child: Center(
                  child: StreamBuilder(
                      stream: bloc.output,
                      builder: (context, snapshot) {
                        return Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text("Portas seriais disponíveis:",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 25,
                                      fontWeight: FontWeight.bold)),
                              Container(
                                height: MediaQuery.of(context).size.height / 30,
                              ),
                              ...bloc.ports,
                              Container(
                                height: MediaQuery.of(context).size.height / 10,
                              ),
                              RaisedButton(
                                  child: Text("Ir para o painel",
                                      style: TextStyle(
                                          fontSize: 17,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white)),
                                  color: Colors.green[900],
                                  onPressed: bloc.status == "Connected"
                                      ? () => Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) => Dashboard(
                                                      device: bloc.main_device,
                                                    )),
                                          )
                                      : () => showMyDialog(context)),
                            ]);
                      }),
                ),
              ),
            ),
          ],
        ));
  }
}

class _Clipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(size.width, 0);
    path.quadraticBezierTo(size.width, size.height, size.width, size.height);
    path.lineTo(80, size.height);

    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}
