import 'package:ci_projecct/core/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Widget buildDrawerItem(
  BuildContext context, {
  required IconData icon,
  required String title,
  Color? color,
  required VoidCallback onTap,
}) {
  return Card(
    elevation: 2.h,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    margin: EdgeInsets.symmetric(vertical: 6.h),
    child: ListTile(
      leading: Icon(icon, color: color ?? AppColors.blue),
      title: Text(
        title,
        style: TextStyle(
          fontSize: 14.sp,
          fontWeight: FontWeight.w500,
          color: color ?? Colors.black87,
        ),
      ),
      trailing: Icon(Icons.arrow_forward_ios, size: 14.sp),
      onTap: onTap,
    ),
  );
}
