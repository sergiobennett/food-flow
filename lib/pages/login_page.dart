import 'package:flutter/material.dart';
import 'register_page.dart';
import 'dashboard_page.dart';
import 'checker_dashboard_page.dart';
import 'admin_dashboard_page.dart';
import 'penjual_dashboard_page.dart';
import '../auth_data.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailController = TextEditingController();
  String selectedRole = 'Owner';
  final passwordController = TextEditingController();

  void login() {
    final email = emailController.text.trim();
    final password = passwordController.text;

    // Cek apakah akun sudah terdaftar
    if (!AuthData.sudahTerdaftar()) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Akun belum terdaftar"),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    // Cek email
    if (email != AuthData.email) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Akun belum terdaftar"),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    // Cek password
    if (password != AuthData.password) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Password salah"),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    // Kalau benar → masuk sesuai role
    if (selectedRole == 'Owner') {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const DashboardPage(),
        ),
      );
    } else if (selectedRole == 'Checker') {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const CheckerDashboardPage(),
        ),
      );
    } else if (selectedRole == 'Admin') {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const AdminDashboardPage(),
        ),
      );
    } else if (selectedRole == 'Penjual') {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const PenjualDashboardPage(),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          width: 350,
          padding: const EdgeInsets.all(30),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "FoodFlow",
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Colors.orange,
                ),
              ),

              const SizedBox(height: 30),

              TextField(
                controller: emailController,
                decoration: const InputDecoration(
                  labelText: "Email",
                  border: OutlineInputBorder(),
                ),
              ),

              const SizedBox(height: 15),

              TextField(
                controller: passwordController,
                obscureText: true,
                decoration: const InputDecoration(
                  labelText: "Password",
                  border: OutlineInputBorder(),
                ),
              ),

              const SizedBox(height: 20),

              DropdownButtonFormField<String>(
                value: selectedRole,
                decoration: const InputDecoration(
                  labelText: 'Role',
                  border: OutlineInputBorder(),
                ),
                items: const [
                  DropdownMenuItem(
                    value: 'Owner',
                    child: Text('Owner'),
                  ),
                  DropdownMenuItem(
                    value: 'Checker',
                    child: Text('Checker'),
                  ),
                  DropdownMenuItem(
                    value: 'Admin',
                    child: Text('Admin'),
                  ),
                  DropdownMenuItem(
                    value: 'Penjual',
                    child: Text('Penjual'),
                  ),
                ],
                onChanged: (value) {
                  setState(() {
                    selectedRole = value!;
                  });
                },
              ),

              ElevatedButton(
                onPressed: login,
                child: const Text("MASUK"),
              ),

              const SizedBox(height: 10),

              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const RegisterPage(),
                    ),
                  );
                },
                child: const Text(
                  "Belum punya akun? Daftar",
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}