import 'package:flutter/material.dart';

class AppButton extends StatelessWidget {
  Function onPressed;
  String text;
  bool showProgress;

  AppButton(
    this.text, {
    @required this.onPressed,
    this.showProgress = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 46,
      child: RaisedButton(
        onPressed: onPressed,
        color: Colors.blue,
        child: showProgress
            ? Center(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation(Colors.white),
                ),
              )
            : Text(
                text,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 22,
                ),
              ),
      ),
    );
    ;
  }
}
