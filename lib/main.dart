import 'package:flutter/material.dart';

import 'pages/login_page.dart';
import 'pages/dashboard_page.dart';
import 'pages/admin_dashboard_page.dart';
import 'pages/checker_dashboard_page.dart';
import 'pages/penjual_dashboard_page.dart';

// ===========================================================
// MAIN
// ===========================================================

void main() {
  runApp(const FoodFlowApp());
}

// ===========================================================
// APLIKASI FOODFLOW
// ===========================================================

class FoodFlowApp extends StatelessWidget {
  const FoodFlowApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FoodFlow',

      debugShowCheckedModeBanner: false,

      // =====================================================
      // TEMA APLIKASI
      // =====================================================

      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFFFF7518),
        ),
      ),

      // =====================================================
      // HALAMAN AWAL
      // =====================================================

      home: const LoginPage(),

      // =====================================================
      // ROUTE DASHBOARD
      // =====================================================

      routes: {
        '/owner': (context) => const DashboardPage(),

        '/admin': (context) => const AdminDashboardPage(),

        '/checker': (context) => const CheckerDashboardPage(),

        '/penjual': (context) => const PenjualDashboardPage(),
      },
    );
  }
}