import 'dart:io';

import 'package:challenge/src/api/exceptions.dart';
import 'package:challenge/src/api/services.dart';
import 'package:challenge/src/bloc/dash_borad_bloc/events.dart';
import 'package:challenge/src/bloc/dash_borad_bloc/states.dart';
import 'package:challenge/src/models/get_dashboard_data_response.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DashBoardBloc extends Bloc<DashBoardEvents, DashBoardState>{

  DashBoardBloc({this.dashBoardRepo, this.dashBoardData}) : super(DashBoardInitState());
  final DashBoardRepo dashBoardRepo;
  List<GetDashboardDataResponse> dashBoardData;

  @override
  Stream<DashBoardState> mapEventToState(DashBoardEvents event) async*{

    switch(event){
      case DashBoardEvents.fetchDashBoard:
        yield DashBoardLoading();
        try {
          dashBoardData = await dashBoardRepo.getDashBoardData();
          yield DashBoardLoaded(dashBoardData: dashBoardData);
        } on SocketException {
          yield DashBoardError(
            error: NoInternetException('No Internet'),
          );
        } on HttpException {
          yield DashBoardError(
            error: NoServiceFoundException('No Service Found'),
          );
        } on FormatException {
          yield DashBoardError(
            error: InvalidFormatException('Invalid Response format'),
          );
        } catch (e) {
          yield DashBoardError(
            error: UnknownException('Unknown Error'),
          );
        }
        break;
    }
  }


}