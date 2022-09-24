import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:universal_serial_console/logic/bloc/avaliable_ports_page_bloc.dart';

class AvaliablePortsPage extends StatelessWidget {
  const AvaliablePortsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Universal serial console'),
      ),
      body: BlocBuilder<AvaliablePortsPageBloc, AvaliablePortsPageState>(
          builder: (context, state) {
        final ports = state.avaliablePorts.map(
          (e) => Text(e),
        );
        return Wrap(
          children: ports.toList(),
        );
      }),
    );
  }
}

class PortCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
  }
}
