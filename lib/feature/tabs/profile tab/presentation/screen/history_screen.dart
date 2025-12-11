import 'package:flutter/material.dart';

class HistoryScreen<T> extends StatelessWidget {
  final List<T> items;
  final String title;
  final String Function(T) getTitle;
  final String Function(T)? getSubtitle;
  final String Function(T)? getImage;

  const HistoryScreen({
    super.key,
    required this.items,
    required this.title,
    required this.getTitle,
    this.getSubtitle,
    this.getImage,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title), centerTitle: true),

      body: items.isEmpty
          ? Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset("assets/images/Empty.png", height: 180),
            const SizedBox(height: 15),
            const Text(
              "No Items Yet",
              style: TextStyle(fontSize: 18, color: Colors.grey),
            ),
          ],
        ),
      )
          : ListView.separated(
        padding: const EdgeInsets.all(16),
        itemCount: items.length,
        separatorBuilder: (_, __) => const Divider(),
        itemBuilder: (context, index) {
          final item = items[index];
          return ListTile(
            leading: getImage != null
                ? Image.network(
              getImage!(item),
              width: 50,
              height: 50,
              fit: BoxFit.cover,
            )
                : const Icon(Icons.movie),
            title: Text(getTitle(item)),
            subtitle: getSubtitle != null ? Text(getSubtitle!(item)) : null,
          );
        },
      ),
    );
  }
}
