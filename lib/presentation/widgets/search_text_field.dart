import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SearchTextField extends StatelessWidget {
  final TextEditingController? controller;
  final ValueChanged<String>? onChanged;
  final VoidCallback? onSubmitted;

  const SearchTextField({
    super.key,
    this.controller,
    this.onChanged,
    this.onSubmitted,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      key: const ValueKey('searchField'),
      controller: controller,
      autofocus: true,
      style: TextStyle(
        fontSize: _getResponsiveFontSize(context),
      ),
      decoration: InputDecoration(
        hintText: 'Search Book',
        hintStyle: TextStyle(
          fontSize: _getResponsiveFontSize(context),
          color: Colors.grey.shade500,
        ),
        isDense: true,
        contentPadding: EdgeInsets.symmetric(
          horizontal: 16.w,
          vertical: 12.h,
        ),
        filled: true,
        fillColor: Colors.grey.shade100,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(22.r),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(22.r),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(22.r),
          borderSide: BorderSide(
            color: Colors.grey.shade300,
            width: 1.w,
          ),
        ),
      ),
      onChanged: onChanged,
      onSubmitted: onSubmitted != null ? (_) => onSubmitted!() : null,
    );
  }

  double _getResponsiveFontSize(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    
    if (width < 360) {
      return 14.sp;
    } else {
      return 16.sp;
    }
  }
}