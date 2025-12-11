
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen>
    with SingleTickerProviderStateMixin {
  int selectedTab = 0; // 0 → Watchlist, 1 → History

  // بيانات وهمية
  final Map<String, dynamic> userData = {
    "name": "Safa Mohamed",
    "avatarUrl": "https://via.placeholder.com/150",
  };

  final List<Map<String, dynamic>> watchlist = [];
  final List<Map<String, dynamic>> history = [];

  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();

    _controller =
    AnimationController(vsync: this, duration: const Duration(seconds: 1))
      ..repeat(reverse: true);

    _scaleAnimation =
        Tween<double>(begin: 1.0, end: 1.2).animate(CurvedAnimation(
          parent: _controller,
          curve: Curves.easeInOut,
        ));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),

              /// Avatar + Watchlist & History
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Avatar + Name
                  Column(
                    children: [
                      CircleAvatar(
                        radius: 50,
                        backgroundImage: NetworkImage(userData['avatarUrl']),
                      ),
                      const SizedBox(height: 12),
                      Text(
                        userData['name'],
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(width: 24),

                  // Watchlist & History Numbers
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Column(
                            children: [
                              Text(
                                watchlist.length.toString(),
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 40,
                                ),
                              ),
                              const SizedBox(height: 3),
                              const Text(
                                "Watchlist",
                                style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.white70,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(width: 24),
                          Column(
                            children: [
                              Text(
                                history.length.toString(),
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 40,
                                ),
                              ),
                              const SizedBox(height: 4),
                              const Text(
                                "History",
                                style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.white70,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),

              const SizedBox(height: 20),

              /// Buttons
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  // Edit Profile
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const EditProfileScreen(),
                        ),
                      );
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 68, vertical: 14),
                      decoration: BoxDecoration(
                        color: Colors.yellow,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Text(
                        "Edit Profile",
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 28),

                  // Exit
                  GestureDetector(
                    onTap: () {
                      SystemNavigator.pop();
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 30, vertical: 12),
                      decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        children: const [
                          Text(
                            "Exit",
                            style: TextStyle(
                                fontSize: 20,
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                          ),
                          SizedBox(width: 4),
                          Icon(Icons.exit_to_app, color: Colors.black),
                        ],
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 20),

              /// Tabs Watchlist / History
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  GestureDetector(
                    onTap: () => setState(() => selectedTab = 0),
                    child: Column(
                      children: [
                        const Icon(Icons.menu, color: Colors.yellow, size: 30),
                        const SizedBox(height: 4),
                        Text(
                          "Watchlist",
                          style: TextStyle(
                              color: selectedTab == 0
                                  ? Colors.yellow
                                  : Colors.white70,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: () => setState(() => selectedTab = 1),
                    child: Column(
                      children: [
                        const Icon(Icons.folder, color: Colors.yellow, size: 30),
                        const SizedBox(height: 4),
                        Text(
                          "History",
                          style: TextStyle(
                              color: selectedTab == 1
                                  ? Colors.yellow
                                  : Colors.white70,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 16),

              // List of Movies with Animated Placeholder
              Expanded(
                child: selectedTab == 0
                    ? MovieGrid(
                  movies: watchlist,
                  emptyMessage: "No movies in Watchlist yet 😎",
                  scaleAnimation: _scaleAnimation,
                )
                    : MovieGrid(
                  movies: history,
                  emptyMessage: "No movies in History yet 😎",
                  scaleAnimation: _scaleAnimation,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class MovieGrid extends StatelessWidget {
  final List<Map<String, dynamic>> movies;
  final String emptyMessage;
  final Animation<double> scaleAnimation;

  const MovieGrid({
    super.key,
    required this.movies,
    required this.emptyMessage,
    required this.scaleAnimation,
  });

  @override
  Widget build(BuildContext context) {
    return movies.isEmpty
        ? Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ScaleTransition(
            scale: scaleAnimation,
            child: Icon(Icons.movie_outlined,
                color: Colors.white54, size: 80),
          ),
          const SizedBox(height: 16),
          Text(
            emptyMessage,
            style: const TextStyle(color: Colors.white54, fontSize: 18),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    )
        : GridView.builder(
      padding: const EdgeInsets.all(8),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.6,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
      itemCount: movies.length,
      itemBuilder: (context, index) {
        final movie = movies[index];
        return MovieCard(movie: movie);
      },
    );
  }
}

class MovieCard extends StatelessWidget {
  final Map movie;
  const MovieCard({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Card(
        color: Colors.grey[900],
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: movie['medium_cover_image'] != null
                  ? ClipRRect(
                borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(12)),
                child: Image.network(
                  movie['medium_cover_image'],
                  fit: BoxFit.cover,
                ),
              )
                  : Container(color: Colors.grey),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    movie['title'] ?? '',
                    style: const TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    movie['year']?.toString() ?? '',
                    style: const TextStyle(color: Colors.white70),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class EditProfileScreen extends StatelessWidget {
  const EditProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text("Edit Profile"),
        backgroundColor: Colors.yellow,
        foregroundColor: Colors.black,
      ),
      body: const Center(
        child: Text(
          "Edit Profile Page",
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}


////import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:http/http.dart' as http;
//
// class ProfileScreen extends StatefulWidget {
//   const ProfileScreen({super.key});
//
//   @override
//   State<ProfileScreen> createState() => _ProfileScreenState();
// }
//
// class _ProfileScreenState extends State<ProfileScreen>
//     with SingleTickerProviderStateMixin {
//   int selectedTab = 0; // 0 → Watchlist, 1 → History
//   bool isLoading = true;
//
//   Map<String, dynamic> userData = {};
//   List<Map<String, dynamic>> watchlist = [];
//   List<Map<String, dynamic>> history = [];
//
//   late AnimationController _controller;
//   late Animation<double> _scaleAnimation;
//
//   @override
//   void initState() {
//     super.initState();
//
//     _controller =
//     AnimationController(vsync: this, duration: const Duration(seconds: 1))
//       ..repeat(reverse: true);
//
//     _scaleAnimation =
//         Tween<double>(begin: 1.0, end: 1.2).animate(CurvedAnimation(
//           parent: _controller,
//           curve: Curves.easeInOut,
//         ));
//
//     fetchProfileData();
//   }
//
//   Future<void> fetchProfileData() async {
//     const String apiUrl = "https://your-api.com/profile"; // ضع رابط API
//
//     try {
//       final response = await http.get(Uri.parse(apiUrl));
//
//       if (response.statusCode == 200) {
//         final data = jsonDecode(response.body);
//
//         setState(() {
//           userData = {
//             "name": data['name'],
//             "avatarUrl": data['avatarUrl'],
//           };
//
//           watchlist = List<Map<String, dynamic>>.from(data['watchlist']);
//           history = List<Map<String, dynamic>>.from(data['history']);
//           isLoading = false;
//         });
//       } else {
//         setState(() {
//           isLoading = false;
//         });
//         // التعامل مع الخطأ
//         print("Error fetching profile: ${response.statusCode}");
//       }
//     } catch (e) {
//       setState(() {
//         isLoading = false;
//       });
//       print("Exception: $e");
//     }
//   }
//
//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     if (isLoading) {
//       return const Scaffold(
//         backgroundColor: Colors.black,
//         body: Center(
//           child: CircularProgressIndicator(color: Colors.yellow),
//         ),
//       );
//     }
//
//     return Scaffold(
//       backgroundColor: Colors.black,
//       body: SafeArea(
//         child: Padding(
//           padding: const EdgeInsets.all(16),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               const SizedBox(height: 20),
//
//               /// Avatar + Watchlist & History
//               Row(
//                 crossAxisAlignment: CrossAxisAlignment.center,
//                 children: [
//                   // Avatar + Name
//                   Column(
//                     children: [
//                       CircleAvatar(
//                         radius: 50,
//                         backgroundImage: NetworkImage(userData['avatarUrl']),
//                       ),
//                       const SizedBox(height: 12),
//                       Text(
//                         userData['name'],
//                         style: const TextStyle(
//                           color: Colors.white,
//                           fontSize: 22,
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                     ],
//                   ),
//
//                   const SizedBox(width: 24),
//
//                   // Watchlist & History Numbers
//                   Column(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Row(
//                         children: [
//                           Column(
//                             children: [
//                               Text(
//                                 watchlist.length.toString(),
//                                 style: const TextStyle(
//                                   color: Colors.white,
//                                   fontWeight: FontWeight.bold,
//                                   fontSize: 40,
//                                 ),
//                               ),
//                               const SizedBox(height: 3),
//                               const Text(
//                                 "Watchlist",
//                                 style: TextStyle(
//                                   fontSize: 20,
//                                   color: Colors.white70,
//                                   fontWeight: FontWeight.bold,
//                                 ),
//                               ),
//                             ],
//                           ),
//                           const SizedBox(width: 24),
//                           Column(
//                             children: [
//                               Text(
//                                 history.length.toString(),
//                                 style: const TextStyle(
//                                   color: Colors.white,
//                                   fontWeight: FontWeight.bold,
//                                   fontSize: 40,
//                                 ),
//                               ),
//                               const SizedBox(height: 4),
//                               const Text(
//                                 "History",
//                                 style: TextStyle(
//                                   fontSize: 20,
//                                   color: Colors.white70,
//                                   fontWeight: FontWeight.bold,
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ],
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//
//               const SizedBox(height: 20),
//
//               /// Buttons
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.start,
//                 children: [
//                   // Edit Profile
//                   GestureDetector(
//                     onTap: () {
//                       Navigator.push(
//                         context,
//                         MaterialPageRoute(
//                           builder: (_) => const EditProfileScreen(),
//                         ),
//                       );
//                     },
//                     child: Container(
//                       padding: const EdgeInsets.symmetric(
//                           horizontal: 68, vertical: 14),
//                       decoration: BoxDecoration(
//                         color: Colors.yellow,
//                         borderRadius: BorderRadius.circular(12),
//                       ),
//                       child: const Text(
//                         "Edit Profile",
//                         style: TextStyle(
//                           color: Colors.black,
//                           fontWeight: FontWeight.bold,
//                           fontSize: 20,
//                         ),
//                       ),
//                     ),
//                   ),
//                   const SizedBox(width: 28),
//
//                   // Exit
//                   GestureDetector(
//                     onTap: () {
//                       SystemNavigator.pop();
//                     },
//                     child: Container(
//                       padding: const EdgeInsets.symmetric(
//                           horizontal: 30, vertical: 12),
//                       decoration: BoxDecoration(
//                         color: Colors.red,
//                         borderRadius: BorderRadius.circular(12),
//                       ),
//                       child: Row(
//                         children: const [
//                           Text(
//                             "Exit",
//                             style: TextStyle(
//                                 fontSize: 20,
//                                 color: Colors.black,
//                                 fontWeight: FontWeight.bold),
//                           ),
//                           SizedBox(width: 4),
//                           Icon(Icons.exit_to_app, color: Colors.black),
//                         ],
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//
//               const SizedBox(height: 20),
//
//               /// Tabs Watchlist / History
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                 children: [
//                   GestureDetector(
//                     onTap: () => setState(() => selectedTab = 0),
//                     child: Column(
//                       children: [
//                         const Icon(Icons.menu, color: Colors.yellow, size: 30),
//                         const SizedBox(height: 4),
//                         Text(
//                           "Watchlist",
//                           style: TextStyle(
//                               color: selectedTab == 0
//                                   ? Colors.yellow
//                                   : Colors.white70,
//                               fontWeight: FontWeight.bold),
//                         ),
//                       ],
//                     ),
//                   ),
//                   GestureDetector(
//                     onTap: () => setState(() => selectedTab = 1),
//                     child: Column(
//                       children: [
//                         const Icon(Icons.folder, color: Colors.yellow, size: 30),
//                         const SizedBox(height: 4),
//                         Text(
//                           "History",
//                           style: TextStyle(
//                               color: selectedTab == 1
//                                   ? Colors.yellow
//                                   : Colors.white70,
//                               fontWeight: FontWeight.bold),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//
//               const SizedBox(height: 16),
//
//               // List of Movies with Animated Placeholder
//               Expanded(
//                 child: selectedTab == 0
//                     ? MovieGrid(
//                   movies: watchlist,
//                   emptyMessage: "No movies in Watchlist yet 😎",
//                   scaleAnimation: _scaleAnimation,
//                 )
//                     : MovieGrid(
//                   movies: history,
//                   emptyMessage: "No movies in History yet 😎",
//                   scaleAnimation: _scaleAnimation,
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
//
// // MovieGrid, MovieCard, EditProfileScreen كما في النسخة السابقة...
//=========================
//searchscreen
// //
// // import 'package:flutter/material.dart';
// // import 'dart:convert';
// // import 'package:http/http.dart' as http;
// //
// // class SearchScreen extends StatefulWidget {
// //   const SearchScreen({super.key});
// //
// //   @override
// //   State<SearchScreen> createState() => _SearchScreenState();
// // }
// //
// // class _SearchScreenState extends State<SearchScreen> {
// //   final TextEditingController _controller = TextEditingController();
// //   bool _isEmpty = true;
// //   List _searchResults = [];
// //   bool _isLoading = false;
// //
// //   @override
// //   void initState() {
// //     super.initState();
// //
// //     // مراقبة الكتابة داخل السيرش
// //     _controller.addListener(() {
// //       setState(() {
// //         _isEmpty = _controller.text.isEmpty;
// //       });
// //     });
// //   }
// //
// //   // Function لجلب الأفلام من API
// //   Future<List> fetchMovies({String? query}) async {
// //     String url = "https://yts.lt/api/v2/list_movies.json?limit=50";
// //     if (query != null && query.isNotEmpty) {
// //       url += "&query_term=$query";
// //     }
// //
// //     final response = await http.get(Uri.parse(url));
// //     if (response.statusCode == 200) {
// //       final data = json.decode(response.body);
// //       return data['data']['movies'] ?? [];
// //     } else {
// //       throw Exception('Failed to load movies');
// //     }
// //   }
// //
// //   // Function البحث عند الكتابة
// //   void _searchMovies(String query) async {
// //     if (query.isEmpty) {
// //       setState(() {
// //         _searchResults = [];
// //       });
// //       return;
// //     }
// //
// //     setState(() {
// //       _isLoading = true;
// //     });
// //
// //     try {
// //       final results = await fetchMovies(query: query);
// //       setState(() {
// //         _searchResults = results;
// //         _isLoading = false;
// //       });
// //     } catch (e) {
// //       print("Error fetching movies: $e");
// //       setState(() {
// //         _isLoading = false;
// //       });
// //     }
// //   }
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       backgroundColor: Colors.black,
// //       body: SafeArea(
// //         child: Padding(
// //           padding: const EdgeInsets.all(16),
// //           child: Column(
// //             children: [
// //
// //               /// 🔍 Search Field UI
// //               Container(
// //                 decoration: BoxDecoration(
// //                   color: Colors.grey[850],
// //                   borderRadius: BorderRadius.circular(14),
// //                 ),
// //                 child: TextField(
// //                   controller: _controller,
// //                   onChanged: (value) {
// //                     _searchMovies(value);
// //                   },
// //                   style: const TextStyle(color: Colors.white),
// //                   cursorColor: Colors.white,
// //                   decoration: InputDecoration(
// //                     prefixIcon: const Icon(Icons.search_sharp, color: Colors.white),
// //                     hintText: _isEmpty ? "Search" : "",
// //                     hintStyle: const TextStyle(
// //                       fontWeight: FontWeight.bold,
// //                       color: Colors.white,
// //                       fontSize: 16,
// //                     ),
// //                     border: InputBorder.none,
// //                     contentPadding: const EdgeInsets.symmetric(vertical: 14),
// //                   ),
// //                 ),
// //               ),
// //
// //               const SizedBox(height: 25),
// //
// //               /// ===== DISPLAY AREA =====
// //               Expanded(
// //                 child: _isEmpty
// //                     ? Center(
// //                   child: Column(
// //                     mainAxisAlignment: MainAxisAlignment.center,
// //                     children: [
// //                       SizedBox(
// //                         width: 140,
// //                         height: 140,
// //                         child: Image.asset("assets/images/Available Now.png"),
// //                       ),
// //                       const SizedBox(height: 20),
// //                       const Text(
// //                         "Start typing to search movies",
// //                         style: TextStyle(color: Colors.white70),
// //                       ),
// //                     ],
// //                   ),
// //                 )
// //                     : _isLoading
// //                     ? const Center(
// //                   child: CircularProgressIndicator(
// //                     color: Colors.white,
// //                   ),
// //                 )
// //                     : _searchResults.isEmpty
// //                     ? const Center(
// //                   child: Text(
// //                     "No results found",
// //                     style: TextStyle(color: Colors.white),
// //                   ),
// //                 )
// //                     : ListView.builder(
// //                   itemCount: _searchResults.length,
// //                   itemBuilder: (context, index) {
// //                     final movie = _searchResults[index];
// //                     return ListTile(
// //                       leading: movie['medium_cover_image'] != null
// //                           ? Image.network(movie['medium_cover_image'])
// //                           : null,
// //                       title: Text(
// //                         movie['title'] ?? '',
// //                         style: const TextStyle(color: Colors.white),
// //                       ),
// //                       subtitle: Text(
// //                         movie['year']?.toString() ?? '',
// //                         style: const TextStyle(color: Colors.white70),
// //                       ),
// //                       onTap: () {
// //                         // لاحقًا: افتح صفحة تفاصيل الفيلم
// //                       },
// //                     );
// //                   },
// //                 ),
// //               ),
// //             ],
// //           ),
// //         ),
// //       ),
// //     );
// //   }
// // }
// import 'package:flutter/material.dart';
// import 'dart:convert';
// import 'package:http/http.dart' as http;
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
//   bool _isEmpty = true;
//   List _searchResults = [];
//   bool _isLoading = false;
//
//   @override
//   void initState() {
//     super.initState();
//
//     // مراقبة الكتابة داخل السيرش
//     _controller.addListener(() {
//       setState(() {
//         _isEmpty = _controller.text.isEmpty;
//       });
//     });
//   }
//
//   // Function لجلب الأفلام من API
//   Future<List> fetchMovies({String? query}) async {
//     String url = "https://yts.lt/api/v2/list_movies.json?limit=50";
//     if (query != null && query.isNotEmpty) {
//       url += "&query_term=$query";
//     }
//
//     final response = await http.get(Uri.parse(url));
//     if (response.statusCode == 200) {
//       final data = json.decode(response.body);
//       return data['data']['movies'] ?? [];
//     } else {
//       throw Exception('Failed to load movies');
//     }
//   }
//
//   // Function البحث عند الكتابة
//   void _searchMovies(String query) async {
//     if (query.isEmpty) {
//       setState(() {
//         _searchResults = [];
//       });
//       return;
//     }
//
//     setState(() {
//       _isLoading = true;
//     });
//
//     try {
//       final results = await fetchMovies(query: query);
//       setState(() {
//         _searchResults = results;
//         _isLoading = false;
//       });
//     } catch (e) {
//       print("Error fetching movies: $e");
//       setState(() {
//         _isLoading = false;
//       });
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.black,
//       body: SafeArea(
//         child: Padding(
//           padding: const EdgeInsets.all(16),
//           child: Column(
//             children: [
//
//               /// 🔍 Search Field UI
//               Container(
//                 decoration: BoxDecoration(
//                   color: Colors.grey[850],
//                   borderRadius: BorderRadius.circular(14),
//                 ),
//                 child: TextField(
//                   controller: _controller,
//                   onChanged: (value) {
//                     _searchMovies(value);
//                   },
//                   style: const TextStyle(color: Colors.white),
//                   cursorColor: Colors.white,
//                   decoration: InputDecoration(
//                     prefixIcon: const Icon(Icons.search_sharp, color: Colors.white),
//                     hintText: _isEmpty ? "Search" : "",
//                     hintStyle: const TextStyle(
//                       fontWeight: FontWeight.bold,
//                       color: Colors.white,
//                       fontSize: 16,
//                     ),
//                     border: InputBorder.none,
//                     contentPadding: const EdgeInsets.symmetric(vertical: 14),
//                   ),
//                 ),
//               ),
//
//               const SizedBox(height: 25),
//
//               /// ===== DISPLAY AREA =====
//               Expanded(
//                 child: _isEmpty
//                     ? Center(
//                   child: Column(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       SizedBox(
//                         width: 140,
//                         height: 140,
//                         child: Image.asset("assets/images/Empty.png"),
//                       ),
//                       const SizedBox(height: 20),
//                       const Text(
//                         "Start typing to search movies",
//                         style: TextStyle(color: Colors.white70),
//                       ),
//                     ],
//                   ),
//                 )
//                     : _isLoading
//                     ? const Center(
//                   child: CircularProgressIndicator(
//                     color: Colors.white,
//                   ),
//                 )
//                     : _searchResults.isEmpty
//                     ? const Center(
//                   child: Text(
//                     "No results found",
//                     style: TextStyle(color: Colors.white),
//                   ),
//                 )
//                     : GridView.builder(
//                   gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//                     crossAxisCount: 2,        // عمودين
//                     childAspectRatio: 0.6,    // طول الكارت
//                     crossAxisSpacing: 10,
//                     mainAxisSpacing: 10,
//                   ),
//                   itemCount: _searchResults.length,
//                   itemBuilder: (context, index) {
//                     final movie = _searchResults[index];
//                     return MovieCard(movie: movie);
//                   },
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
//
// // ===== Widget للكارت بتاع الفيلم =====
// class MovieCard extends StatelessWidget {
//   final Map movie;
//   const MovieCard({super.key, required this.movie});
//
//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: () {
//         // لاحقًا: افتح صفحة تفاصيل الفيلم
//       },
//       child: Card(
//         color: Colors.grey[900],
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(12),
//         ),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.stretch,
//           children: [
//             Expanded(
//               child: movie['medium_cover_image'] != null
//                   ? ClipRRect(
//                 borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
//                 child: Image.network(
//                   movie['medium_cover_image'],
//                   fit: BoxFit.cover,
//                 ),
//               )
//                   : Container(color: Colors.grey),
//             ),
//             Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     movie['title'] ?? '',
//                     style: const TextStyle(
//                       color: Colors.white,
//                       fontWeight: FontWeight.bold,
//                     ),
//                     maxLines: 2,
//                     overflow: TextOverflow.ellipsis,
//                   ),
//                   const SizedBox(height: 4),
//                   Text(
//                     movie['year']?.toString() ?? '',
//                     style: const TextStyle(
//                       color: Colors.white70,
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
//=============================================

// import 'package:flutter/material.dart';
// import 'dart:convert';
// import 'package:http/http.dart' as http;
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
//   bool _isEmpty = true;
//   List _searchResults = [];
//   bool _isLoading = false;
//
//   @override
//   void initState() {
//     super.initState();
//
//     _controller.addListener(() {
//       setState(() {
//         _isEmpty = _controller.text.isEmpty;
//       });
//     });
//   }
//
//   // جلب الأفلام من API
//   Future<List> fetchMovies({String? query}) async {
//     String url = "https://yts.lt/api/v2/list_movies.json?limit=50";
//     if (query != null && query.isNotEmpty) {
//       url += "&query_term=$query";
//     }
//
//     final response = await http.get(Uri.parse(url));
//     if (response.statusCode == 200) {
//       final data = json.decode(response.body);
//       return data['data']['movies'] ?? [];
//     } else {
//       throw Exception('Failed to load movies');
//     }
//   }
//
//   // البحث عند الكتابة
//   void _searchMovies(String query) async {
//     if (query.isEmpty) {
//       setState(() {
//         _searchResults = [];
//       });
//       return;
//     }
//
//     setState(() {
//       _isLoading = true;
//     });
//
//     try {
//       final results = await fetchMovies(query: query);
//       setState(() {
//         _searchResults = results;
//         _isLoading = false;
//       });
//     } catch (e) {
//       print("Error fetching movies: $e");
//       setState(() {
//         _isLoading = false;
//       });
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.black,
//       body: SafeArea(
//         child: Padding(
//           padding: const EdgeInsets.all(16),
//           child: Column(
//             children: [
//               /// 🔍 Search Field
//               Container(
//                 decoration: BoxDecoration(
//                   color: Colors.grey[850],
//                   borderRadius: BorderRadius.circular(14),
//                 ),
//                 child: TextField(
//                   controller: _controller,
//                   onChanged: _searchMovies,
//                   style: const TextStyle(color: Colors.white),
//                   cursorColor: Colors.white,
//                   decoration: InputDecoration(
//                     prefixIcon: const Icon(Icons.search_sharp, color: Colors.white),
//                     hintText: _isEmpty ? "Search" : "",
//                     hintStyle: const TextStyle(
//                       fontWeight: FontWeight.bold,
//                       color: Colors.white,
//                       fontSize: 16,
//                     ),
//                     border: InputBorder.none,
//                     contentPadding: const EdgeInsets.symmetric(vertical: 14),
//                   ),
//                 ),
//               ),
//
//               const SizedBox(height: 25),
//
//               /// ===== Display Area =====
//               Expanded(
//                 child: _isEmpty
//                     ? Center(
//                   child: Column(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       SizedBox(
//                         width: 140,
//                         height: 140,
//                         child: Image.asset("assets/images/Empty.png"),
//                       ),
//                       const SizedBox(height: 20),
//                       const Text(
//                         "Start typing to search movies",
//                         style: TextStyle(color: Colors.white70),
//                       ),
//                     ],
//                   ),
//                 )
//                     : _isLoading
//                     ? const Center(
//                   child: CircularProgressIndicator(color: Colors.white),
//                 )
//                     : _searchResults.isEmpty
//                     ? const Center(
//                   child: Text(
//                     "No results found",
//                     style: TextStyle(color: Colors.white),
//                   ),
//                 )
//                     : GridView.builder(
//                   gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//                     crossAxisCount: 2,
//                     childAspectRatio: 0.6,
//                     crossAxisSpacing: 10,
//                     mainAxisSpacing: 10,
//                   ),
//                   itemCount: _searchResults.length,
//                   itemBuilder: (context, index) {
//                     final movie = _searchResults[index];
//                     return MovieCard(movie: movie);
//                   },
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
//
// // ===== Widget للكارت الفيلم =====
// class MovieCard extends StatelessWidget {
//   final Map movie;
//   const MovieCard({super.key, required this.movie});
//
//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: () {
//         // الانتقال لصفحة التفاصيل
//         Navigator.push(
//           context,
//           MaterialPageRoute(
//             builder: (_) => MovieDetailsScreen(movie: movie),
//           ),
//         );
//       },
//       child: Card(
//         color: Colors.grey[900],
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(12),
//         ),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.stretch,
//           children: [
//             Expanded(
//               child: movie['medium_cover_image'] != null
//                   ? ClipRRect(
//                 borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
//                 child: Image.network(
//                   movie['medium_cover_image'],
//                   fit: BoxFit.cover,
//                 ),
//               )
//                   : Container(color: Colors.grey),
//             ),
//             Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     movie['title'] ?? '',
//                     style: const TextStyle(
//                       color: Colors.white,
//                       fontWeight: FontWeight.bold,
//                     ),
//                     maxLines: 2,
//                     overflow: TextOverflow.ellipsis,
//                   ),
//                   const SizedBox(height: 4),
//                   Text(
//                     movie['year']?.toString() ?? '',
//                     style: const TextStyle(
//                       color: Colors.white70,
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
//
// // ===== صفحة تفاصيل الفيلم =====
// class MovieDetailsScreen extends StatelessWidget {
//   final Map movie;
//   const MovieDetailsScreen({super.key, required this.movie});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.black,
//       appBar: AppBar(
//         title: Text(movie['title'] ?? "Movie Details"),
//         backgroundColor: Colors.yellow,
//         foregroundColor: Colors.black,
//       ),
//       body: SingleChildScrollView(
//         child: Column(
//           children: [
//             // صورة كبيرة
//             movie['large_cover_image'] != null
//                 ? Image.network(movie['large_cover_image'])
//                 : movie['medium_cover_image'] != null
//                 ? Image.network(movie['medium_cover_image'])
//                 : Container(
//               height: 200,
//               color: Colors.grey,
//             ),
//
//             Padding(
//               padding: const EdgeInsets.all(16.0),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     movie['title'] ?? '',
//                     style: const TextStyle(
//                         color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),
//                   ),
//                   const SizedBox(height: 8),
//                   Text(
//                     "Year: ${movie['year'] ?? 'N/A'}",
//                     style: const TextStyle(color: Colors.white70, fontSize: 18),
//                   ),
//                   const SizedBox(height: 8),
//                   Text(
//                     "Rating: ${movie['rating'] ?? 'N/A'}",
//                     style: const TextStyle(color: Colors.white70, fontSize: 18),
//                   ),
//                   const SizedBox(height: 16),
//                   Text(
//                     movie['summary'] ?? "No description available.",
//                     style: const TextStyle(color: Colors.white70, fontSize: 16),
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// =============

///brows
/////
// // import 'package:flutter/material.dart';
// // import 'dart:convert';
// // import 'package:http/http.dart' as http;
// //
// // class BrowseScreen extends StatefulWidget {
// //   const BrowseScreen({super.key});
// //
// //   @override
// //   State<BrowseScreen> createState() => _BrowseScreenState();
// // }
// //
// // class _BrowseScreenState extends State<BrowseScreen> {
// //   final List<String> genres = [
// //     'Action',
// //     'Adventure',
// //     'Comedy',
// //     'Drama',
// //     'Horror',
// //     'Romance',
// //     'Sci-Fi',
// //     'Thriller',
// //     'Fantasy',
// //     'Animation',
// //     'Crime',
// //     'Mystery'
// //   ];
// //
// //   String selectedGenre = 'Action';
// //   List _movies = [];
// //   bool _isLoading = false;
// //
// //   @override
// //   void initState() {
// //     super.initState();
// //     _fetchMoviesByGenre(selectedGenre);
// //   }
// //
// //   // جلب الأفلام حسب Genre من YTS API
// //   Future<void> _fetchMoviesByGenre(String genre) async {
// //     setState(() {
// //       _isLoading = true;
// //       selectedGenre = genre;
// //     });
// //
// //     final url = "https://yts.lt/api/v2/list_movies.json?limit=50&genre=$genre";
// //     try {
// //       final response = await http.get(Uri.parse(url));
// //       if (response.statusCode == 200) {
// //         final data = json.decode(response.body);
// //         setState(() {
// //           _movies = data['data']['movies'] ?? [];
// //           _isLoading = false;
// //         });
// //       } else {
// //         setState(() {
// //           _movies = [];
// //           _isLoading = false;
// //         });
// //       }
// //     } catch (e) {
// //       print("Error fetching movies by genre: $e");
// //       setState(() {
// //         _movies = [];
// //         _isLoading = false;
// //       });
// //     }
// //   }
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       backgroundColor: Colors.black,
// //       body: SafeArea(
// //         child: Column(
// //           children: [
// //             const SizedBox(height: 20),
// //
// //             /// Horizontal Genre Tabs
// //             SizedBox(
// //               height: 50,
// //               child: ListView.builder(
// //                 scrollDirection: Axis.horizontal,
// //                 itemCount: genres.length,
// //                 itemBuilder: (context, index) {
// //                   final genre = genres[index];
// //                   final isSelected = genre == selectedGenre;
// //                   return GestureDetector(
// //                     onTap: () => _fetchMoviesByGenre(genre),
// //                     child: Container(
// //                       margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
// //                       padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
// //                       decoration: BoxDecoration(
// //                         color: isSelected ? Colors.yellow : Colors.black,
// //                         borderRadius: BorderRadius.circular(20),
// //                         border: Border.all(color: Colors.yellow),
// //                       ),
// //                       child: Text(
// //                         genre,
// //                         style: TextStyle(
// //                           color: isSelected ? Colors.black : Colors.yellow,
// //                           fontWeight: FontWeight.bold,
// //                         ),
// //                       ),
// //                     ),
// //                   );
// //                 },
// //               ),
// //             ),
// //
// //             const SizedBox(height: 10),
// //
// //             /// Movies Grid
// //             Expanded(
// //               child: _isLoading
// //                   ? const Center(child: CircularProgressIndicator(color: Colors.yellow))
// //                   : _movies.isEmpty
// //                   ? const Center(
// //                 child: Text(
// //                   "No movies found",
// //                   style: TextStyle(color: Colors.white),
// //                 ),
// //               )
// //                   : GridView.builder(
// //                 padding: const EdgeInsets.all(8),
// //                 gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
// //                   crossAxisCount: 2,
// //                   childAspectRatio: 0.6,
// //                   crossAxisSpacing: 10,
// //                   mainAxisSpacing: 10,
// //                 ),
// //                 itemCount: _movies.length,
// //                 itemBuilder: (context, index) {
// //                   final movie = _movies[index];
// //                   return MovieCard(movie: movie);
// //                 },
// //               ),
// //             ),
// //           ],
// //         ),
// //       ),
// //     );
// //   }
// // }
// //
// // // نفس Widget لكارت الفيلم من Search Tab
// // class MovieCard extends StatelessWidget {
// //   final Map movie;
// //   const MovieCard({super.key, required this.movie});
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     return GestureDetector(
// //       onTap: () {
// //         // لاحقًا: افتح صفحة تفاصيل الفيلم
// //       },
// //       child: Card(
// //         color: Colors.grey[900],
// //         shape: RoundedRectangleBorder(
// //           borderRadius: BorderRadius.circular(12),
// //         ),
// //         child: Column(
// //           crossAxisAlignment: CrossAxisAlignment.stretch,
// //           children: [
// //             Expanded(
// //               child: movie['medium_cover_image'] != null
// //                   ? ClipRRect(
// //                 borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
// //                 child: Image.network(
// //                   movie['medium_cover_image'],
// //                   fit: BoxFit.cover,
// //                 ),
// //               )
// //                   : Container(color: Colors.grey),
// //             ),
// //             Padding(
// //               padding: const EdgeInsets.all(8.0),
// //               child: Column(
// //                 crossAxisAlignment: CrossAxisAlignment.start,
// //                 children: [
// //                   Text(
// //                     movie['title'] ?? '',
// //                     style: const TextStyle(
// //                       color: Colors.white,
// //                       fontWeight: FontWeight.bold,
// //                     ),
// //                     maxLines: 2,
// //                     overflow: TextOverflow.ellipsis,
// //                   ),
// //                   const SizedBox(height: 4),
// //                   Text(
// //                     movie['year']?.toString() ?? '',
// //                     style: const TextStyle(
// //                       color: Colors.white70,
// //                     ),
// //                   ),
// //                 ],
// //               ),
// //             ),
// //           ],
// //         ),
// //       ),
// //     );
// //   }
// // }