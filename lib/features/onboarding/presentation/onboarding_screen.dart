import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:slide_to_act/slide_to_act.dart';

import '../../../core/constant/app_colors.dart';
import '../../../core/constant/app_img.dart';
import '../../../core/helper/spacing.dart';
import '../../../core/utils/router_transitions.dart';
import '../../home/presentation/home_screen.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primary,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(24.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              verticalSpace(65),
              Image.asset(AppImg.onboard, height: 250.h, fit: BoxFit.contain),
              verticalSpace(40),

              /// Title
              Text(
                "Welcome to our App",
                style: TextStyle(
                  fontSize: 26.sp,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
                textAlign: TextAlign.center,
              ),

              verticalSpace(12),

              /// Subtitle
              Text(
                "Read all your favorite books anytime,\nanywhere in one place.",
                style: TextStyle(
                  fontSize: 16.sp,
                  color: Colors.white.withValues(alpha: 0.8),
                  height: 1.5,
                ),
                textAlign: TextAlign.center,
              ),

              const Spacer(),

              /// Get Started Button
              SlideAction(
                text: "Get Started",
                innerColor: AppColors.primary,
                outerColor: AppColors.primaryDark,
                onSubmit: () {
                  Navigator.push(
                    context,
                    RouterTransitions.buildScale(const HomeScreen()),
                  );
                  return null;
                },
              ),

              verticalSpace(24),

              /// Terms & Conditions
              RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  style: TextStyle(
                    fontSize: 13.sp,
                    color: Colors.white.withValues(alpha: 0.7),
                  ),
                  children: [
                    const TextSpan(text: "By continuing, you agree to our "),
                    TextSpan(
                      text: "Terms & Conditions",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),

              verticalSpace(20),
            ],
          ),
        ),
      ),
    );
  }
}
