part of 'port_information_page_bloc.dart';

abstract class PortInformationPageEvent extends Equatable {
  const PortInformationPageEvent();

  @override
  List<Object> get props => [];
}

class InitializeRequest extends PortInformationPageEvent {
  const InitializeRequest();
  @override
  List<Object> get props => [];
}
