import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class FavoritePage extends StatefulWidget {
  final GoRouterState state;

  const FavoritePage({Key? key, required this.state}) : super(key: key);

  @override
  State<FavoritePage> createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage> {
  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('favorite'),
    );
  }
}
