import 'package:app_breath/enums/device_screen_type.dart';
import 'package:flutter/widgets.dart';


DeviceScreenType getDeviceType(MediaQueryData mediaQuery){
  double deviceWidth = mediaQuery.size.shortestSide;
  if(deviceWidth > 950){
    return DeviceScreenType.Desktop;
  }else if(deviceWidth > 600){
    return DeviceScreenType.Tablet;
  }else if(deviceWidth > 385){
    return DeviceScreenType.Mobile;
  }else{
    return DeviceScreenType.SmalPhone;
  }
}