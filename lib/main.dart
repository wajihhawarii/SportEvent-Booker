import 'package:ci_projecct/core/data_base/app_database.dart';
import 'package:ci_projecct/core/di/dependency_injection.dart';
import 'package:ci_projecct/core/utils/bloc_observer/bloc_observer.dart';
import 'package:ci_projecct/core/utils/routing/app_router.dart';
import 'package:ci_projecct/core/utils/routing/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // inti for lacal db
  await AppDatabase.database;
  // dependenc injections
  await setupGetIt();
  // To log cubits state changes
  Bloc.observer = MyBlocObserver();
  //
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  // run app
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, wiget) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          // start page
          initialRoute: Routes.homePage,
          // for navigation
          onGenerateRoute: AppRouter().generateRoute,
        );
      },
    );
  }
}
