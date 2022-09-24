import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:universal_serial_console/logic/bloc/port_information_page_bloc.dart';
import 'package:universal_serial_console/ui/common_widget/text_information_provider.dart';

class PortInformationPage extends StatelessWidget {
  const PortInformationPage({super.key, required this.portName});

  final String portName;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        final portInformationPageBloc =
            PortInformationPageBloc(portName: portName);
        portInformationPageBloc.add(const InitializeRequest());
        return portInformationPageBloc;
      },
      child: BlocBuilder<PortInformationPageBloc, PortInformationPageState>(
        builder: (context, state) {
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
        },
      ),
    );
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
    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 600),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20.0),
          child: BlocBuilder<PortInformationPageBloc, PortInformationPageState>(
            builder: (context, state) {
              return Card(
                child: Row(children: [
                  Flexible(
                    flex: 8,
                    child: SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(width: double.infinity),
                            TextInformationProvider(
                              label: 'Port name',
                              information: portName,
                            ),
                            const Divider(),
                            TextInformationProvider(
                              label: 'Address',
                              information: state.address.toString(),
                            ),
                            const Divider(),
                            TextInformationProvider(
                              label: 'Bus number',
                              information: state.busNum.toString(),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  Flexible(
                    flex: 2,
                    child: Column(
                      children: [
                        const SizedBox(width: double.infinity),
                        ElevatedButton(
                          onPressed: () {},
                          child: const Text('Apply'),
                        )
                      ],
                    ),
                  ),
                ]),
              );
            },
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
    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 600),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: BlocBuilder<PortInformationPageBloc, PortInformationPageState>(
            builder: (context, state) {
              return Card(
                child: Column(children: [
                  Expanded(
                    child: SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
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
                              label: 'Address',
                              information: state.address.toString(),
                            ),
                            const Divider(),
                            TextInformationProvider(
                              label: 'Bus number',
                              information: state.busNum.toString(),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      ElevatedButton(
                        onPressed: () {},
                        child: const Text("Apply"),
                      )
                    ],
                  ),
                ]),
              );
            },
          ),
        ),
      ),
    );
  }
}
