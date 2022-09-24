part of 'port_information_page_bloc.dart';

enum PortInformationPageStatus { initial, success, failed }

class PortInformationPageState extends Equatable {
  const PortInformationPageState(
      {this.name,
      this.address,
      this.busNum,
      this.config,
      this.description,
      this.deviceNumber,
      this.manufacturer,
      this.status = PortInformationPageStatus.initial});

  final PortInformationPageStatus status;
  final String? name;
  final int? address;
  final int? busNum;
  final SerialPortConfig? config;
  final String? description;
  final int? deviceNumber;
  final String? manufacturer;

  @override
  List<Object?> get props => [
        name,
        address,
        busNum,
        config,
        description,
        deviceNumber,
        manufacturer,
        status
      ];
}
