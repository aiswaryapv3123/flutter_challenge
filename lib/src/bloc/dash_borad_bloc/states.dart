import 'package:challenge/src/models/get_dashboard_data_response.dart';
import 'package:equatable/equatable.dart';
import 'package:challenge/src/api/services.dart';

abstract class DashBoardState extends Equatable {
  @override
  List<Object> get props => [];
}

class DashBoardInitState extends DashBoardState {}

class DashBoardLoading extends DashBoardState {}

class DashBoardLoaded extends DashBoardState {
  final List<GetDashboardDataResponse> dashBoardData;
  DashBoardLoaded({this.dashBoardData});
}

class DashBoardError extends DashBoardState {
  final error;
  DashBoardError({this.error});
}
