import 'package:ci_projecct/core/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FilterChips extends StatelessWidget {
  final List<String> categories;
  final String selectedCategory;
  final Function(String) onSelected;

  const FilterChips({
    required this.categories,
    required this.selectedCategory,
    required this.onSelected,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40.h,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          final category = categories[index];
          final isSelected = category == selectedCategory;
          return ChoiceChip(
            label: Text(category),
            selected: isSelected,
            onSelected: (_) => onSelected(category),
            backgroundColor: AppColors.white,
            selectedColor: AppColors.blue.withOpacity(0.2),
          );
        },
        separatorBuilder: (_, __) => SizedBox(width: 8.w),
        itemCount: categories.length,
      ),
    );
  }
}
