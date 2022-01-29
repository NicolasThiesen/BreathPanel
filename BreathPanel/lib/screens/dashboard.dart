import 'package:app_breath/screens/add_device.dart';
import 'package:app_breath/screens/dashboard/dashboard_bloc.dart';
import 'package:app_breath/screens/dashboard/dashboard_mobile.dart';
import 'package:app_breath/screens/dashboard/dashboard_small_phone.dart';
import 'package:app_breath/screens/dashboard/dashboard_tablet.dart';
import 'package:app_breath/ui/orientation.dart';
import 'package:app_breath/ui/screen_type.layout.dart';

import 'package:flutter/material.dart';

import 'package:usb_serial/usb_serial.dart';




DashBoardBloc bloc = DashBoardBloc();
class Dashboard extends StatefulWidget {
  final UsbDevice device;
  final String screen;
  final String orientation;

  Dashboard({this.device,this.screen, this.orientation});
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {

  @override
  void initState(){
    super.initState();
    if(widget.device == null){
      Navigator.push(context,MaterialPageRoute(builder: (context) => AddDevice()),);
    }
    else{
      bloc.connectTo(widget.device,context,widget.screen,widget.orientation);
    }
  }
  @override
  void dispose() {
    super.dispose();
    bloc.connectTo(null,null,null,null);
  }



  @override
  Widget build(BuildContext context) {
    return ScreenTypeLayout(
      smallPhone: OrientationLayout(
        portrait: widget.device != null ? DashboardSmallPhonePortrait() : AddDevice(),
        landscape: widget.device != null ? DashboardSmallPhoneLandscape() : AddDevice(),
        ),
      mobile: OrientationLayout(
        portrait: widget.device != null ? DashboardMobilePortrait() : AddDevice(),
        landscape: widget.device != null ? DashboardMobileLandscape() : AddDevice(),
        ),
      tablet: OrientationLayout(
        landscape: widget.device != null ? DashboardTabletLandscape() : AddDevice(), 
        portrait: widget.device != null ? DashboardTabletPortrait() : AddDevice(),
        ),
      );
  
}
}