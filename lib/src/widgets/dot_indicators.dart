import 'package:challenge/src/constants/constants.dart';
import 'package:flutter/material.dart';

class DotIndicator extends StatefulWidget {
  const DotIndicator({Key key, this.color, this.label, this.time})
      : super(key: key);
  final Color color;
  final String label;
  final String time;

  @override
  _DotIndicatorState createState() => _DotIndicatorState();
}

class _DotIndicatorState extends State<DotIndicator> {
  @override
  Widget build(BuildContext context) {
    return Container(
      // width: MediaQuery.of(context).size.width * .3,
      // color: Colors.amber,
      child:
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment:CrossAxisAlignment.start,
            children: [
              Container(
                width: MediaQuery.of(context).size.width * .04,
                height: MediaQuery.of(context).size.width * .04,
                decoration:
                    BoxDecoration(shape: BoxShape.circle, color: widget.color),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * .02,
              ),
              Column(
                crossAxisAlignment:CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.label,
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: AppConstants.gradients[1],
                        fontFamily: "EuclidCircularB"),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.width * .01,
                  ),
                  Text(
                    widget.time,
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                        color: AppConstants.gradients[1],
                        fontFamily: "EuclidCircularB"),
                  ),
                ],
              )
            ],
          ),
    );
  }
}
