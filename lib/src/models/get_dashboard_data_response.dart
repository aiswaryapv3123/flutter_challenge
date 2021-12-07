// To parse this JSON data, do
//
//     final getDashboardDataResponse = getDashboardDataResponseFromJson(jsonString);

import 'dart:convert';

List<GetDashboardDataResponse> getDashboardDataResponseFromJson(String str) => List<GetDashboardDataResponse>.from(json.decode(str).map((x) => GetDashboardDataResponse.fromJson(x)));

String getDashboardDataResponseToJson(List<GetDashboardDataResponse> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class GetDashboardDataResponse {
  GetDashboardDataResponse({
    this.chartData,
    this.freeTimeMaxUsage,
    this.deviceUsage,
  });

  final ChartData chartData;
  final String freeTimeMaxUsage;
  final DeviceUsage deviceUsage;

  factory GetDashboardDataResponse.fromJson(Map<String, dynamic> json) => GetDashboardDataResponse(
    chartData: json["chartData"] == null ? null : ChartData.fromJson(json["chartData"]),
    freeTimeMaxUsage: json["freeTimeMaxUsage"] == null ? null : json["freeTimeMaxUsage"],
    deviceUsage: json["deviceUsage"] == null ? null : DeviceUsage.fromJson(json["deviceUsage"]),
  );

  Map<String, dynamic> toJson() => {
    "chartData": chartData == null ? null : chartData.toJson(),
    "freeTimeMaxUsage": freeTimeMaxUsage == null ? null : freeTimeMaxUsage,
    "deviceUsage": deviceUsage == null ? null : deviceUsage.toJson(),
  };
}

class ChartData {
  ChartData({
    this.totalTime,
    this.studyTime,
    this.classTime,
    this.freeTime,
  });

  final ChartDataClassTime totalTime;
  final ChartDataClassTime studyTime;
  final ChartDataClassTime classTime;
  final ChartDataClassTime freeTime;

  factory ChartData.fromJson(Map<String, dynamic> json) => ChartData(
    totalTime: json["totalTime"] == null ? null : ChartDataClassTime.fromJson(json["totalTime"]),
    studyTime: json["studyTime"] == null ? null : ChartDataClassTime.fromJson(json["studyTime"]),
    classTime: json["classTime"] == null ? null : ChartDataClassTime.fromJson(json["classTime"]),
    freeTime: json["freeTime"] == null ? null : ChartDataClassTime.fromJson(json["freeTime"]),
  );

  Map<String, dynamic> toJson() => {
    "totalTime": totalTime == null ? null : totalTime.toJson(),
    "studyTime": studyTime == null ? null : studyTime.toJson(),
    "classTime": classTime == null ? null : classTime.toJson(),
    "freeTime": freeTime == null ? null : freeTime.toJson(),
  };
}

class ChartDataClassTime {
  ChartDataClassTime({
    this.total,
  });

  final String total;

  factory ChartDataClassTime.fromJson(Map<String, dynamic> json) => ChartDataClassTime(
    total: json["total"] == null ? null : json["total"],
  );

  Map<String, dynamic> toJson() => {
    "total": total == null ? null : total,
  };
}

class DeviceUsage {
  DeviceUsage({
    this.totalTime,
    this.studyTime,
    this.classTime,
    this.freeTime,
  });

  final DeviceUsageClassTime totalTime;
  final DeviceUsageClassTime studyTime;
  final DeviceUsageClassTime classTime;
  final DeviceUsageClassTime freeTime;

  factory DeviceUsage.fromJson(Map<String, dynamic> json) => DeviceUsage(
    totalTime: json["totalTime"] == null ? null : DeviceUsageClassTime.fromJson(json["totalTime"]),
    studyTime: json["studyTime"] == null ? null : DeviceUsageClassTime.fromJson(json["studyTime"]),
    classTime: json["classTime"] == null ? null : DeviceUsageClassTime.fromJson(json["classTime"]),
    freeTime: json["freeTime"] == null ? null : DeviceUsageClassTime.fromJson(json["freeTime"]),
  );

  Map<String, dynamic> toJson() => {
    "totalTime": totalTime == null ? null : totalTime.toJson(),
    "studyTime": studyTime == null ? null : studyTime.toJson(),
    "classTime": classTime == null ? null : classTime.toJson(),
    "freeTime": freeTime == null ? null : freeTime.toJson(),
  };
}

class DeviceUsageClassTime {
  DeviceUsageClassTime({
    this.mobile,
    this.laptop,
  });

  final String mobile;
  final String laptop;

  factory DeviceUsageClassTime.fromJson(Map<String, dynamic> json) => DeviceUsageClassTime(
    mobile: json["mobile"] == null ? null : json["mobile"],
    laptop: json["laptop"] == null ? null : json["laptop"],
  );

  Map<String, dynamic> toJson() => {
    "mobile": mobile == null ? null : mobile,
    "laptop": laptop == null ? null : laptop,
  };
}
