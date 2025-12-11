//
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:http/http.dart' as http;
//
// import '../../data/data scourcs/search_tab_data_source_impl.dart';
// import '../../data/repository_impl/search_tab_repository_impl.dart';
// import '../../domain/usecases/search_usecase.dart';
// import '../cubit/search_tab_states.dart';
// import '../cubit/search_tab_view_model.dart';
// import '../widgets/movie_card.dart';
// import '../widgets/search_text_field.dart';
// import '../../data/models/movie_model.dart';
//
// class SearchScreen extends StatefulWidget {
//   const SearchScreen({super.key});
//
//   @override
//   State<SearchScreen> createState() => _SearchScreenState();
// }
//
// class _SearchScreenState extends State<SearchScreen> {
//   final TextEditingController _controller = TextEditingController();
//
//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     // ✅ أهم تعديل: نعمل return للـ BlocProvider
//     return BlocProvider(
//       create: (_) => SearchCubit(
//         searchUsecase: SearchUsecase(
//           repository: SearchTabRepositoryImpl(
//             dataSource: SearchTabDataSourceImpl(client: http.Client()),
//           ),
//         ),
//       ),
//       child: Scaffold(
//         backgroundColor: Colors.black,
//         body: SafeArea(
//           child: Padding(
//             padding: const EdgeInsets.all(16),
//             child: Column(
//               children: [
//                 SearchTextField(
//                   controller: _controller,
//                   onChanged: (q) {
//                     context.read<SearchCubit>().search(q);
//                   },
//                 ),
//                 const SizedBox(height: 25),
//                 Expanded(
//                   child: BlocBuilder<SearchCubit, SearchState>(
//                     builder: (context, state&cubit) {
//                       if (state&cubit is SearchInitial) {
//                         return Center(
//                           child: Column(
//                             mainAxisAlignment: MainAxisAlignment.center,
//                             children: [
//                               SizedBox(
//                                   width: 140,
//                                   height: 140,
//                                   child: Image.asset("assets/images/Empty.png")),
//                               const SizedBox(height: 20),
//                               const Text("Start typing to search movies",
//                                   style: TextStyle(color: Colors.white70)),
//                             ],
//                           ),
//                         );
//                       } else if (state&cubit is SearchLoading) {
//                         return const Center(
//                             child: CircularProgressIndicator(color: Colors.white));
//                       } else if (state&cubit is SearchEmpty) {
//                         return const Center(
//                             child: Text("No results found",
//                                 style: TextStyle(color: Colors.white)));
//                       } else if (state&cubit is SearchLoaded) {
//                         final movies = state&cubit.movies;
//                         return GridView.builder(
//                           gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//                             crossAxisCount: 2,
//                             childAspectRatio: 0.6,
//                             crossAxisSpacing: 10,
//                             mainAxisSpacing: 10,
//                           ),
//                           itemCount: movies.length,
//                           itemBuilder: (context, index) {
//                             final Movie movie = movies[index];
//                             return MovieCard(movie: movie);
//                           },
//                         );
//                       } else if (state&cubit is SearchError) {
//                         return Center(
//                             child: Text("Error: ${state&cubit.message}",
//                                 style: const TextStyle(color: Colors.white)));
//                       } else {
//                         // أي حالة غير متوقعة
//                         return const SizedBox.shrink();
//                       }
//                     },
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
//
//

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;

import '../../data/data scourcs/search_tab_data_source_impl.dart';
import '../../data/repository_impl/search_tab_repository_impl.dart';
import '../../domain/usecases/search_usecase.dart';
import '../cubit/search_tab_states.dart';
import '../cubit/search_tab_view_model.dart';
import '../widgets/movie_card.dart';
import '../widgets/search_text_field.dart';
import '../../data/models/movie_model.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _controller = TextEditingController();

  late final SearchCubit _cubit;

  @override
  void initState() {
    super.initState();
    // إنشاء Cubit مرة واحدة فقط
    _cubit = SearchCubit(
      searchUsecase: SearchUsecase(
        repository: SearchTabRepositoryImpl(
          dataSource: SearchTabDataSourceImpl(client: http.Client()),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    _cubit.close(); // اغلاق Cubit عند التخلص
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<SearchCubit>.value(
      value: _cubit,
      child: Scaffold(
        backgroundColor: Colors.black,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                SearchTextField(
                  controller: _controller,
                  onChanged: (q) {
                    if (q.trim().isEmpty) {
                      _cubit.emit(SearchInitial());
                    } else {
                      _cubit.search(q);
                    }
                  },
                ),
                const SizedBox(height: 25),
                Expanded(
                  child: BlocBuilder<SearchCubit, SearchState>(
                    builder: (context, state) {
                      if (state is SearchInitial && _controller.text.isEmpty) {
                        return Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(
                                width: 140,
                                height: 140,
                                child: Image.asset("assets/images/Empty.png"),
                              ),
                              const SizedBox(height: 20),
                              const Text(
                                "Start typing to search movies",
                                style: TextStyle(color: Colors.white70),
                              ),
                            ],
                          ),
                        );
                      } else if (state is SearchLoading) {
                        return const Center(
                          child: CircularProgressIndicator(color: Colors.white),
                        );
                      } else if (state is SearchEmpty) {
                        return const Center(
                          child: Text(
                            "No results found",
                            style: TextStyle(color: Colors.white),
                          ),
                        );
                      } else if (state is SearchLoaded) {
                        final movies = state.movies;
                        return GridView.builder(
                          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            childAspectRatio: 0.6,
                            crossAxisSpacing: 10,
                            mainAxisSpacing: 10,
                          ),
                          itemCount: movies.length,
                          itemBuilder: (context, index) {
                            final Movie movie = movies[index];
                            return MovieCard(movie: movie);
                          },
                        );
                      } else if (state is SearchError) {
                        return Center(
                          child: Text(
                            "Error: ${state.message}",
                            style: const TextStyle(color: Colors.white),
                          ),
                        );
                      } else {
                        return const SizedBox.shrink();
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
