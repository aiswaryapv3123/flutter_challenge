import 'package:flutter/material.dart';
import 'package:challenge/src/constants/constants.dart';
import 'package:flutter_svg/flutter_svg.dart';

class DeviceTile extends StatefulWidget {
  const DeviceTile({Key key, this.image, this.type, this.time}) : super(key: key);
  final String image;
  final String type;
  final String time;

  @override
  _DeviceTileState createState() => _DeviceTileState();
}

class _DeviceTileState extends State<DeviceTile> {
  @override
  Widget build(BuildContext context) {
    return Container(
        width: MediaQuery.of(context).size.width ,
      child:Row(
        mainAxisAlignment:MainAxisAlignment.center,
        children:[
          Container(
              width: MediaQuery.of(context).size.width *.3,
              child: SvgPicture.asset(widget.image)),
          SizedBox(
            width: MediaQuery.of(context).size.width * .1,
          ),
          // Spacer(),
          Container(
            width: MediaQuery.of(context).size.width *.4,
            // color:Colors.red,
            child: Column(
                crossAxisAlignment:CrossAxisAlignment.start,
                children: [
                  Text(
                    "Adi's "+widget.type,
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: AppConstants.gradients[1],
                        fontFamily: "EuclidCircularB"),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.width * .01,
                  ),
                  Text(
                    widget.time,
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w400,
                        color: AppConstants.gradients[7],
                        fontFamily: "EuclidCircularB"),
                  ),

              ]
            ),
          )

        ]
      )
    );
  }
}
