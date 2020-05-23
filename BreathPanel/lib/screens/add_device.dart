import 'package:app_breath/screens/add_device/add_device_mobile.dart';
import 'package:app_breath/screens/add_device/add_device_small_phone.dart';
import 'package:app_breath/screens/add_device/add_device_tablet.dart';
import 'package:app_breath/ui/orientation.dart';
import 'package:app_breath/ui/scree_type.layout.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() => runApp(AddDevice());

class AddDevice extends StatelessWidget {
  const AddDevice({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ScreenTypeLayout(
      smallPhone: OrientationLayout(
        portrait: AddDeviceSmallPhonePortrait(),
        landscape: AddDeviceSmallPhoneLandscape(),
        ),
      mobile: OrientationLayout(
        portrait: AddDeviceMobilePortrait(),
        landscape: AddDeviceMobileLandscape(),
        ),
      tablet: OrientationLayout(
        landscape: AddDeviceTabletLandscape(), 
        portrait: AddDeviceTabletPortrait()),
      );
  }
}

