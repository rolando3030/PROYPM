import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'sign_in_controller.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({
    super.key,
  }); // puedes dejarlo const para usar const en routes

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final SignInController control = Get.put(SignInController());

  // Colores UI
  static const _purple = Color(0xFF4B4CC1);
  static const _headerGrey = Color(0xFFBFBFBF);
  static const _fieldBg = Color(0xFFF0ECEC);

  final _userCtrl = TextEditingController();
  final _passCtrl = TextEditingController();
  bool _rememberX = false;

  @override
  void dispose() {
    _userCtrl.dispose();
    _passCtrl.dispose();
    super.dispose();
  }

  void _goLogin() {
    // Aquí mantienes tu lógica luego; ahora solo navega.
    Navigator.pushNamed(context, '/home');
  }

  @override
  Widget build(BuildContext context) {
    final base = Theme.of(context);
    final size = MediaQuery.sizeOf(context);
    final topPad = MediaQuery.paddingOf(context).top;

    // Tamaños responsivos
    final logoH = (size.height * 0.15).clamp(120.0, 160.0);
    final titleSize = (size.width * 0.14).clamp(44.0, 56.0); // bien grande
    final gapLogoTitle = (size.height * 0.035).clamp(24.0, 36.0);
    final gapTitleBottom = (size.height * 0.10).clamp(84.0, 120.0);

    // Tema local para inputs tipo "píldora" y sin naranjas
    final localTheme = base.copyWith(
      colorScheme: base.colorScheme.copyWith(
        primary: _purple,
        onPrimary: Colors.white,
      ),
      textSelectionTheme: const TextSelectionThemeData(
        cursorColor: _purple,
        selectionColor: Color(0x334B4CC1),
        selectionHandleColor: _purple,
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: _fieldBg,
        contentPadding: const EdgeInsets.symmetric(
          vertical: 14,
          horizontal: 14,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(22),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(22),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(22),
          borderSide: BorderSide.none,
        ),
        hintStyle: const TextStyle(color: Colors.black45),
        labelStyle: const TextStyle(color: Colors.black54),
        floatingLabelStyle: const TextStyle(color: Colors.black54),
      ),
    );

    return Theme(
      data: localTheme,
      child: Scaffold(
        backgroundColor: _headerGrey,
        body: SafeArea(
          bottom: false,
          child: Stack(
            children: [
              // Fondo: arriba gris, abajo morado
              Column(
                children: [
                  Expanded(flex: 6, child: Container(color: _headerGrey)),
                  Expanded(flex: 4, child: Container(color: _purple)),
                ],
              ),

              // Header: logo + título (TanAegean, blanco, centrado y grande)
              SingleChildScrollView(
                child: ConstrainedBox(
                  constraints: BoxConstraints(minHeight: size.height - topPad),
                  child: Column(
                    children: [
                      const SizedBox(height: 22),
                      Center(
                        child: Image.asset(
                          'assets/images/cinestar.png',
                          height: logoH,
                          fit: BoxFit.contain,
                          errorBuilder: (_, __, ___) => const SizedBox.shrink(),
                        ),
                      ),
                      SizedBox(height: gapLogoTitle),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Center(
                          child: Text(
                            'PELÍCULAS PARA\nTODA LA FAMILIA',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontFamily:
                                  'TanAegean', // declarada en pubspec.yaml
                              fontSize: titleSize,
                              color: Colors.white,
                              height: 1.05,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: gapTitleBottom),
                    ],
                  ),
                ),
              ),

              // Tarjeta superpuesta con formulario
              Align(
                alignment: Alignment.bottomCenter,
                child: Transform.translate(
                  offset: const Offset(0, -28),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 18),
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(18),
                        boxShadow: const [
                          BoxShadow(
                            blurRadius: 22,
                            offset: Offset(0, 10),
                            color: Color(0x22000000),
                          ),
                        ],
                      ),
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(18, 18, 18, 16),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            TextField(
                              controller: _userCtrl,
                              autofillHints: const [AutofillHints.username],
                              textInputAction: TextInputAction.next,
                              decoration: const InputDecoration(
                                hintText: 'Usuario',
                                prefixIcon: Icon(Icons.person_outline),
                              ),
                            ),
                            const SizedBox(height: 12),
                            TextField(
                              controller: _passCtrl,
                              obscureText: true,
                              autofillHints: const [AutofillHints.password],
                              textInputAction: TextInputAction.done,
                              onSubmitted: (_) => _goLogin(),
                              decoration: const InputDecoration(
                                hintText: 'Contraseña',
                                prefixIcon: Icon(Icons.lock_outline),
                              ),
                            ),

                            const SizedBox(height: 10),

                            // Recuérdame (con X) + Olvidaste?
                            Row(
                              children: [
                                GestureDetector(
                                  onTap: () =>
                                      setState(() => _rememberX = !_rememberX),
                                  child: Row(
                                    children: [
                                      AnimatedContainer(
                                        duration: const Duration(
                                          milliseconds: 150,
                                        ),
                                        width: 18,
                                        height: 18,
                                        alignment: Alignment.center,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(
                                            4,
                                          ),
                                          border: Border.all(
                                            color: _rememberX
                                                ? _purple
                                                : Colors.black26,
                                            width: 1.4,
                                          ),
                                          color: _rememberX
                                              ? const Color(0x114B4CC1)
                                              : Colors.transparent,
                                        ),
                                        child: _rememberX
                                            ? const Icon(
                                                Icons.close,
                                                size: 14,
                                                color: _purple,
                                              )
                                            : const SizedBox.shrink(),
                                      ),
                                      const SizedBox(width: 8),
                                      const Text(
                                        'Recuérdame',
                                        style: TextStyle(fontSize: 12),
                                      ),
                                    ],
                                  ),
                                ),
                                const Spacer(),
                                GestureDetector(
                                  onTap: () => Navigator.pushNamed(
                                    context,
                                    '/reset-password',
                                  ),
                                  child: const Text(
                                    'olvidaste tu contraseña?',
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: _purple,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ],
                            ),

                            const SizedBox(height: 10),

                            SizedBox(
                              width: double.infinity,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: _purple,
                                  foregroundColor: Colors.white,
                                  shape: const StadiumBorder(),
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 14,
                                  ),
                                  textStyle: const TextStyle(
                                    fontWeight: FontWeight.w800,
                                    letterSpacing: .4,
                                  ),
                                ),
                                onPressed: _goLogin,
                                child: const Text('INGRESAR'),
                              ),
                            ),

                            const SizedBox(height: 8),

                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text(
                                  'No tienes cuenta?  ',
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.black54,
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () =>
                                      Navigator.pushNamed(context, '/sign-up'),
                                  child: const Text(
                                    'Crear Cuenta',
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: _purple,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),

              // Franja morada inferior
              const Positioned(
                left: 0,
                right: 0,
                bottom: 0,
                height: 28,
                child: ColoredBox(color: _purple),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
