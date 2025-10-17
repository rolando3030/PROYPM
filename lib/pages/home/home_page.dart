import 'package:flutter/material.dart';

// widgets (están en lib/widgets)
import '../../widgets/app_topbar.dart';
import '../../widgets/bottom_nav.dart';
import '../../widgets/hero_slider.dart';

// movies page (está en lib/pages/movies/movies_page.dart)
import '../movies/movies_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int index = 0;

  // Tabs/Páginas del bottom-nav
  late final List<Widget> _tabs = const [
    _HomeTab(), // Inicio (HeroSlider)
    MoviesPage(), // Películas
    Center(child: Text('Cine')), // Placeholder
    Center(child: Text('Dulcería')), // Placeholder
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const AppTopBar(),
          // IndexedStack evita que se reconstruyan las tabs al cambiar
          Expanded(
            child: IndexedStack(index: index, children: _tabs),
          ),
        ],
      ),
      bottomNavigationBar: BottomNav(
        currentIndex: index,
        onTap: (i) => setState(() => index = i),
      ),
    );
  }
}

class _HomeTab extends StatelessWidget {
  const _HomeTab();

  @override
  Widget build(BuildContext context) {
    return const HeroSlider();
  }
}
