// // import 'package:firebase_core/firebase_core.dart';
// // import 'package:flutter/material.dart';
// // import 'package:movie_app/core/resourses/router_manager.dart';
// // import 'package:movie_app/core/routers.dart';
// // import 'package:flutter_screenutil/flutter_screenutil.dart';
// // import 'config/theme/theme_manager.dart';
// //
// // void main() async{
// //   WidgetsFlutterBinding.ensureInitialized();
// //   await Firebase.initializeApp();
// //   runApp(MovieApp());
// //
// // }
// // class MovieApp extends StatelessWidget{
// //   @override
// //   Widget build(BuildContext context) {
// //     //var configProvider = Provider.of<ConfigProvider>(context);
// //     //var languageProvider = Provider.of<LanguageProvider>(context);
// //     return ScreenUtilInit(
// //       designSize: const Size(393, 841),
// //       splitScreenMode: true,
// //       // فكرة فتح اكتر من app فى نفس الوقت
// //       minTextAdapt: true,
// //       // text => responsive
// //       builder: (context, child) {
// //         return MaterialApp(
// //           debugShowCheckedModeBanner: false,
// //           onGenerateRoute: RoutesManager.router,
// //           initialRoute: AppRoutes.SearchScreen,
// //           theme: ThemeManager.light,
// //           darkTheme: ThemeManager.dark,
// //           locale: Locale("en"),
// //           supportedLocales: [Locale("en"), Locale("ar")],
// //         );
// //       },
// //       child: SizedBox.shrink(),
// //     );
// //   }
// // }
//
//
// import 'package:firebase_core/firebase_core.dart';
// import 'package:flutter/material.dart';
// import 'package:movie_app/core/resourses/router_manager.dart';
// import 'package:movie_app/core/routers.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'config/theme/theme_manager.dart';
// import 'data/repositories/screens/main_screen.dart';
//
// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await Firebase.initializeApp();
//   runApp(MovieApp());
// }
//
// class MovieApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return ScreenUtilInit(
//       designSize: const Size(393, 841),
//       splitScreenMode: true,
//       minTextAdapt: true,
//       builder: (context, child) {
//         return MaterialApp(
//           debugShowCheckedModeBanner: false,
//
//           /// 🚀 هنا التعديل الأساسي
//           onGenerateRoute: RoutesManager.router,
//           initialRoute: AppRoutes.SearchScreen, // ← ابدأ بالمين
//
//           theme: ThemeManager.light,
//           darkTheme: ThemeManager.dark,
//           locale: Locale("en"),
//           supportedLocales: [Locale("en"), Locale("ar")],
//         );
//       },
//       child: SizedBox.shrink(),
//     );
//   }
// }
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movie_app/core/routers.dart';
import 'package:movie_app/core/routers.dart';
import 'config/theme/theme_manager.dart';
import 'core/resourses/router_manager.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MovieApp());
}

class MovieApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(393, 841),
      splitScreenMode: true,
      minTextAdapt: true,
      builder: (context, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          onGenerateRoute: RoutesManager.router,
          initialRoute: AppRoutes.HomeScreen,  // ⬅ الآن يشغّل MainScreen
          theme: ThemeManager.light,
          darkTheme: ThemeManager.dark,
          locale: Locale("en"),
          supportedLocales: [Locale("en"), Locale("ar")],
        );
      },
    );
  }
}
