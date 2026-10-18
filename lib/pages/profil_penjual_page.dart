import 'package:flutter/material.dart';

import 'login_page.dart';
import 'pengambilan_stok_page.dart';
import 'struk_transparansi_page.dart';
import 'penjual_dashboard_page.dart';
import 'penjual_sidebar.dart';

// =============================================================
// PROFIL PENJUAL
// =============================================================

class ProfilPenjualPage extends StatefulWidget {
  const ProfilPenjualPage({super.key});

  @override
  State<ProfilPenjualPage> createState() =>
      _ProfilPenjualPageState();
}

class _ProfilPenjualPageState extends State<ProfilPenjualPage> {
  // ===========================================================
  // DATA PROFIL
  // ===========================================================

  String nama = 'Ganendra Bimuy';
  String email = 'ganendrabimuyy@email.com';
  String role = 'Penjual';
  String outlet = 'Outlet Rungkut';
  String noHp = '086767676767';

  bool akunAktif = true;

  DateTime terakhirDiperbarui = DateTime(2026, 10, 15);

  // ===========================================================
  // WARNA
  // ===========================================================

  static const Color orange = Color(0xFFFF7518);
  static const Color peach = Color(0xFFFFF0E5);
  static const Color background = Color(0xFFF1F6FA);
  static const Color darkText = Color(0xFF26354A);
  static const Color greyText = Color(0xFF65758B);
  static const Color borderColor = Color(0xFFE5EAF0);
  static const Color green = Color(0xFF16A34A);

  // ===========================================================
  // BUILD
  // ===========================================================

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background,
      body: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // SIDEBAR
          _buildSidebar(),

          // KONTEN UTAMA
          Expanded(
            child: Column(
              children: [
                _buildTopBar(),

                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.fromLTRB(
                      24,
                      18,
                      24,
                      30,
                    ),
                    child: LayoutBuilder(
                      builder: (context, constraints) {
                        // LAYOUT RESPONSIF
                        if (constraints.maxWidth < 720) {
                          return Column(
                            crossAxisAlignment:
                                CrossAxisAlignment.stretch,
                            children: [
                              _buildProfileCard(),

                              const SizedBox(height: 20),

                              _buildAccountCard(),
                            ],
                          );
                        }

                        // LAYAR LEBAR: DUA KARTU SEJAJAR
                        return Row(
                          crossAxisAlignment:
                              CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              flex: 6,
                              child: _buildProfileCard(),
                            ),

                            const SizedBox(width: 24),

                            Expanded(
                              flex: 4,
                              child: _buildAccountCard(),
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ===========================================================
  // SIDEBAR
  // ===========================================================

  Widget _buildSidebar() {
    return PenjualSidebar(
      activeItem: 'Profil',
      onSelected: _handleSidebarTap,
    );
  }

  // ===========================================================
  // NAVIGASI SIDEBAR
  // ===========================================================

  void _handleSidebarTap(String item) {
    switch (item) {
      case 'Dashboard':
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (_) => const PenjualDashboardPage(),
          ),
        );
        break;

      case 'Pengambilan Stok':
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (_) => const PengambilanStokPage(),
          ),
        );
        break;

      case 'Struk Transparansi':
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (_) => StrukTransparansiPage(
              menu: const [
                {
                  'nama': 'Udang Keju',
                  'jumlah': '10',
                },
                {
                  'nama': 'Tahu Crispy',
                  'jumlah': '15',
                },
                {
                  'nama': 'Es Teh',
                  'jumlah': '20',
                },
              ],
              tanggal: DateTime.now(),
            ),
          ),
        );
        break;

      case 'Profil':
        // Sudah berada di halaman Profil.
        break;

      case 'Logout':
        _showLogoutDialog();
        break;
    }
  }

  // ===========================================================
  // TOP BAR
  // ===========================================================

  Widget _buildTopBar() {
    return Container(
      height: 82,
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 26),
      child: Row(
        children: [
          const Expanded(
            child: Text(
              'PROFIL PENJUAL',
              style: TextStyle(
                fontSize: 21,
                fontWeight: FontWeight.w900,
                color: darkText,
              ),
            ),
          ),
          const SizedBox(width: 12),
          // Badge role tetap ada, tetapi tidak interaktif.
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 8,
              vertical: 4,
            ),
            decoration: BoxDecoration(
              color: orange,
              borderRadius: BorderRadius.circular(6),
            ),
            child: const Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Penjual',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                SizedBox(width: 2),
                Icon(
                  Icons.arrow_drop_down,
                  size: 21,
                  color: Colors.black,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ===========================================================
  // KARTU PROFIL UTAMA
  // ===========================================================

  Widget _buildProfileCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(11),
        border: Border.all(
          color: borderColor,
          width: 0.8,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // FOTO, NAMA, EMAIL, DAN STATUS
          _buildProfileIntroduction(),

          const SizedBox(height: 24),

          const Divider(
            color: borderColor,
            thickness: 1,
          ),

          const SizedBox(height: 16),

          // INFORMASI PROFIL
          _profileDetailRow(
            'Role',
            role,
          ),

          _profileDetailRow(
            'Outlet',
            outlet,
          ),

          _profileDetailRow(
            'No. HP',
            noHp,
          ),

          const SizedBox(height: 12),

          const Divider(
            color: borderColor,
            thickness: 1,
          ),

          const SizedBox(height: 20),

          // TOMBOL AKSI
          LayoutBuilder(
            builder: (context, constraints) {
              if (constraints.maxWidth < 330) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    _buildEditButton(),

                    const SizedBox(height: 12),

                    _buildLogoutButton(),
                  ],
                );
              }

              return Row(
                children: [
                  Expanded(
                    child: _buildEditButton(),
                  ),

                  const SizedBox(width: 16),

                  Expanded(
                    flex: 1,
                    child: _buildLogoutButton(),
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }

  // ===========================================================
  // FOTO DAN IDENTITAS PENJUAL
  // ===========================================================

  Widget _buildProfileIntroduction() {
    return LayoutBuilder(
      builder: (context, constraints) {
        // TAMPILAN UNTUK KARTU YANG SEMPIT
        if (constraints.maxWidth < 390) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: _buildProfilePhoto(),
              ),

              const SizedBox(height: 18),

              _buildIdentityText(),
            ],
          );
        }

        // TAMPILAN DESKTOP
        return Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildProfilePhoto(),

            const SizedBox(width: 20),

            Expanded(
              child: _buildIdentityText(),
            ),
          ],
        );
      },
    );
  }

  // ===========================================================
  // FOTO PROFIL
  // ===========================================================

  Widget _buildProfilePhoto() {
    return Container(
      width: 116,
      height: 116,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: peach,
        border: Border.all(
          color: const Color(0xFFF1D4C3),
          width: 1,
        ),
      ),
      child: ClipOval(
        child: Image.asset(
          'assets/images/profil_penjual.png',
          width: 116,
          height: 116,
          fit: BoxFit.cover,

          // TETAP TAMPIL JIKA FOTO BELUM DITAMBAHKAN
          errorBuilder: (context, error, stackTrace) {
            return const ColoredBox(
              color: Color(0xFFFFE9DE),
              child: Center(
                child: Icon(
                  Icons.person,
                  size: 68,
                  color: orange,
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  // ===========================================================
  // NAMA, EMAIL, DAN STATUS AKUN
  // ===========================================================

  Widget _buildIdentityText() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 8),

        Text(
          nama,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(
            fontSize: 21,
            fontWeight: FontWeight.w900,
            color: darkText,
          ),
        ),

        const SizedBox(height: 7),

        Text(
          email,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(
            fontSize: 13,
            color: greyText,
          ),
        ),

        const SizedBox(height: 15),

        // BADGE STATUS AKUN
        Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 12,
            vertical: 7,
          ),
          decoration: BoxDecoration(
            color: akunAktif
                ? const Color(0xFFE2F8E8)
                : const Color(0xFFFEE2E2),
            borderRadius: BorderRadius.circular(6),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.circle,
                size: 8,
                color: akunAktif
                    ? green
                    : Colors.red,
              ),

              const SizedBox(width: 7),

              Text(
                akunAktif
                    ? 'Akun Aktif'
                    : 'Akun Tidak Aktif',
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.bold,
                  color: akunAktif
                      ? green
                      : Colors.red,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  // ===========================================================
  // DETAIL PROFIL
  // ===========================================================

  Widget _profileDetailRow(
    String label,
    String value,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 12,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // LABEL
          SizedBox(
            width: 110,
            child: Text(
              label,
              style: const TextStyle(
                fontSize: 13,
                color: greyText,
              ),
            ),
          ),

          // PEMISAH VERTIKAL
          Container(
            width: 1,
            height: 28,
            color: borderColor,
          ),

          const SizedBox(width: 24),

          // NILAI
          Expanded(
            child: Text(
              value,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w500,
                color: darkText,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ===========================================================
  // TOMBOL EDIT PROFIL
  // ===========================================================

  Widget _buildEditButton() {
    return SizedBox(
      height: 42,
      child: ElevatedButton.icon(
        onPressed: _showEditProfile,
        icon: const Icon(
          Icons.edit_outlined,
          size: 17,
        ),
        label: const Text(
          'Edit Profil',
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.bold,
          ),
        ),
        style: ElevatedButton.styleFrom(
          backgroundColor: orange,
          foregroundColor: Colors.white,
          elevation: 0,
          padding: const EdgeInsets.symmetric(
            horizontal: 10,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(6),
          ),
        ),
      ),
    );
  }

  // ===========================================================
  // TOMBOL LOGOUT
  // ===========================================================

  Widget _buildLogoutButton() {
    return SizedBox(
      height: 42,
      child: ElevatedButton.icon(
        onPressed: _showLogoutDialog,
        icon: const Icon(
          Icons.logout,
          size: 17,
        ),
        label: const Text(
          'Logout',
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.bold,
          ),
        ),
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.red,
          foregroundColor: Colors.white,
          elevation: 0,
          padding: const EdgeInsets.symmetric(
            horizontal: 10,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(6),
          ),
        ),
      ),
    );
  }

  // ===========================================================
  // KARTU INFORMASI AKUN
  // ===========================================================

  Widget _buildAccountCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(
        22,
        24,
        22,
        16,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(11),
        border: Border.all(
          color: borderColor,
          width: 0.8,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Informasi Akun',
            style: TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.w900,
              color: darkText,
            ),
          ),

          const SizedBox(height: 18),

          // STATUS AKUN
          _accountInfoRow(
            icon: Icons.shield_outlined,
            title: 'Status Akun',
            value: akunAktif
                ? 'Aktif'
                : 'Tidak Aktif',
            valueColor: akunAktif
                ? green
                : Colors.red,
          ),

          const Divider(
            color: borderColor,
            height: 1,
          ),

          // JENIS PENGGUNA
          _accountInfoRow(
            icon: Icons.person_outline,
            title: 'Jenis Pengguna',
            value: role,
          ),

          const Divider(
            color: borderColor,
            height: 1,
          ),

          // TERAKHIR DIPERBARUI
          _accountInfoRow(
            icon: Icons.calendar_today_outlined,
            title: 'Terakhir diperbarui',
            value: _formatTanggalSingkat(
              terakhirDiperbarui,
            ),
          ),
        ],
      ),
    );
  }

  // ===========================================================
  // BARIS INFORMASI AKUN
  // ===========================================================

  Widget _accountInfoRow({
    required IconData icon,
    required String title,
    required String value,
    Color valueColor = darkText,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 17,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // IKON
          SizedBox(
            width: 29,
            child: Icon(
              icon,
              size: 21,
              color: orange,
            ),
          ),

          const SizedBox(width: 9),

          // JUDUL INFORMASI
          Expanded(
            child: Text(
              title,
              style: const TextStyle(
                fontSize: 11,
                color: greyText,
              ),
            ),
          ),

          const SizedBox(width: 8),

          // NILAI INFORMASI
          Flexible(
            child: Text(
              value,
              textAlign: TextAlign.right,
              style: TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w500,
                color: valueColor,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ===========================================================
  // EDIT PROFIL
  // ===========================================================

  Future<void> _showEditProfile() async {
    final namaController = TextEditingController(
      text: nama,
    );

    final emailController = TextEditingController(
      text: email,
    );

    final outletController = TextEditingController(
      text: outlet,
    );

    final hpController = TextEditingController(
      text: noHp,
    );

    await showDialog<void>(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),

          title: const Text(
            'Edit Profil',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: darkText,
            ),
          ),

          content: SingleChildScrollView(
            child: SizedBox(
              width: 380,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  _editTextField(
                    controller: namaController,
                    label: 'Nama Lengkap',
                    icon: Icons.person_outline,
                  ),

                  const SizedBox(height: 14),

                  _editTextField(
                    controller: emailController,
                    label: 'Email',
                    icon: Icons.email_outlined,
                    keyboardType: TextInputType.emailAddress,
                  ),

                  const SizedBox(height: 14),

                  _editTextField(
                    controller: outletController,
                    label: 'Outlet',
                    icon: Icons.store_outlined,
                  ),

                  const SizedBox(height: 14),

                  _editTextField(
                    controller: hpController,
                    label: 'Nomor HP',
                    icon: Icons.phone_outlined,
                    keyboardType: TextInputType.phone,
                  ),
                ],
              ),
            ),
          ),

          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(dialogContext);
              },
              child: const Text(
                'Batal',
                style: TextStyle(
                  color: greyText,
                ),
              ),
            ),

            ElevatedButton(
              onPressed: () {
                // VALIDASI NAMA
                if (namaController.text.trim().isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text(
                        'Nama tidak boleh kosong.',
                      ),
                    ),
                  );

                  return;
                }

                setState(() {
                  nama = namaController.text.trim();
                  email = emailController.text.trim();
                  outlet = outletController.text.trim();
                  noHp = hpController.text.trim();

                  terakhirDiperbarui = DateTime.now();
                });

                Navigator.pop(dialogContext);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: orange,
                foregroundColor: Colors.white,
              ),
              child: const Text('Simpan'),
            ),
          ],
        );
      },
    );

    // MEMBERSIHKAN CONTROLLER
    namaController.dispose();
    emailController.dispose();
    outletController.dispose();
    hpController.dispose();
  }

  // ===========================================================
  // TEXT FIELD EDIT PROFIL
  // ===========================================================

  Widget _editTextField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return TextField(
      controller: controller,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(
          icon,
          color: orange,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(
            color: orange,
          ),
        ),
      ),
    );
  }

  // ===========================================================
  // FORMAT TANGGAL
  // ===========================================================

  String _formatTanggalSingkat(DateTime date) {
    const List<String> bulan = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'Mei',
      'Jun',
      'Jul',
      'Agu',
      'Sep',
      'Okt',
      'Nov',
      'Des',
    ];

    return '${date.day} '
        '${bulan[date.month - 1]} '
        '${date.year}';
  }

  // ===========================================================
  // LOGOUT DIALOG
  // ===========================================================

  void _showLogoutDialog() {
    showDialog<void>(
      context: context,
      barrierDismissible: true,
      builder: (dialogContext) {
        return Dialog(
          backgroundColor: Colors.white,
          elevation: 0,
          insetPadding: const EdgeInsets.symmetric(
            horizontal: 24,
            vertical: 24,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          child: SizedBox(
            width: 362,
            height: 222,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(30, 26, 30, 20),
              child: Column(
                children: [
                  const Icon(
                    Icons.logout,
                    size: 20,
                    color: Color(0xFF9A4E25),
                  ),
                  const SizedBox(height: 18),
                  const Text(
                    'Yakin ingin keluar',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 15,
                      height: 1.2,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF687184),
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    'Anda akan keluar dari akun FoodFlow saat ini.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 8.5,
                      height: 1.25,
                      color: Color(0xFF536078),
                    ),
                  ),
                  const Spacer(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: 120,
                        height: 35,
                        child: ElevatedButton(
                          onPressed: () => Navigator.pop(dialogContext),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFFD4D8DD),
                            foregroundColor: Colors.white,
                            elevation: 0,
                            padding: EdgeInsets.zero,
                            shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.zero,
                            ),
                          ),
                          child: const Text(
                            'Batal',
                            style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 120,
                        height: 35,
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.pop(dialogContext);
                            Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                builder: (_) => const LoginPage(),
                              ),
                              (route) => false,
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: orange,
                            foregroundColor: Colors.white,
                            elevation: 0,
                            padding: EdgeInsets.zero,
                            shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.zero,
                            ),
                          ),
                          child: const Text(
                            'Ya',
                            style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}