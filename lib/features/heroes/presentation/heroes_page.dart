import 'package:flutter/material.dart';
import 'package:riverpod_heroes/l10n/l10n.dart';

class HeroesPage extends StatelessWidget {
  const HeroesPage({super.key});

  @override
  Widget build(BuildContext context) {
    final loc = context.loc;
    return Scaffold(
      appBar: AppBar(title: Text(loc.heroesAppBarTitle)),
      body: const Center(child: Text('Here will appear a heroes list')),
    );
  }
}
