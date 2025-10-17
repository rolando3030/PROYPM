import 'package:flutter/material.dart';
import '../entradas/entradas_page.dart';

class AsientosPage extends StatefulWidget {
  const AsientosPage({
    super.key,
    this.movieTitle = 'TRANSFORMERS',
    this.cinemaLine =
        'CP ALCAZAR, Sala 7  |  2D, REGULAR DOBLADA\n21:40 | Hoy, Miércoles 8 de Octubre de 2025',
    this.pricePerSeat = 15.0,
  });

  final String movieTitle;
  final String cinemaLine;
  final double pricePerSeat;

  @override
  State<AsientosPage> createState() => _AsientosPageState();
}

class _AsientosPageState extends State<AsientosPage> {
  // 0 disponible, 1 ocupado, 2 seleccionado
  // Creamos una matriz simple 10 x 12 aprox, con algunos ocupados
  static const rows = 9;
  static const cols = 10;

  late List<List<int>> map;
  final List<Point> wheelChairs = const [
    Point(0, 1),
    Point(0, 2),
    Point(0, 7),
    Point(0, 8),
  ];

  @override
  void initState() {
    super.initState();
    map = List.generate(
      rows,
      (r) => List.generate(cols, (c) {
        // “ocupados” demo
        if ((r == 2 && c == 4) || (r == 3 && c == 4) || (r == 5 && c == 1))
          return 1;
        return 0;
      }),
    );
  }

  int get selectedCount {
    int s = 0;
    for (final row in map) {
      for (final v in row) {
        if (v == 2) s++;
      }
    }
    return s;
  }

  double get total => selectedCount * widget.pricePerSeat;

  bool _isWheel(Point p) => wheelChairs.any((w) => w.r == p.r && w.c == p.c);

  @override
  Widget build(BuildContext context) {
    const blue = Color(0xFF2B4A7B);
    const selected = Color(0xFFF2A013);
    const free = Color(0xFF2C4F92);
    const busy = Color(0xFF86919B);

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.close, color: blue),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Entradas',
          style: TextStyle(color: blue, fontWeight: FontWeight.w700),
        ),
        centerTitle: false,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 12),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
              decoration: BoxDecoration(
                color: blue,
                borderRadius: BorderRadius.circular(18),
              ),
              child: Row(
                children: [
                  const Icon(
                    Icons.shopping_cart_outlined,
                    color: Colors.white,
                    size: 18,
                  ),
                  const SizedBox(width: 6),
                  Text(
                    'S/ ${total.toStringAsFixed(2)}',
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Título + línea
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 6, 16, 8),
            child: Text(
              widget.movieTitle,
              style: const TextStyle(
                color: blue,
                fontSize: 20,
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              widget.cinemaLine,
              style: const TextStyle(
                fontSize: 11,
                color: Colors.black87,
                height: 1.2,
              ),
            ),
          ),
          const SizedBox(height: 6),

          // Iconitos superiores (decorativos)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: const [
                _TopMiniIcon(icon: Icons.event_seat, color: Color(0xFFDE4D4D)),
                _TopDivider(),
                _TopMiniIcon(
                  icon: Icons.confirmation_num_outlined,
                  color: Color(0xFF2B4A7B),
                ),
                _TopDivider(),
                _TopMiniIcon(
                  icon: Icons.local_mall_outlined,
                  color: Color(0xFFF2A013),
                ),
                _TopDivider(),
                _TopMiniIcon(
                  icon: Icons.point_of_sale_outlined,
                  color: Color(0xFF2B4A7B),
                ),
              ],
            ),
          ),

          const SizedBox(height: 10),

          // Cartel “Pantalla”
          Center(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 10),
              decoration: BoxDecoration(
                color: blue,
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Text(
                'Pantalla',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),

          const SizedBox(height: 12),

          // Mapa de asientos
          Expanded(
            child: Center(
              child: Column(
                children: [
                  for (int r = 0; r < rows; r++) ...[
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        for (int c = 0; c < cols; c++)
                          Padding(
                            padding: const EdgeInsets.all(6.0),
                            child: _Seat(
                              isWheel: _isWheel(Point(r, c)),
                              state: map[r][c],
                              onTap: () {
                                setState(() {
                                  if (map[r][c] == 0) {
                                    map[r][c] = 2;
                                  } else if (map[r][c] == 2) {
                                    map[r][c] = 0;
                                  }
                                  // Si está ocupado (1), no cambia.
                                });
                              },
                            ),
                          ),
                      ],
                    ),
                  ],
                ],
              ),
            ),
          ),

          // Leyenda
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 4, 16, 88),
            child: Row(
              children: const [
                _Legend(color: free, text: 'Disponible'),
                SizedBox(width: 12),
                _Legend(color: busy, text: 'Ocupado'),
                SizedBox(width: 12),
                _Legend(color: selected, text: 'Seleccionado'),
                SizedBox(width: 12),
                Icon(Icons.accessible, size: 16, color: blue),
                SizedBox(width: 4),
                Text('Silla de ruedas', style: TextStyle(fontSize: 12)),
              ],
            ),
          ),
        ],
      ),

      // Botón Continuar -> EntradasPage con baseAmount = total
      bottomNavigationBar: SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(12, 0, 12, 10),
          child: SizedBox(
            height: 52,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFC8102E),
                foregroundColor: Colors.white,
                shape: const RoundedRectangleBorder(),
                textStyle: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w800,
                ),
              ),
              onPressed: total <= 0
                  ? null
                  : () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => EntradasPage(
                            movieTitle: widget.movieTitle,
                            cinemaLine: widget.cinemaLine,
                            baseAmount: total, // <<<<< monto arrastrado
                          ),
                        ),
                      );
                    },
              child: const Text('Continuar'),
            ),
          ),
        ),
      ),
    );
  }
}

class _Seat extends StatelessWidget {
  const _Seat({required this.state, required this.onTap, this.isWheel = false});

  final int state; // 0 libre, 1 ocupado, 2 seleccionado
  final VoidCallback onTap;
  final bool isWheel;

  @override
  Widget build(BuildContext context) {
    const free = Color(0xFF2C4F92);
    const busy = Color(0xFF86919B);
    const selected = Color(0xFFF2A013);

    Color fill;
    if (state == 1) {
      fill = busy;
    } else if (state == 2) {
      fill = selected;
    } else {
      fill = free;
    }

    final seat = AnimatedContainer(
      duration: const Duration(milliseconds: 150),
      width: 18,
      height: 18,
      decoration: BoxDecoration(
        color: fill,
        borderRadius: BorderRadius.circular(4),
      ),
    );

    return isWheel
        ? Stack(
            alignment: Alignment.center,
            children: [
              seat,
              const Icon(Icons.accessible, size: 12, color: Colors.white),
            ],
          )
        : InkWell(onTap: state == 1 ? null : onTap, child: seat);
  }
}

class _Legend extends StatelessWidget {
  const _Legend({required this.color, required this.text});

  final Color color;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 10,
          height: 10,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(2),
          ),
        ),
        const SizedBox(width: 4),
        Text(text, style: const TextStyle(fontSize: 12)),
      ],
    );
  }
}

class _TopMiniIcon extends StatelessWidget {
  final IconData icon;
  final Color color;
  const _TopMiniIcon({required this.icon, required this.color});
  @override
  Widget build(BuildContext context) => CircleAvatar(
    radius: 16,
    backgroundColor: Colors.white,
    child: Icon(icon, size: 16, color: color),
  );
}

class _TopDivider extends StatelessWidget {
  const _TopDivider();
  @override
  Widget build(BuildContext context) => Expanded(
    child: Container(
      height: 2,
      margin: const EdgeInsets.symmetric(horizontal: 10),
      color: Color(0xFF2B4A7B),
    ),
  );
}

class Point {
  final int r, c;
  const Point(this.r, this.c);
}
