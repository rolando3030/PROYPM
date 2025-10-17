import 'package:flutter/material.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({super.key});

  // Colores del mockup
  static const Color _purple = Color(0xFF4B4CC1);
  static const Color _headerGrey = Color(0xFFBFBFBF);
  static const Color _fieldBg = Color(0xFFF0ECEC);

  @override
  Widget build(BuildContext context) {
    final base = Theme.of(context);
    final size = MediaQuery.sizeOf(context);
    final topPadding = MediaQuery.paddingOf(context).top;

    // Tema local: cursor morado, sin bordes naranjas, inputs “pill”
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
          borderRadius: BorderRadius.circular(24),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(24),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(24),
          borderSide: BorderSide.none,
        ),
        hintStyle: const TextStyle(color: Colors.black45),
      ),
    );

    return Theme(
      data: localTheme,
      child: Scaffold(
        backgroundColor: _headerGrey,
        body: SafeArea(
          child: SingleChildScrollView(
            child: Container(
              constraints: BoxConstraints(minHeight: size.height - topPadding),
              color: _headerGrey,
              padding: const EdgeInsets.fromLTRB(20, 16, 20, 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Botón atrás
                  InkWell(
                    onTap: () => Navigator.pop(context),
                    borderRadius: BorderRadius.circular(20),
                    child: Container(
                      width: 36,
                      height: 36,
                      decoration: const BoxDecoration(
                        color: _purple,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.arrow_back,
                        color: Colors.white,
                        size: 20,
                      ),
                    ),
                  ),
                  const SizedBox(height: 18),

                  // Logo
                  Center(
                    child: Image.asset(
                      'assets/images/cinestar.png',
                      height: 110,
                      fit: BoxFit.contain,
                      errorBuilder: (_, __, ___) => const SizedBox.shrink(),
                    ),
                  ),
                  const SizedBox(height: 14),

                  // Título
                  Center(
                    child: Text(
                      'CREAR\nNUEVA CUENTA',
                      textAlign: TextAlign.center,
                      style: base.textTheme.headlineSmall?.copyWith(
                        color: const Color(0xFF243328),
                        fontWeight: FontWeight.w600,
                        height: 1.05,
                        letterSpacing: 0.5,
                      ),
                    ),
                  ),

                  const SizedBox(height: 10),

                  // Link a iniciar sesión
                  Center(
                    child: Wrap(
                      crossAxisAlignment: WrapCrossAlignment.center,
                      children: [
                        Text(
                          '¿Ya estás registrado?  ',
                          style: base.textTheme.bodyMedium?.copyWith(
                            color: Colors.black54,
                          ),
                        ),
                        GestureDetector(
                          onTap: () => Navigator.pushReplacementNamed(
                            context,
                            '/sign-in',
                          ),
                          child: Text(
                            'Inicie sesión aquí',
                            style: base.textTheme.bodyMedium?.copyWith(
                              color: _purple,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 16),

                  // Campos
                  _pillInput(
                    hint: 'Nombre completo',
                    icon: Icons.person_outline,
                    keyboard: TextInputType.name,
                    autofill: const [AutofillHints.name],
                    action: TextInputAction.next,
                  ),
                  const SizedBox(height: 10),
                  _pillInput(
                    hint: 'Usuario',
                    icon: Icons.account_circle_outlined,
                    keyboard: TextInputType.text,
                    autofill: const [
                      AutofillHints.newUsername,
                      AutofillHints.username,
                    ],
                    action: TextInputAction.next,
                  ),
                  const SizedBox(height: 10),
                  _pillInput(
                    hint: 'Email',
                    icon: Icons.mail_outline,
                    keyboard: TextInputType.emailAddress,
                    autofill: const [AutofillHints.email],
                    action: TextInputAction.next,
                  ),
                  const SizedBox(height: 10),
                  _pillInput(
                    hint: 'Contraseña',
                    icon: Icons.lock_outline,
                    obscure: true,
                    keyboard: TextInputType.visiblePassword,
                    autofill: const [AutofillHints.newPassword],
                    action: TextInputAction.next,
                  ),
                  const SizedBox(height: 10),
                  _pillInput(
                    hint: 'Confirmar contraseña',
                    icon: Icons.lock_reset,
                    obscure: true,
                    keyboard: TextInputType.visiblePassword,
                    autofill: const [AutofillHints.password],
                    action: TextInputAction.done,
                  ),

                  const SizedBox(height: 12),

                  // Términos
                  Text(
                    'Al continuar, aceptas nuestros Términos y condiciones y\nPolítica de privacidad.',
                    textAlign: TextAlign.center,
                    style: base.textTheme.bodySmall?.copyWith(
                      color: Colors.black54,
                      height: 1.2,
                    ),
                  ),

                  const SizedBox(height: 18),

                  // Botón
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: _purple,
                        foregroundColor: Colors.white,
                        shape: const StadiumBorder(),
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        textStyle: const TextStyle(fontWeight: FontWeight.w700),
                        elevation: 0,
                      ),
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Inscribirse (solo UI)'),
                          ),
                        );
                      },
                      child: const Text('Inscribirse'),
                    ),
                  ),

                  const SizedBox(height: 8),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  // Input estilo píldora
  static Widget _pillInput({
    required String hint,
    required IconData icon,
    bool obscure = false,
    TextInputType? keyboard,
    List<String>? autofill,
    TextInputAction? action,
  }) {
    return TextField(
      obscureText: obscure,
      keyboardType: keyboard,
      textInputAction: action,
      autofillHints: autofill,
      cursorColor: _purple,
      decoration: InputDecoration(
        hintText: hint,
        prefixIcon: Icon(icon, color: Colors.black54),
      ),
    );
  }
}
