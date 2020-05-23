import 'package:app_breath/helpers/ui_helper.dart';
import 'package:app_breath/ui/sizing_information.dart';
import 'package:flutter/material.dart';

class ResponsiveBuilder extends StatelessWidget {
  final Widget Function(
      BuildContext context, 
      SizingInformation sizingInformation
      ) builder;

  const ResponsiveBuilder({Key key, this.builder}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: ( context, boxConstraints) {
      var mediaQuery = MediaQuery.of(context);
      var sizingInformation = SizingInformation(
      deviceScreenType: getDeviceType(mediaQuery),
      screenSize: mediaQuery.size,
      localWidgetSize: Size(boxConstraints.maxWidth, boxConstraints.maxHeight)
      );
      return builder(context, sizingInformation);
    });
  }
}