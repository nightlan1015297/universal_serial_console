import 'package:flutter/material.dart';
import 'package:flutter_libserialport/flutter_libserialport.dart';
import 'package:universal_serial_console/ui/common_widget/text_information_provider.dart';
import 'package:universal_serial_console/ui/port_information_page/PortConfigEditor.dart';

class PortConfigPage extends StatelessWidget {
  const PortConfigPage({super.key, required this.portName});

  final String portName;

  @override
  Widget build(BuildContext context) {
    final portInstance = SerialPort(portName);
    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 600, maxHeight: 400),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20.0),
          child: Card(child: PortConfigEditForm(portInstance: portInstance)),
        ),
      ),
    );
  }
}
