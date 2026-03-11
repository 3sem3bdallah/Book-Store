import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomBookImage extends StatelessWidget {
  const CustomBookImage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 260.h,
      width: 180.w,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: .15),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
        image: const DecorationImage(
          fit: BoxFit.cover,
          image: AssetImage('assets/images/testo.png'),
        ),
      ),
    );
  }
}
