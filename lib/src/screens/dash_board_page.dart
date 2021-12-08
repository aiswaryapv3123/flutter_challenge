import 'dart:convert';

import 'package:challenge/src/bloc/dash_borad_bloc/dash_board_bloc.dart';
import 'package:challenge/src/bloc/dash_borad_bloc/events.dart';
import 'package:challenge/src/bloc/dash_borad_bloc/states.dart';
import 'package:challenge/src/constants/constants.dart';
import 'package:challenge/src/models/get_dashboard_data_response.dart';
import 'package:challenge/src/widgets/custom_button.dart';
import 'package:challenge/src/widgets/device_tile.dart';
import 'package:challenge/src/widgets/dot_indicators.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_bloc/flutter_bloc.dart';

class DashBoardPage extends StatefulWidget {
  // const DashBoardPage({Key? key}) : super(key: key);

  @override
  _DashBoardPageState createState() => _DashBoardPageState();
}

class _DashBoardPageState extends State<DashBoardPage> {
  bool select = false;
  List<Color> chartColors = [
    Color(0xff2D82FE),
    Color(0xFFFF9E57),
    Color(0xFF2FED51),
  ];
  List<String> chartLabels = [
    "Class",
    "Study",
    "Free-time",
  ];
  List<ChartData> chartData = [];
  List<DeviceUsage> deviceData = [];
  List<String> chartTime = [];
  List<GetDashboardDataResponse> data = [];
  String freeTimeUsage;
  bool loading = true;
  int time;

  String getTimeString(int value) {
    final int hour = value ~/ 60;
    final int minutes = value % 60;
    return hour > 0 && minutes == 0
        ? '${hour.toString().padLeft(2, "")}h '
        : hour == 0 && minutes > 0
            ? ' ${minutes.toString().padLeft(2, "")}m'
            : '${hour.toString().padLeft(2, "")}h ${minutes.toString().padLeft(2, "")}m';
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // getData();
    _loadData();
  }

  _loadData() async {
    context.bloc<DashBoardBloc>().add(DashBoardEvents.fetchDashBoard);
  }

  getData() async {
    final url = "https://api.mocklets.com/p68289/screentime";
    var response = await http.get(url);
    print(response.body);
    Iterable iterable = json.decode(response.body).toList();
    setState(
      () {
        data = iterable
            .map((list) => GetDashboardDataResponse.fromJson(list))
            .toList();
        loading = false;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppConstants.gradients[0],
      appBar: AppBar(
        backgroundColor: AppConstants.gradients[0],
        shadowColor: AppConstants.gradients[1].withOpacity(0.4),
        elevation: 3,
        leading: Container(),
        actions: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.width * .12,
            decoration: BoxDecoration(color: Colors.white, boxShadow: [
              BoxShadow(
                color: Colors.grey.shade500,
                offset: Offset(0.1, 0.0),
                blurRadius: 1.0,
                spreadRadius: 1.0,
              )
            ]),
            padding: EdgeInsets.symmetric(
              horizontal: MediaQuery.of(context).size.width * 0.05,
            ),
            child: Row(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width * .10,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        Color(0xFFFFFBA3),
                        Color(0xFFE330BC).withOpacity(0.4),
                      ],
                      // stops:[
                      //   0.5,
                      //   0.8
                      // ]
                    ),
                  ),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * .05,
                ),
                Text(
                  "Michael",
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: AppConstants.gradients[1],
                      fontFamily: "EuclidCircularB"),
                ),
                Spacer(),
                GestureDetector(
                  child: Icon(
                    Icons.settings_outlined,
                    color: AppConstants.gradients[1].withOpacity(0.5),
                  ),
                )
              ],
            ),
          ),
        ],
        // leading: Row(
        //   children: [
        //     SizedBox(
        //       width: MediaQuery.of(context).size.width * .04,
        //     ),
        //     Container(
        //       width: MediaQuery.of(context).size.width * .10,
        //       // height: MediaQuery.of(context).size.width * .05,
        //       decoration: BoxDecoration(
        //         shape: BoxShape.circle,
        //         gradient: LinearGradient(
        //           begin: Alignment.topLeft,
        //           end: Alignment.bottomRight,
        //           colors: [
        //             Color(0xFFFFFBA3),
        //             Color(0xFFE330BC).withOpacity(0.4),
        //           ],
        //           // stops:[
        //           //   0.5,
        //           //   0.8
        //           // ]
        //         ),
        //       ),
        //     ),
        //   ],
        // ),
        // title: Container(
        //   width: MediaQuery.of(context).size.width * .90,
        //   // color:Colors.red,
        //   child: Row(
        //     children: [
        //       Text(
        //         "Michael",
        //         style: TextStyle(
        //             fontSize: 14,
        //             fontWeight: FontWeight.w400,
        //             color: AppConstants.gradients[1],
        //             fontFamily: "EuclidCircularB"),
        //       ),
        //       Spacer(),
        //       GestureDetector(
        //         child: Icon(
        //           Icons.settings_outlined,
        //           color: AppConstants.gradients[1].withOpacity(0.5),
        //         ),
        //       )
        //     ],
        //   ),
        // ),
      ),
      body: SingleChildScrollView(
        child: Container(
            width: MediaQuery.of(context).size.width,
            padding: EdgeInsets.symmetric(
              horizontal: MediaQuery.of(context).size.width * 0.08,
            ),
            child: BlocBuilder<DashBoardBloc, DashBoardState>(
                builder: (BuildContext context, DashBoardState state) {
              if (state is DashBoardError) {
                final error = state.error;
                return Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height*0.8,
                  child: Center(
                    child: Text(error.message,style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: AppConstants.gradients[7],
                        fontFamily: "EuclidCircularB"),),
                  ),
                );
              }
              if (state is DashBoardLoaded) {
                List<GetDashboardDataResponse> dashBoardData =
                    state.dashBoardData;
                return dashBoardWidget(dashBoardData);
              } else
                return Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height*0.8,
                  child: Center(
                    child: SizedBox(
                      width: 18,
                      height: 18,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        valueColor: AlwaysStoppedAnimation<Color>(
                          AppConstants.gradients[3],
                        ),
                      ),
                    ),
                  ),
                );
            })),
      ),
    );
  }

  Widget dashBoardWidget(List<GetDashboardDataResponse> dashBoardData) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.width * .05,
          ),
          Text(
            "Dashboard",
            style: TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,
                color: AppConstants.gradients[1],
                fontFamily: "EuclidCircularB"),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.width * .10,
          ),
          Stack(
            children: [
              CircularPercentIndicator(
                radius: 200.0,
                lineWidth: MediaQuery.of(context).size.width * .035,
                animation: false,
                percent: (double.parse(
                        dashBoardData[0].chartData.classTime.total) /
                    double.parse(dashBoardData[0].chartData.totalTime.total)),
                startAngle: 180,
                center: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Total",
                      style: TextStyle(
                          fontWeight: FontWeight.w700, fontSize: 20.0),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.width * .03,
                    ),
                    Text(
                      getTimeString(int.parse(
                          dashBoardData[0].chartData.totalTime.total)),
                      style: TextStyle(
                          fontWeight: FontWeight.w400, fontSize: 27.0),
                    ),
                  ],
                ),
                circularStrokeCap: CircularStrokeCap.round,
                progressColor: AppConstants.gradients[7],
                backgroundColor: AppConstants.gradients[4],
              ),
              CircularPercentIndicator(
                radius: 200.0,
                lineWidth: MediaQuery.of(context).size.width * .035,
                animation: false,
                percent: (double.parse(
                        dashBoardData[0].chartData.studyTime.total) /
                    double.parse(dashBoardData[0].chartData.totalTime.total)),
                startAngle: 180,
                circularStrokeCap: CircularStrokeCap.round,
                progressColor: AppConstants.gradients[5],
                backgroundColor: Colors.transparent,
              ),
            ],
          ),
          SizedBox(
            height: MediaQuery.of(context).size.width * .10,
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.width * .20,
            child: Center(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Spacer(),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * .03,
                  ),
                  DotIndicator(
                      color: chartColors[0],
                      label: chartLabels[0],
                      time: getTimeString(int.parse(
                          dashBoardData[0].chartData.classTime.total))),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * .03,
                  ),
                  DotIndicator(
                      color: chartColors[1],
                      label: chartLabels[1],
                      time: getTimeString(int.parse(
                          dashBoardData[0].chartData.studyTime.total))),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * .03,
                  ),
                  DotIndicator(
                      color: chartColors[2],
                      label: chartLabels[2],
                      time: getTimeString(int.parse(
                          dashBoardData[0].chartData.freeTime.total))),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * .03,
                  ),
                  // Spacer(),
                ],
              ),
              // child: ListView.builder(
              //   itemCount: 3,
              //   shrinkWrap: true,
              //   physics: NeverScrollableScrollPhysics(),
              //   scrollDirection: Axis.horizontal,
              //   itemBuilder: (BuildContext context, int index) {
              //     return Row(
              //       crossAxisAlignment: CrossAxisAlignment.center,
              //       mainAxisAlignment: MainAxisAlignment.center,
              //       children: [
              //         // Spacer(),
              //         SizedBox(
              //           width: MediaQuery.of(context).size.width * .03,
              //         ),
              //         DotIndicator(
              //             color: chartColors[index],
              //             label: chartLabels[index],
              //             time: "50m"),
              //         SizedBox(
              //           width: MediaQuery.of(context).size.width * .03,
              //         ),
              //         // Spacer(),
              //       ],
              //     );
              //   },
              // ),
            ),
          ),
          Divider(color: Colors.grey.shade300),
          SizedBox(
            height: MediaQuery.of(context).size.width * .04,
          ),
          Text(
            "Free-time Usage",
            style: TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.w500,
                color: AppConstants.gradients[1],
                fontFamily: "EuclidCircularB"),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.width * .10,
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            child: Row(
              children: [
                Text(
                  "Used",
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: AppConstants.gradients[1],
                      fontFamily: "EuclidCircularB"),
                ),
                Spacer(),
                Text(
                  "Max",
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: AppConstants.gradients[1],
                      fontFamily: "EuclidCircularB"),
                ),
              ],
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.width * .02,
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            child: Row(
              children: [
                Text(
                  getTimeString(
                      int.parse(dashBoardData[0].chartData.freeTime.total)),
                  style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w700,
                      color: AppConstants.gradients[2],
                      fontFamily: "EuclidCircularB"),
                ),
                Spacer(),
                Text(
                  getTimeString(int.parse(dashBoardData[0].freeTimeMaxUsage)),
                  style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w600,
                      color: AppConstants.gradients[1],
                      fontFamily: "EuclidCircularB"),
                ),
              ],
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.width * .025,
          ),
          LinearPercentIndicator(
            width: MediaQuery.of(context).size.width * 0.84,
            animation: true,
            lineHeight: MediaQuery.of(context).size.width * 0.05,
            animationDuration: 1000,
            percent: (double.parse(dashBoardData[0].chartData.freeTime.total) /
                double.parse(dashBoardData[0].freeTimeMaxUsage)),
            center: Text(""),
            linearStrokeCap: LinearStrokeCap.roundAll,
            progressColor: AppConstants.gradients[4],
            backgroundColor: AppConstants.gradients[6],
          ),
          SizedBox(
            height: MediaQuery.of(context).size.width * .06,
          ),
          CustomButton(
              label: "Extend Free-time",
              isDisabled: !select,
              onPressed: () {
                setState(() {
                  select = false;
                });
              }),
          SizedBox(
            height: MediaQuery.of(context).size.width * .04,
          ),
          CustomButton(
              label: "Change Time Restrictions",
              isDisabled: select,
              onPressed: () {
                setState(() {
                  select = true;
                });
              }),
          SizedBox(
            height: MediaQuery.of(context).size.width * .02,
          ),
          Divider(color: Colors.grey.shade300),
          SizedBox(
            height: MediaQuery.of(context).size.width * .04,
          ),
          Text(
            "By Devices",
            style: TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.w500,
                color: AppConstants.gradients[1],
                fontFamily: "EuclidCircularB"),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.width * .10,
          ),
          DeviceTile(
              image: "assets/images/mobile.svg",
              type: "Phone",
              time: getTimeString(
                  int.parse(dashBoardData[0].deviceUsage.totalTime.mobile))),
          SizedBox(
            height: MediaQuery.of(context).size.width * .10,
          ),
          DeviceTile(
              image: "assets/images/laptop.svg",
              type: "Laptop",
              time: getTimeString(
                  int.parse(dashBoardData[0].deviceUsage.totalTime.laptop))),
          SizedBox(
            height: MediaQuery.of(context).size.width * .1,
          ),
          Text(
            "See All Devices",
            style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: AppConstants.gradients[7],
                fontFamily: "EuclidCircularB"),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.width * .10,
          ),
        ],
      ),
    );
  }
}
