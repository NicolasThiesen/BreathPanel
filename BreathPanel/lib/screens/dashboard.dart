import 'package:app_breath/screens/add_device.dart';
import 'package:app_breath/screens/dashboard/dashboard_bloc.dart';
import 'package:app_breath/screens/dashboard/dashboard_mobile.dart';
import 'package:app_breath/screens/dashboard/dashboard_small_phone.dart';
import 'package:app_breath/screens/dashboard/dashboard_tablet.dart';
import 'package:app_breath/ui/orientation.dart';
import 'package:app_breath/ui/scree_type.layout.dart';

import 'package:flutter/material.dart';

import 'package:usb_serial/usb_serial.dart';




DashBoardBloc bloc = DashBoardBloc();
class Dashboard extends StatefulWidget {
  final UsbDevice device;
  Dashboard({this.device,});
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
    bloc.connectTo(widget.device);
      }
  @override
  void dispose() {
    super.dispose();
    bloc.connectTo(null);
  }


  @override
  Widget build(BuildContext context) {
    return ScreenTypeLayout(
      smallPhone: OrientationLayout(
        portrait: DashboardSmallPhonePortrait(device: widget.device,),
        landscape: DashboardSmallPhoneLandscape(device: widget.device,),
        ),
      mobile: OrientationLayout(
        portrait: DashboardMobilePortrait(device: widget.device,),
        landscape: DashboardMobileLandscape(device: widget.device,),
        ),
      tablet: OrientationLayout(
        landscape: DashboardTabletLandscape(device: widget.device,), 
        portrait: DashboardTabletPortrait(device: widget.device,)
        ),
      );
  
}
}