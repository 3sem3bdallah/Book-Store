import 'package:book_store/core/constant/app_colors.dart';
import 'package:book_store/core/helper/spacing.dart';
import 'package:book_store/presentation/widgets/search_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomAppBar extends StatefulWidget {
  const CustomAppBar({super.key});

  @override
  State<CustomAppBar> createState() => _CustomAppBarState();
}

class _CustomAppBarState extends State<CustomAppBar> {
  bool isSearching = false;
  final TextEditingController controller = TextEditingController();

  void toggleSearch() {
    setState(() {
      isSearching = !isSearching;
      if (!isSearching) {
        controller.clear();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(Icons.book, size: 24, color: AppColors.primaryDark),
        horizontalSpace(5),

        Expanded(
          child: AnimatedSwitcher(
            duration: const Duration(milliseconds: 300),
            child: isSearching
                ? TextField(
                    key: const ValueKey("searchField"),
                    controller: controller,
                    autofocus: true,
                    decoration: InputDecoration(
                      hintText: "Search Book",
                      isDense: true,
                      filled: true,
                      fillColor: Colors.grey.shade100,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(22),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  )
                : Text(
                    "Bookstore",
                    key: const ValueKey("title"),
                    style: TextStyle(
                      fontSize: 20.sp,
                      fontWeight: FontWeight.bold,
                      color: AppColors.primaryDark,
                    ),
                  ),
          ),
        ),

        IconButton(
          icon: Icon(
            isSearching ? Icons.close : Icons.search,
            size: 24.h,
            color: AppColors.primaryDark,
          ),
          onPressed: toggleSearch,
        ),
      ],
    );
  }
}
