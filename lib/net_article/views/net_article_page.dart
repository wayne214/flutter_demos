import 'package:flutter/material.dart';

class NetArticlePage extends StatelessWidget {
  const NetArticlePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('网络文章'),
      ),
      body: const Center(
        child: Text('网络文章'),
      )
    );
  }
}
