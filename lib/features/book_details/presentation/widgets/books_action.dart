import '../../../home/data/models/book_model.dart';
import '../../../../core/constant/app_colors.dart';
import '../../../../core/widgets/custom_buttom.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BooksAction extends StatelessWidget {
  const BooksAction({super.key, required this.book});

  final BookModel book;

  @override
  Widget build(BuildContext context) {
    final priceLabel = _priceLabel();
    final previewLabel = _previewLabel();

    return SizedBox(
      height: 50.h,
      child: Row(
        children: [
          Expanded(
            child: CustomButton(
              fontSize: 16.sp,
              text: priceLabel,
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
              text: previewLabel,
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

  String _priceLabel() {
    if (book.saleInfo?.isEbook == true) {
      return 'Free';
    }

    return 'Not for sale';
  }

  String _previewLabel() {
    if ((book.volumeInfo.previewLink ?? '').isNotEmpty) {
      return 'Free Preview';
    }

    return 'Details';
  }
}
