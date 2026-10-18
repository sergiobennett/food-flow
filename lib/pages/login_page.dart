import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../api_service.dart';
import 'register_page.dart';
import 'dashboard_page.dart';
import 'checker_dashboard_page.dart';
import 'admin_dashboard_page.dart';
import 'penjual_dashboard_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  static const Color orange = Color(0xFFFF7315);
  static const Color peachBackground = Color(0xFFFFF2E7);
  static const Color darkText = Color(0xFF344054);
  static const Color mutedText = Color(0xFF758198);
  static const Color fieldGrey = Color(0xFFD9D9D9);

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  String selectedRole = 'Owner';
  bool _isObscure = true;
  bool _rememberMe = false;

  bool _isLoading = false;

  Future<void> login() async {
    if (_isLoading) return;

    final String email = emailController.text.trim();
    final String password = passwordController.text;

    if (email.isEmpty || password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Email dan password wajib diisi.'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    setState(() => _isLoading = true);

    try {
      final result = await ApiService.login(
        email: email,
        password: password,
      );

      if (!mounted) return;

      if (result['success'] != true) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              result['message']?.toString() ?? 'Login gagal.',
            ),
            backgroundColor: Colors.red,
          ),
        );
        return;
      }

      // Navigasi dashboard mengikuti role yang dipilih.
      // Catatan: backend saat ini belum memvalidasi role dari database.
      if (selectedRole == 'Owner') {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => const DashboardPage()),
        );
      } else if (selectedRole == 'Checker') {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => const CheckerDashboardPage()),
        );
      } else if (selectedRole == 'Admin') {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => const AdminDashboardPage()),
        );
      } else if (selectedRole == 'Penjual') {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => const PenjualDashboardPage()),
        );
      }
    } catch (e) {
      if (!mounted) return;

      // Tampilkan pesan dari API jika login ditolak, atau pesan koneksi
      // jika backend tidak dapat dijangkau.
      final String errorMessage = e
          .toString()
          .replaceFirst('Exception: ', '')
          .trim();

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            errorMessage.isNotEmpty
                ? errorMessage
                : 'Login gagal. Periksa koneksi ke server FoodFlow.',
          ),
          backgroundColor: Colors.red,
        ),
      );
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: LayoutBuilder(
        builder: (context, constraints) {
          final bool compactLayout = constraints.maxWidth < 820;

          if (compactLayout) {
            return SafeArea(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    _buildBrandPanel(compact: true),
                    Container(
                      width: double.infinity,
                      color: Colors.white,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 26,
                      ),
                      child: Center(
                        child: ConstrainedBox(
                          constraints: const BoxConstraints(maxWidth: 350),
                          child: _buildLoginCard(),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          }

          return Row(
            children: [
              Expanded(
                flex: 54,
                child: _buildBrandPanel(compact: false),
              ),
              Expanded(
                flex: 46,
                child: Container(
                  color: Colors.white,
                  child: Center(
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 22,
                        vertical: 18,
                      ),
                      child: ConstrainedBox(
                        // Samakan ukuran dasar dengan kartu pada RegisterPage.
                        constraints: const BoxConstraints(
                          maxWidth: 350,
                          minHeight: 580,
                        ),
                        child: _buildLoginCard(),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildBrandPanel({required bool compact}) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (compact) {
          return Container(
            width: double.infinity,
            height: 355,
            color: peachBackground,
            padding: const EdgeInsets.fromLTRB(26, 25, 26, 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'FoodFlow',
                  style: TextStyle(
                    fontSize: 40,
                    height: 1.05,
                    fontWeight: FontWeight.w900,
                    color: orange,
                    letterSpacing: -1.2,
                  ),
                ),
                const SizedBox(height: 7),
                const Text(
                  'Digital Food Distribution &\nConsignment System',
                  style: TextStyle(
                    fontSize: 17,
                    height: 1.25,
                    fontWeight: FontWeight.w600,
                    color: darkText,
                  ),
                ),
                const SizedBox(height: 6),
                const Text(
                  'Distribusi makanan lebih mudah, lebih cepat, dan lebih terpercaya.',
                  style: TextStyle(
                    fontSize: 12,
                    height: 1.35,
                    color: mutedText,
                  ),
                ),
                const SizedBox(height: 4),
                const Expanded(
                  child: CustomPaint(
                    painter: _FoodFlowIllustrationPainter(),
                    child: SizedBox.expand(),
                  ),
                ),
              ],
            ),
          );
        }

        final double horizontalPadding =
            math.min(60.0, math.max(34.0, constraints.maxWidth * 0.11));

        return Container(
          color: peachBackground,
          padding: EdgeInsets.fromLTRB(
            horizontalPadding,
            34,
            horizontalPadding,
            22,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'FoodFlow',
                style: TextStyle(
                  fontSize: 56,
                  height: 1.02,
                  fontWeight: FontWeight.w900,
                  color: orange,
                  letterSpacing: -1.6,
                ),
              ),
              const SizedBox(height: 15),
              const Text(
                'Digital Food Distribution &\nConsignment System',
                style: TextStyle(
                  fontSize: 22,
                  height: 1.48,
                  fontWeight: FontWeight.w500,
                  color: darkText,
                ),
              ),
              const SizedBox(height: 17),
              const Text(
                'Distribusi makanan lebih mudah,\nlebih cepat, dan lebih terpercaya.',
                style: TextStyle(
                  fontSize: 15.5,
                  height: 1.45,
                  color: mutedText,
                ),
              ),
              const SizedBox(height: 12),
              const Expanded(
                child: CustomPaint(
                  painter: _FoodFlowIllustrationPainter(),
                  child: SizedBox.expand(),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildLoginCard() {
    return Container(
      width: double.infinity,
      constraints: const BoxConstraints(minHeight: 580),
      padding: const EdgeInsets.fromLTRB(27, 25, 27, 42),
      decoration: BoxDecoration(
        color: const Color(0xFFFCFCFC),
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.15),
            blurRadius: 14,
            spreadRadius: 1,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Masuk ke FoodFlow',
            style: TextStyle(
              fontSize: 20,
              height: 1.2,
              fontWeight: FontWeight.w800,
              color: darkText,
            ),
          ),
          const SizedBox(height: 13),
          const Text(
            'Kelola distribusi dan pesanan makanan\nanda dengan mudah.',
            style: TextStyle(
              fontSize: 12.5,
              height: 1.45,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 20),

          const _FieldLabel('Email'),
          const SizedBox(height: 6),
          _inputShadow(
            child: TextField(
              controller: emailController,
              keyboardType: TextInputType.emailAddress,
              textInputAction: TextInputAction.next,
              style: const TextStyle(fontSize: 12.5, color: darkText),
              decoration: _fieldDecoration(
                hint: 'Masukkan email anda',
                icon: Icons.mail_outline,
              ),
            ),
          ),
          const SizedBox(height: 12),

          const _FieldLabel('Password'),
          const SizedBox(height: 6),
          _inputShadow(
            child: TextField(
              controller: passwordController,
              obscureText: _isObscure,
              textInputAction: TextInputAction.done,
              onSubmitted: (_) => login(),
              style: const TextStyle(fontSize: 12.5, color: darkText),
              decoration: _fieldDecoration(
                hint: 'Masukkan password anda',
                icon: Icons.lock_outline,
                suffix: IconButton(
                  visualDensity: VisualDensity.compact,
                  tooltip: _isObscure ? 'Tampilkan password' : 'Sembunyikan password',
                  onPressed: () => setState(() => _isObscure = !_isObscure),
                  icon: Icon(
                    _isObscure ? Icons.visibility_off_outlined : Icons.visibility_outlined,
                    color: Colors.black87,
                    size: 18,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 12),

          const _FieldLabel('Role'),
          const SizedBox(height: 6),
          _inputShadow(
            child: DropdownButtonFormField<String>(
              value: selectedRole,
              isExpanded: true,
              icon: const Icon(Icons.keyboard_arrow_down, size: 20),
              style: const TextStyle(fontSize: 12.5, color: darkText),
              decoration: _fieldDecoration(
                hint: 'Pilih role anda',
                icon: Icons.person_outline,
              ),
              items: const ['Owner', 'Checker', 'Admin', 'Penjual']
                  .map(
                    (role) => DropdownMenuItem<String>(
                      value: role,
                      child: Text(role),
                    ),
                  )
                  .toList(),
              onChanged: (value) {
                if (value != null) setState(() => selectedRole = value);
              },
            ),
          ),
          const SizedBox(height: 10),

          Row(
            children: [
              SizedBox(
                width: 22,
                height: 24,
                child: Checkbox(
                  value: _rememberMe,
                  activeColor: orange,
                  side: const BorderSide(color: Color(0xFFD0D5DD)),
                  materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  onChanged: (value) {
                    setState(() => _rememberMe = value ?? false);
                  },
                ),
              ),
              const SizedBox(width: 7),
              const Expanded(
                child: Text(
                  'Ingat saya',
                  style: TextStyle(fontSize: 11.5, color: Colors.black87),
                ),
              ),
              TextButton(
                style: TextButton.styleFrom(
                  foregroundColor: orange,
                  padding: const EdgeInsets.symmetric(horizontal: 2, vertical: 5),
                  minimumSize: Size.zero,
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                ),
                onPressed: () {},
                child: const Text(
                  'Lupa password?',
                  style: TextStyle(fontSize: 11.5, color: orange),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),

          SizedBox(
            width: double.infinity,
            height: 36,
            child: ElevatedButton(
              onPressed: _isLoading ? null : login,
              style: ElevatedButton.styleFrom(
                backgroundColor: orange,
                foregroundColor: Colors.white,
                elevation: 2,
                shadowColor: Colors.black.withOpacity(0.18),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5),
                ),
              ),
              child: _isLoading
                  ? const SizedBox(
                      width: 17,
                      height: 17,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        valueColor: AlwaysStoppedAnimation<Color>(
                          Colors.white,
                        ),
                      ),
                    )
                  : const Text(
                      'MASUK',
                      style: TextStyle(
                        fontSize: 12.5,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
            ),
          ),
          const SizedBox(height: 13),

          Row(
            children: [
              const Expanded(child: Divider(color: Color(0xFFD0D5DD))),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: TextButton(
                  style: TextButton.styleFrom(
                    foregroundColor: mutedText,
                    padding: const EdgeInsets.symmetric(horizontal: 2, vertical: 3),
                    minimumSize: Size.zero,
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const RegisterPage()),
                    );
                  },
                  child: const Text(
                    'Belum punya akun?',
                    style: TextStyle(fontSize: 10.5, color: mutedText),
                  ),
                ),
              ),
              const Expanded(child: Divider(color: Color(0xFFD0D5DD))),
            ],
          ),
          const SizedBox(height: 11),

          const Center(
            child: Text.rich(
              TextSpan(
                text: 'Dengan melanjutkan, Anda menyetujui\n',
                style: TextStyle(fontSize: 9.5, height: 1.5, color: mutedText),
                children: [
                  TextSpan(
                    text: 'Kebijakan Privasi',
                    style: TextStyle(color: orange),
                  ),
                  TextSpan(text: ' dan '),
                  TextSpan(
                    text: 'Ketentuan Layanan',
                    style: TextStyle(color: orange),
                  ),
                  TextSpan(text: ' kami.'),
                ],
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }

  InputDecoration _fieldDecoration({
    required String hint,
    required IconData icon,
    Widget? suffix,
  }) {
    return InputDecoration(
      isDense: true,
      filled: true,
      fillColor: fieldGrey,
      hintText: hint,
      hintStyle: const TextStyle(fontSize: 12, color: Color(0xFF98A2B3)),
      prefixIcon: Icon(icon, color: Colors.black87, size: 19),
      prefixIconConstraints: const BoxConstraints(minWidth: 36, minHeight: 36),
      suffixIcon: suffix,
      suffixIconConstraints: const BoxConstraints(minWidth: 34, minHeight: 36),
      contentPadding: const EdgeInsets.symmetric(horizontal: 9, vertical: 8),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(5),
        borderSide: BorderSide.none,
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(5),
        borderSide: BorderSide.none,
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(5),
        borderSide: const BorderSide(color: orange, width: 1.2),
      ),
    );
  }

  Widget _inputShadow({required Widget child}) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.17),
            blurRadius: 3,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: child,
    );
  }
}

class _FieldLabel extends StatelessWidget {
  const _FieldLabel(this.text);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(
        fontSize: 11.5,
        height: 1.15,
        fontWeight: FontWeight.w700,
        color: Colors.black,
      ),
    );
  }
}

/// Ilustrasi vektor digambar langsung di Flutter, jadi tidak perlu asset atau
/// package gambar tambahan.
class _FoodFlowIllustrationPainter extends CustomPainter {
  const _FoodFlowIllustrationPainter();

  static const double designWidth = 500;
  static const double designHeight = 350;

  @override
  void paint(Canvas canvas, Size size) {
    if (size.isEmpty) return;

    final double scale = math.min(
      size.width / designWidth,
      size.height / designHeight,
    );
    final double dx = (size.width - designWidth * scale) / 2;
    final double dy = (size.height - designHeight * scale) / 2;

    canvas.save();
    canvas.translate(dx, dy);
    canvas.scale(scale);

    final Paint backgroundPaint = Paint()..color = const Color(0xFFFFF0DC);
    canvas.drawRect(
      const Rect.fromLTWH(0, 0, designWidth, designHeight),
      backgroundPaint,
    );

    _drawCloud(canvas, const Offset(325, 65), 1.0);
    _drawCloud(canvas, const Offset(365, 205), 0.65);
    _drawCloud(canvas, const Offset(280, 180), 0.45);

    // Lantai lembut agar benda-benda tampak berada pada satu bidang.
    canvas.drawOval(
      Rect.fromLTWH(25, 294, 450, 30),
      Paint()..color = const Color(0xFFFFE2BD),
    );

    _drawTruck(canvas);
    _drawCrateBackAndVegetables(canvas);
    _drawCrateFront(canvas);
    _drawFoodContainers(canvas);
    _drawFloatingLeaves(canvas);

    canvas.restore();
  }

  void _drawCloud(Canvas canvas, Offset center, double scale) {
    final Paint paint = Paint()..color = const Color(0xFFFFE0BE);
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(center.dx - 42 * scale, center.dy, 84 * scale, 24 * scale),
        Radius.circular(12 * scale),
      ),
      paint,
    );
    canvas.drawCircle(
      Offset(center.dx - 17 * scale, center.dy + 1 * scale),
      17 * scale,
      paint,
    );
    canvas.drawCircle(
      Offset(center.dx + 5 * scale, center.dy - 10 * scale),
      24 * scale,
      paint,
    );
    canvas.drawCircle(
      Offset(center.dx + 27 * scale, center.dy + 2 * scale),
      17 * scale,
      paint,
    );
  }

  void _drawTruck(Canvas canvas) {
    final Paint orangePaint = Paint()..color = const Color(0xFFFF7B18);
    final Paint darkOrangePaint = Paint()..color = const Color(0xFFEA5C0A);
    final Paint creamPaint = Paint()..color = const Color(0xFFFFF8EE);
    final Paint windowPaint = Paint()..color = const Color(0xFFB7C7D2);

    // Bagian kargo.
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        const Rect.fromLTWH(285, 213, 128, 76),
        const Radius.circular(5),
      ),
      orangePaint,
    );
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        const Rect.fromLTWH(294, 222, 108, 58),
        const Radius.circular(3),
      ),
      Paint()..color = const Color(0xFFFF851F),
    );

    // Kabin dan kaca depan.
    final Path cabin = Path()
      ..moveTo(413, 238)
      ..lineTo(438, 238)
      ..lineTo(456, 257)
      ..lineTo(456, 283)
      ..lineTo(412, 283)
      ..close();
    canvas.drawPath(cabin, darkOrangePaint);
    final Path window = Path()
      ..moveTo(420, 244)
      ..lineTo(436, 244)
      ..lineTo(448, 258)
      ..lineTo(420, 258)
      ..close();
    canvas.drawPath(window, windowPaint);

    // Bumper, chassis, lamp, and road line.
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        const Rect.fromLTWH(275, 281, 188, 8),
        const Radius.circular(4),
      ),
      darkOrangePaint,
    );
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        const Rect.fromLTWH(452, 267, 13, 11),
        const Radius.circular(2),
      ),
      creamPaint,
    );
    canvas.drawRect(
      const Rect.fromLTWH(464, 272, 8, 4),
      Paint()..color = const Color(0xFF90A4AE),
    );

    _drawWheel(canvas, const Offset(318, 290));
    _drawWheel(canvas, const Offset(420, 290));
    canvas.drawCircle(const Offset(318, 290), 8, Paint()..color = const Color(0xFFFFAF49));
    canvas.drawCircle(const Offset(420, 290), 8, Paint()..color = const Color(0xFFFFAF49));

    // Garis gerak di belakang truk.
    final Paint motionPaint = Paint()
      ..color = const Color(0xFFFF8A26)
      ..strokeWidth = 4
      ..strokeCap = StrokeCap.round;
    canvas.drawLine(const Offset(244, 233), const Offset(270, 233), motionPaint);
    canvas.drawLine(const Offset(250, 246), const Offset(272, 246), motionPaint);
    canvas.drawLine(const Offset(240, 259), const Offset(265, 259), motionPaint);
  }

  void _drawWheel(Canvas canvas, Offset center) {
    canvas.drawCircle(center, 16, Paint()..color = const Color(0xFF8B3A0A));
    canvas.drawCircle(center, 7, Paint()..color = const Color(0xFF3C2D25));
  }

  void _drawCrateBackAndVegetables(Canvas canvas) {
    // Batang sayur.
    final Paint stemPaint = Paint()
      ..color = const Color(0xFF679B2D)
      ..strokeWidth = 7
      ..strokeCap = StrokeCap.round;
    canvas.drawLine(const Offset(92, 210), const Offset(74, 151), stemPaint);
    canvas.drawLine(const Offset(109, 211), const Offset(112, 143), stemPaint);
    canvas.drawLine(const Offset(126, 212), const Offset(151, 163), stemPaint);
    canvas.drawLine(const Offset(78, 213), const Offset(47, 181), stemPaint);
    canvas.drawLine(const Offset(145, 213), const Offset(177, 181), stemPaint);

    _leaf(canvas, const Offset(78, 171), const Offset(57, 133), const Offset(38, 137), const Color(0xFF73AE34));
    _leaf(canvas, const Offset(85, 180), const Offset(50, 164), const Offset(58, 193), const Color(0xFF4F962B));
    _leaf(canvas, const Offset(100, 170), const Offset(89, 119), const Offset(116, 131), const Color(0xFF6BA52C));
    _leaf(canvas, const Offset(108, 174), const Offset(134, 127), const Offset(144, 154), const Color(0xFF8AB83A));
    _leaf(canvas, const Offset(126, 182), const Offset(147, 143), const Offset(166, 155), const Color(0xFF639E2F));
    _leaf(canvas, const Offset(64, 196), const Offset(30, 174), const Offset(42, 205), const Color(0xFF57952B));
    _leaf(canvas, const Offset(142, 200), const Offset(179, 168), const Offset(173, 199), const Color(0xFF6FA32F));

    // Daun-daun bulat di dalam kotak.
    final Paint leafPaint = Paint()..color = const Color(0xFF4F9329);
    canvas.drawCircle(const Offset(88, 194), 16, leafPaint);
    canvas.drawCircle(const Offset(106, 199), 18, Paint()..color = const Color(0xFF6FAF32));
    canvas.drawCircle(const Offset(127, 197), 14, Paint()..color = const Color(0xFF8CB938));
    canvas.drawCircle(const Offset(147, 202), 13, Paint()..color = const Color(0xFF4F982D));

    // Wortel di antara sayuran.
    final Path carrot = Path()
      ..moveTo(171, 184)
      ..quadraticBezierTo(193, 177, 205, 194)
      ..lineTo(185, 233)
      ..quadraticBezierTo(179, 242, 174, 230)
      ..lineTo(161, 202)
      ..close();
    canvas.drawPath(carrot, Paint()..color = const Color(0xFFFF8B1F));
    final Paint carrotLine = Paint()
      ..color = const Color(0xFFFFC36D)
      ..strokeWidth = 2.3
      ..strokeCap = StrokeCap.round;
    canvas.drawLine(const Offset(174, 198), const Offset(190, 203), carrotLine);
    canvas.drawLine(const Offset(178, 211), const Offset(188, 214), carrotLine);
    _leaf(canvas, const Offset(176, 184), const Offset(175, 166), const Offset(187, 171), const Color(0xFF4E982A));
    _leaf(canvas, const Offset(178, 184), const Offset(194, 164), const Offset(197, 177), const Color(0xFF669E2C));

    // Daun kecil kiri dan kanan.
    _leaf(canvas, const Offset(47, 211), const Offset(31, 196), const Offset(30, 214), const Color(0xFF4F962B));
    _leaf(canvas, const Offset(151, 215), const Offset(170, 197), const Offset(177, 213), const Color(0xFF80AD35));
  }

  void _drawCrateFront(Canvas canvas) {
    final Paint cratePaint = Paint()..color = const Color(0xFFF29435);
    final Paint crateSidePaint = Paint()..color = const Color(0xFFD97824);
    final Paint crateFrontPaint = Paint()..color = const Color(0xFFF6A24B);
    final Paint topPaint = Paint()..color = const Color(0xFFFFC078);

    final Path leftSide = Path()
      ..moveTo(40, 204)
      ..lineTo(75, 218)
      ..lineTo(79, 290)
      ..lineTo(24, 268)
      ..close();
    canvas.drawPath(leftSide, cratePaint);

    final Path front = Path()
      ..moveTo(75, 218)
      ..lineTo(217, 205)
      ..lineTo(230, 278)
      ..lineTo(81, 290)
      ..close();
    canvas.drawPath(front, crateFrontPaint);

    final Path rightSide = Path()
      ..moveTo(217, 205)
      ..lineTo(242, 256)
      ..lineTo(230, 278)
      ..close();
    canvas.drawPath(rightSide, crateSidePaint);

    // Bagian atas kotak.
    final Path rim = Path()
      ..moveTo(34, 191)
      ..lineTo(213, 187)
      ..lineTo(235, 205)
      ..lineTo(76, 221)
      ..close();
    canvas.drawPath(rim, topPaint);

    final Path innerTop = Path()
      ..moveTo(49, 194)
      ..lineTo(207, 192)
      ..lineTo(220, 203)
      ..lineTo(76, 214)
      ..close();
    canvas.drawPath(innerTop, Paint()..color = const Color(0xFFCF742A));

    // Lipatan karton.
    final Path fold = Path()
      ..moveTo(82, 220)
      ..lineTo(105, 251)
      ..lineTo(92, 270)
      ..lineTo(78, 224)
      ..close();
    canvas.drawPath(fold, Paint()..color = const Color(0xFFDB802B));

    final Path rightFold = Path()
      ..moveTo(218, 208)
      ..lineTo(196, 240)
      ..lineTo(208, 259)
      ..close();
    canvas.drawPath(rightFold, Paint()..color = const Color(0xFFE48A32));
  }

  void _drawFoodContainers(Canvas canvas) {
    final Paint shadow = Paint()..color = const Color(0xFFFFDEB1);
    canvas.drawOval(const Rect.fromLTWH(125, 318, 160, 17), shadow);

    // Wadah bawah.
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        const Rect.fromLTWH(151, 281, 119, 45),
        const Radius.circular(9),
      ),
      Paint()..color = const Color(0xFFFFFDF7),
    );
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        const Rect.fromLTWH(158, 292, 105, 28),
        const Radius.circular(5),
      ),
      Paint()..color = const Color(0xFFFFD69D),
    );
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        const Rect.fromLTWH(166, 297, 90, 16),
        const Radius.circular(4),
      ),
      Paint()..color = const Color(0xFFFFF7E9),
    );

    // Wadah atas dan tutupnya.
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        const Rect.fromLTWH(141, 268, 132, 30),
        const Radius.circular(8),
      ),
      Paint()..color = const Color(0xFFFFFCF6),
    );
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        const Rect.fromLTWH(151, 275, 112, 16),
        const Radius.circular(5),
      ),
      Paint()..color = const Color(0xFFFFD6A0),
    );
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        const Rect.fromLTWH(160, 278, 94, 9),
        const Radius.circular(4),
      ),
      Paint()..color = const Color(0xFFFFF7E9),
    );

    // Garis pada sisi wadah.
    canvas.drawLine(
      const Offset(163, 307),
      const Offset(258, 307),
      Paint()
        ..color = const Color(0xFFFFB965)
        ..strokeWidth = 3,
    );
  }

  void _drawFloatingLeaves(Canvas canvas) {
    _leaf(canvas, const Offset(40, 123), const Offset(24, 94), const Offset(51, 100), const Color(0xFFFF801A));
    _leaf(canvas, const Offset(53, 143), const Offset(47, 113), const Offset(65, 119), const Color(0xFFFF7A18));
    _leaf(canvas, const Offset(176, 73), const Offset(174, 42), const Offset(196, 50), const Color(0xFFFF801A));
    _leaf(canvas, const Offset(400, 213), const Offset(402, 181), const Offset(427, 187), const Color(0xFFFF8C24));
    _leaf(canvas, const Offset(407, 232), const Offset(430, 209), const Offset(432, 228), const Color(0xFFFF801A));
    _leaf(canvas, const Offset(386, 203), const Offset(373, 177), const Offset(394, 184), const Color(0xFFFFAD50));
    _leaf(canvas, const Offset(81, 307), const Offset(62, 286), const Offset(88, 286), const Color(0xFFFF9D36));
    _leaf(canvas, const Offset(90, 322), const Offset(113, 302), const Offset(111, 321), const Color(0xFFFF801A));
    _leaf(canvas, const Offset(54, 322), const Offset(27, 307), const Offset(49, 304), const Color(0xFFFFA13A));
  }

  void _leaf(Canvas canvas, Offset base, Offset tip, Offset control, Color color) {
    final Path path = Path()
      ..moveTo(base.dx, base.dy)
      ..quadraticBezierTo(control.dx, control.dy, tip.dx, tip.dy)
      ..quadraticBezierTo(control.dx + (base.dx - control.dx) * 0.45,
          control.dy + (base.dy - control.dy) * 0.45, base.dx, base.dy)
      ..close();
    canvas.drawPath(path, Paint()..color = color);

    final Offset mid = Offset((base.dx + tip.dx) / 2, (base.dy + tip.dy) / 2);
    canvas.drawLine(
      base,
      mid,
      Paint()
        ..color = color.withOpacity(0.58)
        ..strokeWidth = 1.2,
    );
  }

  @override
  bool shouldRepaint(covariant _FoodFlowIllustrationPainter oldDelegate) => false;
}
