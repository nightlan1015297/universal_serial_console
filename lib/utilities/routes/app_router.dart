import 'package:flutter/material.dart';
import 'package:universal_serial_console/ui/avaliable_ports_page/AvaliablePortsPage.dart';
import 'package:universal_serial_console/ui/page_routes/popup_page_route.dart';
import 'package:universal_serial_console/ui/port_information_page/PortInformationPage.dart';
import 'package:universal_serial_console/utilities/routes/route_args.dart';

class AppRouter {
  Route<dynamic> generateRoute(RouteSettings routsettings) {
    switch (routsettings.name) {
      case '/':
        return MaterialPageRoute(
          settings: RouteSettings(name: routsettings.name),
          builder: (contex) => const AvaliablePortsPage(),
        );

      case '/portInformation':
        return PopupPageRoute(
          settings: RouteSettings(name: routsettings.name),
          builder: (contex) {
            final args = routsettings.arguments as PortInformationPageArgs;
            return PortInformationPage(
              portName: args.portName,
            );
          },
        );

      default:
        return MaterialPageRoute(
          settings: const RouteSettings(name: 'Route error'),
          builder: (contex) => Scaffold(
            body: Center(
              child: Text('Bad route for route name: ${routsettings.name}.'),
            ),
          ),
        );
    }
  }
}
