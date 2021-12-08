import 'package:http/http.dart' as http;
import 'package:challenge/src/models/get_dashboard_data_response.dart';
import 'package:http/http.dart';

abstract class DashBoardRepo {
  Future<List<GetDashboardDataResponse>> getDashBoardData();
}

class DashBoardServices implements DashBoardRepo {
  static const baseUrl = "api.mocklets.com";
  static const String _GET_DATA = "/p68289/screentime";

  @override
  Future<List<GetDashboardDataResponse>> getDashBoardData() async{
    // TODO: implement getAlbumList
    Uri uri = Uri.https(baseUrl, _GET_DATA);
    Response response = await http.get(uri);
    List<GetDashboardDataResponse> dashBoardData = getDashboardDataResponseFromJson(response.body);
    return dashBoardData;
  }
}