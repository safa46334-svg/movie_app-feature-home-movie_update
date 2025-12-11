// //
// // import 'package:flutter/material.dart';
// // import 'package:flutter_bloc/flutter_bloc.dart';
// // import 'package:http/http.dart' as http;
// // import 'package:movie_app/core/resourses/app_colors.dart';
// //
// // // Search Feature Imports
// // import '../../../feature/tabs/search tab/presintaion/cubit/search_tab_view_model.dart';
// // import '../../../feature/tabs/search tab/data/data scourcs/search_tab_data_source_impl.dart';
// // import '../../../feature/tabs/search tab/data/repository_impl/search_tab_repository_impl.dart';
// // import '../../../feature/tabs/search tab/domain/usecases/search_usecase.dart';
// // import '../../../feature/tabs/search tab/presintaion/screen/search_tab_screen..dart';
// //
// // // Other Screens
// // import 'home_screen.dart';
// // import 'browse_screen.dart';
// // import 'profile_screen.dart';
// //
// //
// // class MainScreen extends StatefulWidget {
// //   const MainScreen({Key? key}) : super(key: key);
// //
// //   @override
// //   _MainScreenState createState() => _MainScreenState();
// // }
// //
// // class _MainScreenState extends State<MainScreen> {
// //   int _currentIndex = 0;
// //   late final List<Widget> _screens;
// //   late final SearchUsecase searchUsecase;
// //
// //   @override
// //   void initState() {
// //     super.initState();
// //
// //     /// ⛳ هنا تم إصلاح الخطأ
// //     searchUsecase = SearchUsecase(
// //       repository: SearchTabRepositoryImpl(
// //         dataSource: SearchTabDataSourceImpl(
// //           client: http.Client(),  /// 👍 هذا كان ناقص
// //         ),
// //       ),
// //     );
// //
// //     _screens = [
// //       const HomeScreen(),
// //
// //       BlocProvider(
// //         create: (_) => SearchCubit(searchUsecase: searchUsecase),
// //         child: const SearchScreen(),
// //       ),
// //
// //       //const BrowseScreen(),
// //       const ProfileScreen(),
// //     ];
// //   }
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       backgroundColor: AppColors.black,
// //       body: _screens[_currentIndex],
// //       bottomNavigationBar: BottomNavigationBar(
// //         currentIndex: _currentIndex,
// //         onTap: (i) => setState(() => _currentIndex = i),
// //         backgroundColor: Colors.black,
// //         selectedItemColor: AppColors.yellow,
// //         unselectedItemColor: AppColors.gray,
// //         type: BottomNavigationBarType.fixed,
// //         items: const [
// //           BottomNavigationBarItem(icon: Icon(Icons.home_filled), label: "Home"),
// //           BottomNavigationBarItem(icon: Icon(Icons.search), label: "Search"),
// //           BottomNavigationBarItem(icon: Icon(Icons.explore), label: "Browse"),
// //           BottomNavigationBarItem(icon: Icon(Icons.person_outline), label: "Profile"),
// //         ],
// //       ),
// //     );
// //   }
// // }
// //
// //======================
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:http/http.dart' as http;
// import 'package:movie_app/core/resourses/app_colors.dart';
//
// // Search Feature Imports
// import '../../../feature/tabs/browse tab/prisntation/screen/brows screen.dart';
// import '../../../feature/tabs/search tab/presintaion/cubit/search_tab_view_model.dart';
// import '../../../feature/tabs/search tab/data/data scourcs/search_tab_data_source_impl.dart';
// import '../../../feature/tabs/search tab/data/repository_impl/search_tab_repository_impl.dart';
// import '../../../feature/tabs/search tab/domain/usecases/search_usecase.dart';
// import '../../../feature/tabs/search tab/presintaion/screen/search_tab_screen..dart';
//
// // Other Screens
// import 'home_screen.dart';
// import 'profile_screen.dart';
//
// class MainScreen extends StatefulWidget {
//   const MainScreen({Key? key}) : super(key: key);
//
//   @override
//   State<MainScreen> createState() => _MainScreenState();
// }
//
// class _MainScreenState extends State<MainScreen> {
//   int _currentIndex = 0;
//   late final List<Widget> _screens;
//
//   // إنشاء الـ Usecase للـ Search
//   late final SearchUsecase searchUsecase;
//
//   @override
//   void initState() {
//     super.initState();
//
//     // ✅ تهيئة الـ SearchUsecase مع Repository و DataSource
//     searchUsecase = SearchUsecase(
//       repository: SearchTabRepositoryImpl(
//         dataSource: SearchTabDataSourceImpl(client: http.Client()),
//       ),
//     );
//
//     // ✅ إعداد الشاشات مع BlocProvider للـ Search
//     _screens = [
//       const HomeScreen(),
//       BlocProvider(
//         create: (_) => SearchCubit(searchUsecase: searchUsecase),
//         child: const SearchScreen(),
//       ),
//       const BrowseScreen(), // الآن نضيف BrowseScreen بدون مشاكل
//       const ProfileScreen(),
//     ];
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: AppColors.black,
//       body: _screens[_currentIndex],
//       bottomNavigationBar: BottomNavigationBar(
//         currentIndex: _currentIndex,
//         onTap: (index) => setState(() => _currentIndex = index),
//         backgroundColor: AppColors.black,
//         selectedItemColor: AppColors.yellow,
//         unselectedItemColor: AppColors.gray,
//         type: BottomNavigationBarType.fixed,
//         items: const [
//           BottomNavigationBarItem(
//               icon: Icon(Icons.home_filled), label: "Home"),
//           BottomNavigationBarItem(
//               icon: Icon(Icons.search), label: "Search"),
//           BottomNavigationBarItem(
//               icon: Icon(Icons.explore), label: "Browse"),
//           BottomNavigationBarItem(
//               icon: Icon(Icons.person_outline), label: "Profile"),
//         ],
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:movie_app/core/resourses/app_colors.dart';

// Tabs
import '../../../feature/tabs/browse tab/prisntation/screen/brows screen.dart';
import '../../../feature/tabs/search tab/presintaion/cubit/search_tab_view_model.dart';
import '../../../feature/tabs/search tab/data/data scourcs/search_tab_data_source_impl.dart';
import '../../../feature/tabs/search tab/data/repository_impl/search_tab_repository_impl.dart';
import '../../../feature/tabs/search tab/domain/usecases/search_usecase.dart';
import '../../../feature/tabs/search tab/presintaion/screen/search_tab_screen..dart';

// Screens
import 'home_screen.dart';
import 'profile_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;

  late final SearchUsecase searchUsecase = SearchUsecase(
    repository: SearchTabRepositoryImpl(
      dataSource: SearchTabDataSourceImpl(client: http.Client()),
    ),
  );

  late final List<Widget> _screens = [
    const HomeScreen(),

    BlocProvider(
      create: (_) => SearchCubit(searchUsecase: searchUsecase),
      child: const SearchScreen(),
    ),

    const BrowseScreen(),
    const ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.black,
      body: _screens[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (i) => setState(() => _currentIndex = i),
        backgroundColor: AppColors.black,
        selectedItemColor: AppColors.yellow,
        unselectedItemColor: AppColors.gray,
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home_filled), label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: "Search"),
          BottomNavigationBarItem(icon: Icon(Icons.explore), label: "Browse"),
          BottomNavigationBarItem(icon: Icon(Icons.person_outline), label: "Profile"),
        ],
      ),
    );
  }
}
