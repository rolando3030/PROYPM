import 'package:flutter/material.dart';

// ⬇️ importa la página de detalle
import '../movie_detail/movie_detail_page.dart';

// ⬇️ importa las pantallas de filtros
import '../Filtros/city_filter_screen.dart';
import '../Filtros/date_filter_screen.dart';
import '../Filtros/more_filter_screen.dart';

class MoviesPage extends StatefulWidget {
  const MoviesPage({super.key});

  @override
  State<MoviesPage> createState() => _MoviesPageState();
}

class _MoviesPageState extends State<MoviesPage>
    with SingleTickerProviderStateMixin {
  late final TabController _tab;

  // --------- DATA (usa tus imágenes de assets/images/) ----------
  final List<Movie> cartelera = const [
    Movie(
      'AVENGERS ENDGAME',
      'assets/images/Avengers.jpg',
      estreno: true,
      synopsis:
          'Los Vengadores restantes se unen para revertir el chasquido de Thanos y restaurar el universo.',
    ),
    Movie(
      'TRANSFORMERS',
      'assets/images/Transformers.jpg',
      estreno: true,
      synopsis:
          'La batalla por la Tierra continúa con nuevos aliados y amenazas inesperadas.',
    ),
    Movie(
      '¿Y DÓNDE ESTÁN LAS RUBIAS?',
      'assets/images/Rubias.jpg',
      synopsis:
          'Dos agentes se infiltran como millonarias para resolver un secuestro en una comedia de enredos.',
    ),
    Movie(
      'NORBIT',
      'assets/images/Norbit.jpg',
      synopsis:
          'Norbit intenta rehacer su vida y recuperar un viejo amor entre situaciones absurdas.',
    ),
  ];

  final List<Movie> proximos = const [
    Movie(
      'NOGAME',
      'assets/images/Nogame.jpg',
      estreno: true,
      synopsis: 'Próximo estreno misterioso con altas dosis de acción.',
    ),
    Movie(
      'F1',
      'assets/images/F1.jpg',
      synopsis: 'Velocidad, circuitos icónicos y rivalidades históricas.',
    ),
    Movie(
      'MISIÓN IMPOSIBLE 8',
      'assets/images/MI8.jpg',
      synopsis: 'Ethan Hunt regresa para su misión más peligrosa.',
    ),
    Movie(
      'LOS 4 FANTÁSTICOS',
      'assets/images/Fantasticos.jpg',
      synopsis: 'El equipo se enfrenta a una nueva amenaza cósmica.',
    ),
  ];

  // ⬇️ Estado de lo seleccionado en filtros (opcional, para mostrarlo)
  String? _cityLabel;
  String? _dateLabel;
  Map<String, dynamic>? _moreResult; // aquí podrías guardar géneros, etc.

  @override
  void initState() {
    super.initState();
    _tab = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tab.dispose();
    super.dispose();
  }

  Future<void> _openCityFilter() async {
    final result = await Navigator.push<String>(
      context,
      MaterialPageRoute(builder: (_) => const CityFilterScreen()),
    );
    if (!mounted) return;
    if (result != null) {
      setState(() => _cityLabel = result);
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Ciudad: $result')));
    }
  }

  Future<void> _openDateFilter() async {
    final result = await Navigator.push<String>(
      context,
      MaterialPageRoute(builder: (_) => const DateFilterScreen()),
    );
    if (!mounted) return;
    if (result != null) {
      setState(() => _dateLabel = result);
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Fecha: $result')));
    }
  }

  Future<void> _openMoreFilter() async {
    final result = await Navigator.push<Map<String, dynamic>>(
      context,
      MaterialPageRoute(builder: (_) => const MoreFilterScreen()),
    );
    if (!mounted) return;
    if (result != null) {
      setState(() => _moreResult = result);
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Opciones aplicadas')));
    }
  }

  @override
  Widget build(BuildContext context) {
    final divider = Container(height: 1, color: Colors.black12);

    return Column(
      children: [
        // ------------------ Tabs ------------------
        Container(
          color: Colors.white,
          padding: const EdgeInsets.only(top: 8),
          child: TabBar(
            controller: _tab,
            labelColor: Colors.red.shade700,
            unselectedLabelColor: Colors.black87,
            indicatorColor: Colors.red.shade700,
            indicatorWeight: 3,
            tabs: const [
              Tab(text: 'En cartelera'),
              Tab(text: 'Próximos estrenos'),
            ],
          ),
        ),
        divider,

        // ------------------ Filtros ------------------
        _FiltersBar(
          cityLabel: _cityLabel,
          dateLabel: _dateLabel,
          onCityTap: _openCityFilter,
          onDateTap: _openDateFilter,
          onMoreTap: _openMoreFilter,
        ),
        divider,

        // ------------------ Grid de afiches ------------------
        Expanded(
          child: TabBarView(
            controller: _tab,
            children: [
              _MoviesGrid(movies: cartelera),
              _MoviesGrid(movies: proximos, forceLabel: 'PREVENTA'),
            ],
          ),
        ),
      ],
    );
  }
}

class _FiltersBar extends StatelessWidget {
  final VoidCallback onCityTap;
  final VoidCallback onDateTap;
  final VoidCallback onMoreTap;
  final String? cityLabel;
  final String? dateLabel;

  const _FiltersBar({
    required this.onCityTap,
    required this.onDateTap,
    required this.onMoreTap,
    this.cityLabel,
    this.dateLabel,
  });

  @override
  Widget build(BuildContext context) {
    Widget cell({
      required IconData icon,
      required String defaultText,
      String? valueText,
      required VoidCallback onTap,
    }) {
      return Expanded(
        child: InkWell(
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(icon, size: 22, color: Colors.black87),
                const SizedBox(height: 6),
                Text(
                  valueText ?? defaultText,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(fontSize: 12),
                ),
              ],
            ),
          ),
        ),
      );
    }

    return Row(
      children: [
        cell(
          icon: Icons.location_on_outlined,
          defaultText: 'Ciudad',
          valueText: cityLabel,
          onTap: onCityTap,
        ),
        Container(width: 1, height: 40, color: Colors.black12),
        cell(
          icon: Icons.event_note_outlined,
          defaultText: 'Fecha',
          valueText: dateLabel,
          onTap: onDateTap,
        ),
        Container(width: 1, height: 40, color: Colors.black12),
        cell(icon: Icons.tune, defaultText: 'Opciones', onTap: onMoreTap),
      ],
    );
  }
}

class _MoviesGrid extends StatelessWidget {
  final List<Movie> movies;
  final String? forceLabel; // si quieres forzar "PREVENTA" en Próximos

  const _MoviesGrid({required this.movies, this.forceLabel});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(12, 12, 12, 0),
      child: GridView.builder(
        itemCount: movies.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 2 / 3,
          crossAxisSpacing: 10,
          mainAxisSpacing: 12,
        ),
        itemBuilder: (_, i) {
          final m = movies[i];
          final label = forceLabel ?? (m.estreno ? 'ESTRENO' : null);

          return _PosterCard(
            movie: m,
            label: label,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => MovieDetailPage(
                    title: m.title,
                    imagePath: m.path,
                    isEstreno: m.estreno,
                    synopsis: m.synopsis,
                    idiomas: m.idiomas,
                    formatos: m.formatos,
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

class _PosterCard extends StatelessWidget {
  final Movie movie;
  final String? label;
  final VoidCallback? onTap;

  const _PosterCard({required this.movie, this.label, this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.asset(
              movie.path,
              fit: BoxFit.cover,
              width: double.infinity,
              height: double.infinity,
            ),
          ),
          if (label != null)
            Positioned(
              top: 8,
              left: 0,
              right: 0,
              child: Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.symmetric(vertical: 4),
                color: Colors.red.shade700,
                child: Text(
                  label!,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                    letterSpacing: .5,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}

// ----------------- Modelo público -----------------
class Movie {
  final String title;
  final String path;
  final bool estreno;
  final String synopsis;
  final List<String> idiomas;
  final List<String> formatos;

  const Movie(
    this.title,
    this.path, {
    this.estreno = false,
    this.synopsis = '',
    this.idiomas = const ['DOBLADA'],
    this.formatos = const ['2D', 'REGULAR'],
  });
}
