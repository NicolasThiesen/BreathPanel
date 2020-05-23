import 'package:app_breath/enums/device_screen_type.dart';
import 'package:app_breath/ui/responsive_builder.dart';
import 'package:flutter/cupertino.dart';

class ScreenTypeLayout extends StatelessWidget {
  // Mobile will be returned by default
  final Widget smallPhone;
  final Widget mobile;
  final Widget tablet;
  final Widget desktop;

  const ScreenTypeLayout(
      {Key key, this.smallPhone, @required this.mobile, this.tablet, this.desktop})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ResponsiveBuilder(builder: (context, sizingInformation) {
      // If sizing indicates Tablet and we have a tablet widget then return
      if (sizingInformation.deviceScreenType == DeviceScreenType.Tablet) {
        if (tablet != null) {
          return tablet;
        }
      }

      // If sizing indicates desktop and we have a desktop widget then return
      if (sizingInformation.deviceScreenType == DeviceScreenType.Desktop) {
        if (desktop != null) {
          return desktop;
        }
      }
      if (sizingInformation.deviceScreenType == DeviceScreenType.Mobile){
        return mobile;
      }
      if( sizingInformation.deviceScreenType == DeviceScreenType.SmalPhone){
        return smallPhone;
      }
    });
  }
}