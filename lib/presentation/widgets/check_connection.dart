import 'package:book_store/core/helper/spacing.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';

class NoInternetWidget extends StatelessWidget {
  const NoInternetWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        color: Colors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            verticalSpace(20),
            Text(
              "No Internet Connection",
              style: TextStyle(fontSize: 24.sp, color: Colors.grey),
            ),
            Lottie.asset('assets/animation/no_internet.json'),
          ],
        ),
      ),
    );
  }
}
