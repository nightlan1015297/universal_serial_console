import 'package:flutter/material.dart';
import 'package:flutter_libserialport/flutter_libserialport.dart';
import 'package:universal_serial_console/ui/common_widget/text_information_provider.dart';
import 'package:universal_serial_console/ui/port_information_page/PortConfigEditor.dart';
import 'package:universal_serial_console/utilities/routes/route_args.dart';

class PortInformationPage extends StatelessWidget {
  const PortInformationPage({super.key, required this.portName});

  final String portName;

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final width = mediaQuery.size.width;
    if (width > 600) {
      return PortInformationDesktopView(
        portName: portName,
      );
    } else {
      return PortInformationMobileView(
        portName: portName,
      );
    }
  }
}

class PortInformationDesktopView extends StatelessWidget {
  const PortInformationDesktopView({
    super.key,
    required this.portName,
  });
  final String portName;
  @override
  Widget build(BuildContext context) {
    final portInstance = SerialPort(portName);

    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 600, maxHeight: 400),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20.0),
          child: Card(
            child: Row(children: [
              Flexible(
                flex: 5,
                child: SizedBox(
                  height: double.infinity,
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(
                            width: double.infinity,
                          ),
                          TextInformationProvider(
                            label: 'Port name',
                            information: portName,
                          ),
                          const Divider(),
                          TextInformationProvider(
                            label: 'Description',
                            information: portInstance.description ?? '-',
                          ),
                          const Divider(),
                          TextInformationProvider(
                            label: 'Manufacturer',
                            information: portInstance.manufacturer ?? '-',
                          ),
                          const Divider(),
                          TextInformationProvider(
                            label: 'Address',
                            information: portInstance.address.toString(),
                          ),
                          const Divider(),
                          TextInformationProvider(
                            label: 'Bus number',
                            information: portInstance.busNumber.toString(),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Flexible(
                flex: 5,
                child: PortConfigEditForm(portInstance: portInstance),
              ),
            ]),
          ),
        ),
      ),
    );
  }
}

class PortInformationMobileView extends StatelessWidget {
  const PortInformationMobileView({super.key, required this.portName});

  final String portName;

  @override
  Widget build(BuildContext context) {
    final portInstance = SerialPort(portName);
    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 600, maxHeight: 400),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20.0),
          child: Card(
            child: Column(children: [
              Expanded(
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(
                          width: double.infinity,
                        ),
                        TextInformationProvider(
                          label: 'Port name',
                          information: portName,
                        ),
                        const Divider(),
                        TextInformationProvider(
                          label: 'Description',
                          information: portInstance.description ?? '-',
                        ),
                        const Divider(),
                        TextInformationProvider(
                          label: 'Manufacturer',
                          information: portInstance.manufacturer ?? '-',
                        ),
                        const Divider(),
                        TextInformationProvider(
                          label: 'Address',
                          information: portInstance.address.toString(),
                        ),
                        const Divider(),
                        TextInformationProvider(
                          label: 'Bus number',
                          information: portInstance.busNumber.toString(),
                        )
                      ],
                    ),
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).pushNamed('/portConfig',
                            arguments: PortConfigArgs(portName: portName));
                      },
                      child: const Text("Connect to this port"),
                    ),
                  )
                ],
              ),
            ]),
          ),
        ),
      ),
    );
  }
}
