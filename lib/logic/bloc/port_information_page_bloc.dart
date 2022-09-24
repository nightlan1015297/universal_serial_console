import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_libserialport/flutter_libserialport.dart';

part 'port_information_page_event.dart';
part 'port_information_page_state.dart';

class PortInformationPageBloc
    extends Bloc<PortInformationPageEvent, PortInformationPageState> {
  PortInformationPageBloc({required this.portName})
      : super(const PortInformationPageState()) {
    on<InitializeRequest>(onInitializeRequest);
  }

  final String portName;
  late SerialPort portInstance;

  void onInitializeRequest(
    InitializeRequest event,
    Emitter<PortInformationPageState> emit,
  ) {
    portInstance = SerialPort(portName);
    try {
      emit(PortInformationPageState(
        status: PortInformationPageStatus.success,
        name: portName,
        address: portInstance.address,
        busNum: portInstance.busNumber,
        config: portInstance.config,
        description: portInstance.description,
        deviceNumber: portInstance.deviceNumber,
        manufacturer: portInstance.manufacturer,
      ));
    } catch (error, stack) {
      emit(
        const PortInformationPageState(
          status: PortInformationPageStatus.failed,
        ),
      );
    }
  }
}
