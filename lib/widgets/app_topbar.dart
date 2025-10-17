import 'package:flutter/material.dart';

class AppTopBar extends StatelessWidget {
  final bool hasNotifications;
  const AppTopBar({super.key, this.hasNotifications = true});

  static const _purple = Color(0xFF5B4DB7);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 72,
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
      decoration: const BoxDecoration(color: _purple),
      child: Row(
        children: [
          // SOLO el logo (sin textos “Cine/Star”)
          Image.asset(
            'assets/images/cinestar.png',
            height: 32, // ajusta si quieres más grande/pequeño
            fit: BoxFit.contain,
            errorBuilder: (_, __, ___) =>
                const Icon(Icons.movie_outlined, color: Colors.white, size: 28),
          ),
          const Spacer(),
          const _RoundIcon(icon: Icons.person),
          const SizedBox(width: 10),
          _BellIcon(hasNotifications: hasNotifications),
          const SizedBox(width: 10),
          const _RoundIcon(icon: Icons.settings),
          const SizedBox(width: 10),
          const _RoundIcon(icon: Icons.search),
        ],
      ),
    );
  }
}

class _RoundIcon extends StatelessWidget {
  final IconData icon;
  const _RoundIcon({required this.icon});

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: 16,
      backgroundColor: Colors.white.withOpacity(.2),
      child: Icon(icon, size: 16, color: Colors.white),
    );
  }
}

class _BellIcon extends StatelessWidget {
  final bool hasNotifications;
  const _BellIcon({required this.hasNotifications});

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        const _RoundIcon(icon: Icons.notifications_outlined),
        if (hasNotifications)
          Positioned(
            right: -1,
            top: -1,
            child: Container(
              width: 8,
              height: 8,
              decoration: BoxDecoration(
                color: Color(0xFFFFB300),
                borderRadius: BorderRadius.circular(99),
                border: Border.all(color: Colors.white, width: 1),
              ),
            ),
          ),
      ],
    );
  }
}
