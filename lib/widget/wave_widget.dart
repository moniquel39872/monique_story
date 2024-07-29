import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kombat_flutter/utils/app_image.dart';

class WaveWidget extends StatelessWidget {
  const WaveWidget({
    Key? key,
    required this.image,
  }) : super(key: key);

  final String image;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(15.w),
      decoration: const BoxDecoration(
          shape: BoxShape.circle,
          // color: Color(0xff786524),
          boxShadow: [
            BoxShadow(
              color: Color(0xff594a13),
              spreadRadius: 10,
              blurRadius: 40,
              offset: Offset(0, 0), // changes position of shadow
            ),
          ]),
      child: Container(
        padding: EdgeInsets.all(15.w),
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          // color: Color(0xff766424),
          boxShadow: [
            BoxShadow(
              color: Color(0xff766424),
              spreadRadius: 3,
              blurRadius: 2,
              offset: Offset(0, 0), // changes position of shadow
            ),
          ],
        ),
        child: Container(
          padding: EdgeInsets.all(15.w),
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            // color: Color(0xff988234),
            boxShadow: [
            BoxShadow(
              color: Color(0xff988234),
              spreadRadius: 2,
              blurRadius: 1,
              offset: Offset(0, 0), // changes position of shadow
            ),
          ],
          ),
          child: AppImage.asset(
            '${image}',
            width: 120.w,
            height: 120.w,
            fit: BoxFit.fill,
          ),
        ),
      ),
    );
  }
}
