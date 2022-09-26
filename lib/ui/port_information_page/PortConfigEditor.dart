import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_libserialport/flutter_libserialport.dart';

class PortConfigEditForm extends StatefulWidget {
  const PortConfigEditForm({super.key, required this.portInstance});

  final SerialPort portInstance;

  @override
  State<PortConfigEditForm> createState() => _PortConfigEditFormState();
}

class _PortConfigEditFormState extends State<PortConfigEditForm> {
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const Align(
              alignment: Alignment.centerLeft,
              child: Text('Connection configuration :'),
            ),
            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  children: [
                    TextFormField(
                      onSaved: (value) {
                        widget.portInstance.config.baudRate = int.parse(value!);
                      },
                      decoration:
                          const InputDecoration(labelText: "Baud rate: "),
                      initialValue: 9600.toString(),
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value != null) {
                          final parsedValue = int.tryParse(value);
                          if (parsedValue != null || parsedValue != -1) {
                            return null;
                          }
                        }
                        return 'Invalid value for baud rate.';
                      },
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter.digitsOnly
                      ],
                    ),
                    TextFormField(
                      onSaved: (value) {
                        widget.portInstance.config.bits = int.parse(value!);
                      },
                      decoration:
                          const InputDecoration(labelText: "Data bits: "),
                      initialValue: 8.toString(),
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value != null) {
                          final parsedValue = int.tryParse(value);
                          if (parsedValue != null || parsedValue != -1) {
                            return null;
                          }
                        }
                        return 'Invalid value for data bits.';
                      },
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter.digitsOnly
                      ],
                    ),
                    DropdownButtonFormField(
                      onSaved: (value) {
                        final int index;
                        switch (value) {
                          case 'None':
                            index = 0;
                            break;
                          case 'Odd':
                            index = 1;
                            break;
                          case 'Even':
                            index = 2;
                            break;
                          case 'Mark':
                            index = 3;
                            break;
                          case 'Space':
                            index = 4;
                            break;
                          default:
                            index = -1;
                        }
                        widget.portInstance.config.parity = index;
                      },
                      decoration: const InputDecoration(labelText: "Parity: "),
                      value: 'None',
                      onChanged: (item) {},
                      items: const [
                        DropdownMenuItem(
                          value: 'None',
                          child: Text('None'),
                        ),
                        DropdownMenuItem(
                          value: 'Odd',
                          child: Text('Odd'),
                        ),
                        DropdownMenuItem(
                          value: 'Even',
                          child: Text('Even'),
                        ),
                        DropdownMenuItem(
                          value: 'Mark',
                          child: Text('Mark'),
                        ),
                        DropdownMenuItem(
                          value: 'Space',
                          child: Text('Space'),
                        ),
                      ],
                    ),
                    TextFormField(
                      onSaved: (value) {
                        widget.portInstance.config.stopBits = int.parse(value!);
                      },
                      decoration:
                          const InputDecoration(labelText: "Stop bits: "),
                      initialValue: 1.toString(),
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value != null) {
                          final parsedValue = int.tryParse(value);
                          if (parsedValue != null || parsedValue != -1) {
                            return null;
                          }
                        }
                        return 'Invalid value for stop bits.';
                      },
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter.digitsOnly
                      ],
                    ),
                  ],
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                widget.portInstance.openReadWrite();
                print(widget.portInstance.isOpen);
                widget.portInstance.write('testing'.toUnit8List());
                final reader = SerialPortReader(widget.portInstance);
                reader.stream.listen((event) {
                  print(String.fromCharCodes(event));
                });
              },
              child: const Text('Connect'),
            )
          ],
        ),
      ),
    );
  }
}

extension Encoder on String {
  Uint8List toUnit8List() {
    List<int> codeUnit = this.codeUnits;
    return Uint8List.fromList(codeUnit);
  }
}
