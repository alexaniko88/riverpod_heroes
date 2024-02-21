import 'package:flutter/material.dart';

class SomeFile extends StatelessWidget {
  const SomeFile({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
        appBar: AppBar(title: const Text("heloooo")),
        body: const Center(
          child: Text("hello"),
        ));
  }
}
