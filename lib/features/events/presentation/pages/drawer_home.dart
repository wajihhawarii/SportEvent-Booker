import 'package:ci_projecct/core/utils/app_colors.dart';
import 'package:ci_projecct/core/utils/app_text.dart';
import 'package:ci_projecct/core/utils/routing/extentations.dart';
import 'package:ci_projecct/core/utils/routing/routes.dart';
import 'package:ci_projecct/features/events/presentation/widgets/drawer/drawer_header.dart';
import 'package:ci_projecct/features/events/presentation/widgets/drawer_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Widget buildDrawer(BuildContext context) {
  return Drawer(
    backgroundColor: Colors.grey.shade100,
    child: Column(
      children: [
        // ================= HEADER =================
        CustomDrawerHeader(),
        SizedBox(height: 12.h),
        // ================= MENU =================
        Expanded(
          child: ListView(
            padding: EdgeInsets.symmetric(horizontal: 12.w),
            children: [
              buildDrawerItem(
                context,
                icon: Icons.bookmark,
                title: AppText.mybookings,
                onTap: () {
                  context.pop();
                  context.pushNamed(Routes.myBookingPage);
                },
              ),
              buildDrawerItem(
                context,
                icon: Icons.event,
                title: AppText.allEvents,
                onTap: () {
                  context.pop();
                  context.pushNamed(Routes.homePage);
                },
              ),
              const Divider(),
              buildDrawerItem(
                context,
                icon: Icons.logout,
                title: AppText.logout,
                color: AppColors.red,
                onTap: () {
                  context.pop();
                },
              ),
            ],
          ),
        ),
        // ================= FOOTER =================
        Padding(
          padding: EdgeInsets.only(bottom: 16.h),
          child: Text(
            AppText.version,
            style: TextStyle(fontSize: 12.sp, color: Colors.grey),
          ),
        ),
      ],
    ),
  );
}
