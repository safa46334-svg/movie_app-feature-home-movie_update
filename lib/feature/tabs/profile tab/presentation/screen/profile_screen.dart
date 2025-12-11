import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/models/history_model.dart';
import '../cubit/profile_cubit.dart';
import '../cubit/profile_state.dart';
import 'history_screen.dart'; // صفحة HistoryGeneric

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Profile"), centerTitle: true),

      body: BlocBuilder<ProfileCubit, ProfileState>(
        builder: (context, state) {

          /// LOADING
          if (state is ProfileLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          /// LOADED
          if (state is ProfileLoaded) {
            final bool isEmpty = state.watchlist.isEmpty && state.history.isEmpty;

            return Column(
              children: [
                const SizedBox(height: 20),

                /// Profile image
                const CircleAvatar(
                  radius: 50,
                  backgroundImage: AssetImage("assets/images/profile.png"),
                ),

                const SizedBox(height: 10),
                Text("Watchlist: ${state.watchlist.length}",
                    style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                Text("History: ${state.history.length}",
                    style: const TextStyle(fontSize: 17, color: Colors.black54)),

                const SizedBox(height: 20),

                Expanded(
                  child: isEmpty
                      ? _emptyView()
                      : ListView(
                    padding: const EdgeInsets.symmetric(horizontal: 18),
                    children: [

                      // ===== WATCHLIST ثابت داخل الصفحة =====
                      const Text("Watchlist",
                          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                      const SizedBox(height: 10),

                      ...state.watchlist.map(
                            (movie) => ListTile(
                          title: Text(movie.title),
                          leading: const Icon(Icons.bookmark),
                          trailing: const Icon(Icons.arrow_forward_ios, size: 14),
                        ),
                      ),

                      const SizedBox(height: 25),

                      // ===== HISTORY زر ينقلك لصفحة مستقلة =====
                      ListTile(
                        title: const Text("View History",
                            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                        trailing: const Icon(Icons.arrow_forward_ios),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => HistoryScreen<HistoryItem>(
                                items: state.history,
                                title: "Watch History",
                                getTitle: (item) => item.title,
                                getSubtitle: (item) =>
                                "Watched at: ${item.watchedAt.toLocal()}",
                                getImage: (item) => item.coverImage,
                              ),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                )
              ],
            );
          }

          return const Center(child: Text("No Data Found ❗"));
        },
      ),
    );
  }

  /// EMPTY STATE
  Widget _emptyView() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset("assets/images/Empty.png", height: 180),
          const SizedBox(height: 15),
          const Text("No Watchlist or History Yet",
              style: TextStyle(fontSize: 18, color: Colors.grey)),
        ],
      ),
    );
  }
}
