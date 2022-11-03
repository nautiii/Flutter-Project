import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class HomePage extends StatefulWidget {
  final GoRouterState state;

  const HomePage({Key? key, required this.state}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GridView.count(
        crossAxisCount: 2,
        children: [
          for (int i = 0; i < 10; i++)
          Container(
            height: 100,
            width: 100,
            color: Colors.redAccent,
            margin: const EdgeInsets.all(8.0),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: Colors.red.shade700,
        child: const Icon(Icons.camera_alt),
      ),
    );
  }
}
