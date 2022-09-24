import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:universal_serial_console/logic/bloc/avaliable_ports_page_bloc.dart';

import 'ui/avaliable_ports_page/AvaliablePortsPage.dart';

void main() {
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
        home: const AvaliablePortsPage(),
      ),
    );
  }
}
