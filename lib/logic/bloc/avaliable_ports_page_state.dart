part of 'avaliable_ports_page_bloc.dart';

enum AvaliablePortsPageStatus { initial, loading, noPorts, showPorts, failed }

class AvaliablePortsPageState extends Equatable {
  const AvaliablePortsPageState({
    required this.status,
    this.avaliablePorts = const [],
  });

  final AvaliablePortsPageStatus status;
  final List<String> avaliablePorts;

  AvaliablePortsPageState copyWith({
    AvaliablePortsPageStatus? status,
    List<String>? avaliablePorts,
  }) =>
      AvaliablePortsPageState(
        status: status ?? this.status,
        avaliablePorts: avaliablePorts ?? this.avaliablePorts,
      );

  @override
  List<Object?> get props => [status, avaliablePorts];
}
