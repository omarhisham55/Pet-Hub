import 'dart:io';

import 'package:desktop_window/desktop_window.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';

class ResponsiveManager extends StatelessWidget {
  final Widget desktop;
  final Widget mobile;
  const ResponsiveManager({
    super.key,
    required this.desktop,
    required this.mobile,
  });

  static Future<dynamic> desktopConstraints() async {
    if (kIsWeb || Platform.isWindows || Platform.isMacOS) {
      return await DesktopWindow.setMinWindowSize(const Size(650, 650));
    }
  }

  @override
  Widget build(BuildContext context) {
    return ResponsiveBuilder(
      builder: (context, sizingInformation) {
        if (sizingInformation.deviceScreenType == DeviceScreenType.desktop) {
          return LayoutBuilder(
            builder: (context, constraints) {
              return ConstrainedBox(
                constraints:
                    const BoxConstraints(minHeight: 650, minWidth: 650),
                child: desktop,
              );
            },
          );
        }

        // if (sizingInformation.deviceScreenType == DeviceScreenType.tablet) {
        //   return Container(color: Colors.red);
        // }

        if (sizingInformation.deviceScreenType == DeviceScreenType.mobile) {
          return mobile;
        }

        return Container(color: Colors.purple);
      },

      // breakpoints: const [
      //   Breakpoint(start: 0, end: 480, name: MOBILE),
      //   Breakpoint(start: 481, end: 1200, name: TABLET),
      //   Breakpoint(start: 1201, end: double.infinity, name: DESKTOP),
      // ],
    );
  }
}
