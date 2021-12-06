import 'package:flutter/material.dart';
import 'package:challenge/src/constants/constants.dart';

class CustomButton extends StatefulWidget {
  const CustomButton({Key key, this.label, this.onPressed, this.isDisabled}) : super(key: key);
  final String label;
  final Function onPressed;
  final bool isDisabled;

  @override
  _CustomButtonState createState() => _CustomButtonState();
}

class _CustomButtonState extends State<CustomButton> {
  bool select = false;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap:widget.onPressed,
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.width * 0.11,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(7),
            border: Border.all(color: widget.isDisabled == true ? AppConstants.gradients[7] : Colors.transparent, width: 1.5),
            color: Colors.transparent),
        child:Center(child: Text(widget.label,style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: AppConstants.gradients[7],
            fontFamily: "EuclidCircularB"),))
      ),
    );
  }
}
