import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_libserialport/flutter_libserialport.dart';
import 'package:universal_serial_console/logic/bloc/avaliable_ports_page_bloc.dart';
import 'package:universal_serial_console/ui/port_information_page/PortConfigEditor.dart';
import 'package:universal_serial_console/utilities/routes/app_router.dart';

import 'ui/avaliable_ports_page/AvaliablePortsPage.dart';

void main() {
  final testPort = SerialPort('COM4');
  print(testPort.config.baudRate);
  print(testPort.config.stopBits);
  print(testPort.config.parity);
  print(testPort.config.dtr);
  print(testPort.config.rts);
  print(testPort.config.cts);
  print(testPort.config.dsr);
  print(testPort.config.xonXoff);
  // testPort.config.baudRate = 9600;
  // testPort.config.bits = 5;
  // testPort.config.stopBits = 1;
  // testPort.config.parity = 0;
  // testPort.config.dtr = 0;
  // testPort.config.rts = 0;
  // testPort.config.cts = 0;
  // testPort.config.dsr = 0;
  testPort.config.xonXoff = 0;
  testPort.openReadWrite();
  print(testPort.config.bits);

  print(testPort.isOpen);
  final reader = SerialPortReader(testPort);
  reader.stream.listen((data) {
    print('received: $data}');
    print('received: ${String.fromCharCodes(data)}');
  });
  testPort.write('testing'.toUnit8List());

  runApp(const UniversalSerialConsole());
}

class UniversalSerialConsole extends StatelessWidget {
  const UniversalSerialConsole({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AvaliablePortsPageBloc>(
          create: (BuildContext context) {
            final avaliablePortsPageBloc = AvaliablePortsPageBloc();
            avaliablePortsPageBloc.add(InitializeRequest());
            return avaliablePortsPageBloc;
          },
        ),
      ],
      child: MaterialApp(
        title: 'Universal serial console',
        theme: ThemeData.dark(),
        onGenerateRoute: AppRouter().generateRoute,
        home: const AvaliablePortsPage(),
      ),
    );
  }
}
