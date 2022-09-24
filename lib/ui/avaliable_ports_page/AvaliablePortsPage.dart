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
          (portName) => PortCard(
            portName: portName,
          ),
        );
        return Wrap(
          children: ports.toList(),
        );
      }),
    );
  }
}

class PortCard extends StatelessWidget {
  const PortCard({super.key, required this.portName});

  final String portName;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        child: SizedBox(
          width: 150,
          height: 150,
          child: Column(
            children: [
              const Spacer(),
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                    border: Border.all(width: 2, color: Colors.white)),
                child: const Icon(
                  Icons.usb,
                  size: 40,
                ),
              ),
              const Spacer(),
              Text(
                portName,
                style: theme.textTheme.bodyLarge!.copyWith(fontSize: 18),
              ),
              const Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}
