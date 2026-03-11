import 'package:book_store/core/helper/spacing.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class BookRating extends StatelessWidget {
  final dynamic mainAxisAlignment;

  const BookRating({
    super.key,
    this.mainAxisAlignment = MainAxisAlignment.start,
  });
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: mainAxisAlignment,
      children: [
        const Icon(
          FontAwesomeIcons.solidStar,
          color: Color(0xffFFDD4F),
          size: 16,
        ),
        horizontalSpace(5),
        Text('4.8', style: TextStyle(fontSize: 14.sp)),
        horizontalSpace(5),
        Text(
          '(245)',
          style: TextStyle(fontSize: 14.sp, color: Colors.grey),
        ),
      ],
    );
  }
}
