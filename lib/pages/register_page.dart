import 'dart:math' as math;

import 'package:flutter/material.dart';
import '../api_service.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  static const Color orange = Color(0xFFFF7315);
  static const Color peachBackground = Color(0xFFFFF2E7);
  static const Color illustrationBackground = Color(0xFFFFF0DC);
  static const Color darkText = Color(0xFF344054);
  static const Color mutedText = Color(0xFF758198);
  static const Color fieldGrey = Color(0xFFD9D9D9);

  final TextEditingController namaController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController konfirmasiPasswordController =
      TextEditingController();

  bool _isObscurePass = true;
  bool _isObscureConfirm = true;
  bool _agreeTerms = false;

  Future<void> daftar() async {
    final String nama = namaController.text.trim();
    final String email = emailController.text.trim();
    final String password = passwordController.text;
    final String konfirmasiPassword = konfirmasiPasswordController.text;

    if (nama.isEmpty ||
        email.isEmpty ||
        password.isEmpty ||
        konfirmasiPassword.isEmpty) {
      _showMessage('Semua data harus diisi', isError: true);
      return;
    }

    if (password != konfirmasiPassword) {
      _showMessage('Konfirmasi password tidak sama', isError: true);
      return;
    }

    if (!_agreeTerms) {
      _showMessage(
        'Anda harus menyetujui Kebijakan Privasi dan Ketentuan Layanan',
        isError: true,
      );
      return;
    }

    if (password.length < 8) {
      _showMessage('Password minimal 8 karakter', isError: true);
      return;
    }

    try {
      final response = await ApiService.register(
        namaLengkap: nama,
        email: email,
        password: password,
      );

      if (!mounted) return;

      if (response['success'] == true) {
        _showMessage(
          'Registrasi berhasil! Silakan login',
          isError: false,
        );

        Navigator.pop(context);
      } else {
        _showMessage(
          response['message']?.toString() ?? 'Registrasi gagal.',
          isError: true,
        );
      }
    } catch (e) {
      if (!mounted) return;

      _showMessage(
        e.toString().replaceFirst('Exception: ', ''),
        isError: true,
      );
    }
  }

  void _showMessage(String message, {required bool isError}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: isError ? Colors.red : Colors.green,
      ),
    );
  }

  @override
  void dispose() {
    namaController.dispose();
    emailController.dispose();
    passwordController.dispose();
    konfirmasiPasswordController.dispose();
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
                    SizedBox(
                      height: 420,
                      child: _buildBrandPanel(compact: true),
                    ),
                    Container(
                      width: double.infinity,
                      color: Colors.white,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 18,
                        vertical: 24,
                      ),
                      child: Center(
                        child: ConstrainedBox(
                          constraints: const BoxConstraints(maxWidth: 350),
                          child: _buildRegisterCard(compact: true),
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
                        constraints: const BoxConstraints(maxWidth: 350),
                        child: _buildRegisterCard(compact: false),
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
        final double horizontalPadding = compact
            ? 28
            : math.min(100.0, math.max(58.0, constraints.maxWidth * 0.20));

        return Container(
          color: peachBackground,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.fromLTRB(
                  horizontalPadding,
                  compact ? 24 : 42,
                  compact ? 24 : 26,
                  0,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'FoodFlow',
                      style: TextStyle(
                        fontSize: compact ? 42 : 56,
                        height: 1.02,
                        fontWeight: FontWeight.w900,
                        color: orange,
                        letterSpacing: -1.6,
                      ),
                    ),
                    SizedBox(height: compact ? 10 : 17),
                    Text(
                      'Digital Food Distribution &\nConsignment System',
                      style: TextStyle(
                        fontSize: compact ? 18 : 23,
                        height: 1.42,
                        fontWeight: FontWeight.w500,
                        color: darkText,
                      ),
                    ),
                    SizedBox(height: compact ? 9 : 15),
                    Text(
                      'Distribusi makanan lebih mudah,\nlebih cepat, dan lebih terpercaya.',
                      style: TextStyle(
                        fontSize: compact ? 12.5 : 15,
                        height: 1.45,
                        color: mutedText,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 4),
              Expanded(
                child: LayoutBuilder(
                  builder: (context, illustrationConstraints) {
                    // Perbesar area ilustrasi agar proporsinya lebih dekat
                    // dengan referensi: sekitar 82% lebar panel kiri.
                    final double artworkWidth = compact
                        ? illustrationConstraints.maxWidth
                        : math.min(
                            720.0,
                            math.max(0.0, constraints.maxWidth * 0.82),
                          );
                    // Pusatkan kotak ilustrasi secara horizontal di panel kiri.
                    // Pada layout desktop, ini menggeser ilustrasi ke tengah
                    // tanpa mengubah ukuran gambar maupun panel form.
                    final double artworkLeftMargin = compact
                        ? 0
                        : math.max(
                            0.0,
                            (constraints.maxWidth - artworkWidth) / 2,
                          );

                    return Align(
                      alignment: Alignment.centerLeft,
                      child: Container(
                        width: artworkWidth,
                        margin: EdgeInsets.only(left: artworkLeftMargin),
                        color: illustrationBackground,
                        child: const CustomPaint(
                          painter: _RegisterFoodFlowIllustrationPainter(),
                          child: SizedBox.expand(),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildRegisterCard({required bool compact}) {
    return Container(
      width: double.infinity,
      constraints: BoxConstraints(minHeight: compact ? 0 : 580),
      padding: const EdgeInsets.fromLTRB(27, 25, 27, 42),
      decoration: BoxDecoration(
        color: const Color(0xFFFCFCFC),
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.16),
            blurRadius: 15,
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
            'Daftar akun FoodFlow',
            style: TextStyle(
              fontSize: 20,
              height: 1.2,
              fontWeight: FontWeight.w800,
              color: darkText,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'Buat akun untuk mulai menggunakan layanan\nkami.',
            style: TextStyle(
              fontSize: 12.5,
              height: 1.45,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 25),

          const _RegisterFieldLabel('Nama Lengkap'),
          const SizedBox(height: 6),
          _inputShadow(
            child: TextField(
              controller: namaController,
              textInputAction: TextInputAction.next,
              style: const TextStyle(fontSize: 12, color: darkText),
              decoration: _fieldDecoration(
                hint: 'Masukkan nama lengkap',
                icon: Icons.person_outline,
              ),
            ),
          ),
          const SizedBox(height: 12),

          const _RegisterFieldLabel('Email'),
          const SizedBox(height: 6),
          _inputShadow(
            child: TextField(
              controller: emailController,
              keyboardType: TextInputType.emailAddress,
              textInputAction: TextInputAction.next,
              style: const TextStyle(fontSize: 12, color: darkText),
              decoration: _fieldDecoration(
                hint: 'Masukkan email anda',
                icon: Icons.mail_outline,
              ),
            ),
          ),
          const SizedBox(height: 12),

          const _RegisterFieldLabel('Password'),
          const SizedBox(height: 6),
          _inputShadow(
            child: TextField(
              controller: passwordController,
              obscureText: _isObscurePass,
              textInputAction: TextInputAction.next,
              style: const TextStyle(fontSize: 12, color: darkText),
              decoration: _fieldDecoration(
                hint: 'Masukkan password anda',
                icon: Icons.lock_outline,
                suffix: IconButton(
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints.tightFor(
                    width: 32,
                    height: 31,
                  ),
                  visualDensity: VisualDensity.compact,
                  tooltip: _isObscurePass
                      ? 'Tampilkan password'
                      : 'Sembunyikan password',
                  onPressed: () =>
                      setState(() => _isObscurePass = !_isObscurePass),
                  icon: Icon(
                    _isObscurePass
                        ? Icons.visibility_off_outlined
                        : Icons.visibility_outlined,
                    color: Colors.black87,
                    size: 17,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 12),

          const _RegisterFieldLabel('Konfirmasi password'),
          const SizedBox(height: 6),
          _inputShadow(
            child: TextField(
              controller: konfirmasiPasswordController,
              obscureText: _isObscureConfirm,
              textInputAction: TextInputAction.done,
              onSubmitted: (_) => daftar(),
              style: const TextStyle(fontSize: 12, color: darkText),
              decoration: _fieldDecoration(
                hint: 'Konfirmasi password',
                icon: Icons.lock_outline,
                suffix: IconButton(
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints.tightFor(
                    width: 32,
                    height: 31,
                  ),
                  visualDensity: VisualDensity.compact,
                  tooltip: _isObscureConfirm
                      ? 'Tampilkan password'
                      : 'Sembunyikan password',
                  onPressed: () =>
                      setState(() => _isObscureConfirm = !_isObscureConfirm),
                  icon: Icon(
                    _isObscureConfirm
                        ? Icons.visibility_off_outlined
                        : Icons.visibility_outlined,
                    color: Colors.black87,
                    size: 17,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 14),

          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: 22,
                height: 23,
                child: Checkbox(
                  value: _agreeTerms,
                  activeColor: orange,
                  side: const BorderSide(color: Color(0xFFD0D5DD)),
                  materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  onChanged: (value) {
                    setState(() => _agreeTerms = value ?? false);
                  },
                ),
              ),
              const SizedBox(width: 8),
              const Expanded(
                child: Text.rich(
                  TextSpan(
                    text: 'Saya setuju dengan ',
                    style: TextStyle(
                      fontSize: 10,
                      height: 1.35,
                      color: Colors.black87,
                    ),
                    children: [
                      TextSpan(
                        text: 'Kebijakan Privasi',
                        style: TextStyle(color: orange),
                      ),
                      TextSpan(text: ' dan '),
                      TextSpan(
                        text: 'Ketentuan\nLayanan',
                        style: TextStyle(color: orange),
                      ),
                      TextSpan(text: '.'),
                    ],
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 17),

          SizedBox(
            width: double.infinity,
            height: 35,
            child: ElevatedButton(
              onPressed: daftar,
              style: ElevatedButton.styleFrom(
                backgroundColor: orange,
                foregroundColor: Colors.white,
                elevation: 2,
                shadowColor: Colors.black.withOpacity(0.18),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5),
                ),
              ),
              child: const Text(
                'DAFTAR',
                style: TextStyle(fontSize: 12.5, fontWeight: FontWeight.w800),
              ),
            ),
          ),
          const SizedBox(height: 35),

          const Center(
            child: Text.rich(
              TextSpan(
                text: 'Dengan melanjutkan, Anda menyetujui\n',
                style: TextStyle(
                  fontSize: 9.5,
                  height: 1.45,
                  color: mutedText,
                ),
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
      prefixIcon: Icon(icon, color: Colors.black87, size: 18),
      prefixIconConstraints: const BoxConstraints(
        minWidth: 36,
        minHeight: 31,
      ),
      suffixIcon: suffix,
      suffixIconConstraints: const BoxConstraints(
        minWidth: 30,
        minHeight: 31,
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 9, vertical: 6),
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
      height: 31,
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

class _RegisterFieldLabel extends StatelessWidget {
  const _RegisterFieldLabel(this.text);

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

class _RegisterFoodFlowIllustrationPainter extends CustomPainter {
  const _RegisterFoodFlowIllustrationPainter();

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
  bool shouldRepaint(covariant _RegisterFoodFlowIllustrationPainter oldDelegate) => false;
}