import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class AppBottomsheetWidget extends StatelessWidget {
  const AppBottomsheetWidget({
    Key? key,
    required this.child,
  }) : super(key: key);
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Stack(
          alignment: AlignmentDirectional.centerEnd,
          children: [
            Stack(
              alignment: AlignmentDirectional.bottomCenter,
              children: [
                Container(
                  height: 30,
                  decoration: BoxDecoration(
                      color: Colors.yellow,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(35),
                        topRight: Radius.circular(35),
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.yellow,
                          spreadRadius: 8,
                          blurRadius: 40,
                          offset: Offset(0, 3), // changes position of shadow
                        ),
                      ]),
                ),
                Container(
                  height: 28,
                  decoration: BoxDecoration(
                    color: Color(0xff1C1F24),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(38),
                      topRight: Radius.circular(38),
                    ),
                  ),
                ),
              ],
            ),
            GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Container(
                margin: EdgeInsets.only(right: 15),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Color(0xff4E4F50),
                ),
                child: Icon(
                  Icons.close_rounded,
                  size: 18,
                ),
              ),
            ),
          ],
        ),
        Container(
          color: const Color(0xff1C1F24),
          padding: EdgeInsets.zero,
          width: double.infinity,
          child: child,
        ),
      ],
    );
  }
}
