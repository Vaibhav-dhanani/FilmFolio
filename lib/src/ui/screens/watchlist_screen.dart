import 'package:flutter/material.dart';

class WatchlistScreen extends StatefulWidget {
  const WatchlistScreen({super.key});

  @override
  State<WatchlistScreen> createState() => _WatchlistScreenState();
}

class _WatchlistScreenState extends State<WatchlistScreen> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: const Text(
        "WatchList Page",
        style: TextStyle(fontSize: 25, color: Colors.amber),
      ),
    );
  }
}
