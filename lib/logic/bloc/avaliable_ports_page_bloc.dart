import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_libserialport/flutter_libserialport.dart';

part 'avaliable_ports_page_event.dart';
part 'avaliable_ports_page_state.dart';

class AvaliablePortsPageBloc
    extends Bloc<AvaliablePortsPageEvent, AvaliablePortsPageState> {
  AvaliablePortsPageBloc()
      : super(const AvaliablePortsPageState(
            status: AvaliablePortsPageStatus.initial)) {
    on<InitializeRequest>(_onInitializeRequest);
  }

  void _onInitializeRequest(
    InitializeRequest event,
    Emitter<AvaliablePortsPageState> emit,
  ) {
    /// Fetch available serial ports
    List<String> ports = SerialPort.availablePorts;
    if (ports.isEmpty) {
      emit(state.copyWith(
        status: AvaliablePortsPageStatus.noPorts,
        avaliablePorts: ports,
      ));
      return;
    } else {
      emit(state.copyWith(
        status: AvaliablePortsPageStatus.noPorts,
        avaliablePorts: ports,
      ));
    }
  }
}
