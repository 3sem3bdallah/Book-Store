import 'package:book_store/core/helper/spacing.dart';
import 'package:book_store/presentation/widgets/book_rating.dart';
import 'package:book_store/presentation/widgets/books_action.dart';
import 'package:book_store/presentation/widgets/custom_book_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BookDetailsScreen extends StatelessWidget {
  const BookDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              verticalSpace(40),

              const CustomBookImage(),

              verticalSpace(24),

              Text(
                'Displacement',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 24.sp,
                ),
              ),

              verticalSpace(6),

              Text(
                'Rudyard Kipling',
                style: TextStyle(
                  fontSize: 16.sp,
                  color: Colors.grey,
                  fontWeight: FontWeight.w500,
                ),
              ),

              verticalSpace(12),

              const BookRating(
                mainAxisAlignment: MainAxisAlignment.center,
              ),

              verticalSpace(30),

              const BooksAction(),

              const Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}