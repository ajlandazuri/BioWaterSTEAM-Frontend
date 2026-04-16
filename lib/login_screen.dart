import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  void _login() {
    final email = emailController.text.trim();
    final password = passwordController.text.trim();

    
    if (email == "admin@example.com" && password == "123456") {
      Navigator.pushReplacementNamed(context, '/waterQuality');
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Credenciales inválidas")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: Column(
              children: [
                Image.asset(
                  'assets/logo.png', // asegúrate de agregar el logo aquí
                  height: 150,
                ),
                const SizedBox(height: 8),
                Text(
                  "BioWater",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.normal,
                    foreground: Paint()
                      ..shader = LinearGradient(
                        colors: [ Color.fromARGB(255, 92, 208, 240), Color.fromARGB(255, 110, 0, 245)],
                      ).createShader(const Rect.fromLTWH(180, 200, 140, 0)),
                  ),
                ),
                Text(
                  "Steam",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.normal,
                    color:  const Color(0xFF72FFAF),
                  ),
                ),
                const SizedBox(height: 32),
                const Text("Iniciar Sesión",
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),

                const SizedBox(height: 24),
                _inputField("Email", emailController),
                const SizedBox(height: 16),  

                _inputField("Password", passwordController, obscure: true),

                const SizedBox(height: 24),
                ElevatedButton(
                  onPressed: _login,
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(horizontal: 80, vertical: 16),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                    backgroundColor: const Color.fromARGB(255, 92, 208, 240),
                    foregroundColor: Colors.white,
                    
                  ),
                  child: const Text("Iniciar sesión"),
                ),

                const SizedBox(height: 16),
                TextButton(
                  onPressed: () {
                    // Aquí puedes agregar navegación al registro
                  },
                  child: const Text(
                    "¿No tienes cuenta? Regístrate",
                    style: TextStyle(decoration: TextDecoration.underline),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _inputField(String label, TextEditingController controller, {bool obscure = false}) {
    return TextField(
      controller: controller,
      obscureText: obscure,
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
        filled: true,
        fillColor: const Color.fromARGB(0, 141, 141, 141),
      ),
    );
  }
}