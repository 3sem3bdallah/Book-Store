import '../../../../core/constant/app_colors.dart';
import '../../../../core/widgets/custom_buttom.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BooksAction extends StatelessWidget {
  const BooksAction({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50.h,
      child: Row(
        children: [
          Expanded(
            child: CustomButton(
              fontSize: 16.sp,
              text: '16.55€',
              backgroundColor: AppColors.bg,
              textColor: AppColors.primaryDark,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(16.r),
                bottomLeft: Radius.circular(16.r),
              ),
            ),
          ),
          Expanded(
            child: CustomButton(
              fontSize: 16.sp,
              text: 'Free Preview',
              backgroundColor: AppColors.primary,
              textColor: Colors.white,
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(16.r),
                bottomRight: Radius.circular(16.r),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
