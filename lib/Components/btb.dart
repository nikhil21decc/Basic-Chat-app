import 'package:flutter/material.dart';

class Rbtn extends StatelessWidget {
  final Function f1;
  final String s2;
  final Color s3;

  Rbtn(this.f1, this.s2, this.s3);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 16.0),
      child: Material(
        elevation: 5.0,
        color: s3,
        borderRadius: BorderRadius.circular(30.0),
        child: MaterialButton(
          onPressed: f1,
          minWidth: 200.0,
          height: 42.0,
          child: Text(
            s2,
          ),
        ),
      ),
    );
  }
}
