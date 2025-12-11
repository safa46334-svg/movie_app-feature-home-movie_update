//
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:http/http.dart' as http;
//
// // App Screens
// import 'package:movie_app/core/routers.dart';
// import 'package:movie_app/feature/authentication/register/login.dart';
// import 'package:movie_app/feature/forget_password/forget_password.dart';
// import 'package:movie_app/feature/on_boarding/on_boarding.dart';
// import 'package:movie_app/feature/splash/splash_screen.dart';
//
// import '../../data/repositories/screens/home_screen.dart';
// import '../../data/repositories/screens/profile_screen.dart';
//
// // Search Feature Imports
// import '../../feature/authentication/login/register.dart';
// import '../../feature/tabs/browse tab/prisntation/screen/brows screen.dart';
// import '../../feature/tabs/search tab/data/data scourcs/search_tab_data_source_impl.dart';
// import '../../feature/tabs/search tab/data/repository_impl/search_tab_repository_impl.dart';
// import '../../feature/tabs/search tab/domain/usecases/search_usecase.dart';
// import '../../feature/tabs/search tab/presintaion/cubit/search_tab_view_model.dart';
// import '../../feature/tabs/search tab/presintaion/screen/search_tab_screen..dart';
//
// class RoutesManager {
//   static Route? router(RouteSettings settings) {
//     switch (settings.name) {
//       case AppRoutes.splashScreen:
//         return MaterialPageRoute(builder: (_) => const SplashScreen());
//
//       case AppRoutes.onBoarding:
//         return MaterialPageRoute(builder: (_) => OnboardingScreen());
//
//       case AppRoutes.register:
//         return MaterialPageRoute(builder: (_) => const Register());
//
//       case AppRoutes.login:
//         return MaterialPageRoute(builder: (_) => const Login());
//
//       case AppRoutes.forgetPassword:
//         return MaterialPageRoute(builder: (_) => const ForgetPassword());
//
//       case AppRoutes.HomeScreen:
//         return MaterialPageRoute(builder: (_) => const HomeScreen());
//
//       case AppRoutes.BrowseScreen:
//         return MaterialPageRoute(builder: (_) => const BrowseScreen());
//
//       case AppRoutes.ProfileScreen:
//         return MaterialPageRoute(builder: (_) => const ProfileScreen());
//
//       case AppRoutes.SearchScreen:
//         return MaterialPageRoute(
//           builder: (_) => BlocProvider<SearchCubit>(
//             create: (_) => SearchCubit(
//               searchUsecase: SearchUsecase(
//                 repository: SearchTabRepositoryImpl(
//                   dataSource: SearchTabDataSourceImpl(
//                     client: http.Client(),
//                   ),
//                 ),
//               ),
//             ),
//             child: const SearchScreen(),
//           ),
//         );
//
//       default:
//         return null;
//     }
//   }
// }
//
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;

import 'package:movie_app/core/routers.dart';

// Auth / Intro
import 'package:movie_app/feature/splash/splash_screen.dart';
import 'package:movie_app/feature/on_boarding/on_boarding.dart';
import 'package:movie_app/feature/authentication/register/login.dart';
import 'package:movie_app/feature/authentication/login/register.dart';
import 'package:movie_app/feature/forget_password/forget_password.dart';

// Main Screens
import '../../data/repositories/screens/main_screen.dart';
import '../../data/repositories/screens/home_screen.dart';
import '../../data/repositories/screens/profile_screen.dart';
import '../../feature/tabs/browse tab/prisntation/screen/brows screen.dart';

// Search Feature
import '../../feature/tabs/search tab/data/data scourcs/search_tab_data_source_impl.dart';
import '../../feature/tabs/search tab/data/repository_impl/search_tab_repository_impl.dart';
import '../../feature/tabs/search tab/domain/usecases/search_usecase.dart';
import '../../feature/tabs/search tab/presintaion/cubit/search_tab_view_model.dart';
import '../../feature/tabs/search tab/presintaion/screen/search_tab_screen..dart';

class RoutesManager {
  static Route? router(RouteSettings settings) {
    switch (settings.name) {

      case AppRoutes.splashScreen:
        return MaterialPageRoute(builder: (_) => const SplashScreen());

      case AppRoutes.onBoarding:
        return MaterialPageRoute(builder: (_) => OnboardingScreen());

      case AppRoutes.register:
        return MaterialPageRoute(builder: (_) => const Register());

      case AppRoutes.login:
        return MaterialPageRoute(builder: (_) => const Login());

      case AppRoutes.forgetPassword:
        return MaterialPageRoute(builder: (_) => const ForgetPassword());

      case AppRoutes.HomeScreen:
        return MaterialPageRoute(builder: (_) => const MainScreen());

      case AppRoutes.BrowseScreen:
        return MaterialPageRoute(builder: (_) => const BrowseScreen());

      case AppRoutes.ProfileScreen:
        return MaterialPageRoute(builder: (_) => const ProfileScreen());

      case AppRoutes.SearchScreen:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (_) => SearchCubit(
              searchUsecase: SearchUsecase(
                repository: SearchTabRepositoryImpl(
                  dataSource: SearchTabDataSourceImpl(client: http.Client()),
                ),
              ),
            ),
            child: const SearchScreen(),
          ),
        );

      default:
        return null;
    }
  }
}


