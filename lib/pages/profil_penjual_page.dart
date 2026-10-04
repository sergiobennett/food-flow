import 'package:flutter/material.dart';
import 'login_page.dart';
import 'pengambilan_stok_page.dart';
import 'struk_transparansi_page.dart';
import 'penjual_dashboard_page.dart';

class ProfilPenjualPage extends StatefulWidget {
  const ProfilPenjualPage({super.key});

  @override
  State<ProfilPenjualPage> createState() =>
      _ProfilPenjualPageState();
}

class _ProfilPenjualPageState
    extends State<ProfilPenjualPage> {
  // =========================================================
  // DATA PROFIL
  // =========================================================

  String nama = 'Ganendru Bimuy';
  String email = 'Bimuy@email.com';
  String role = 'PENJUAL';
  String outlet = 'OUTLET RUNGKUT';
  String noHp = '086767676767';

  // =========================================================
  // WARNA
  // =========================================================

  static const Color orange = Color(0xFFFF7518);
  static const Color peach = Color(0xFFFFF0E5);
  static const Color background = Color(0xFFF1F6FA);
  static const Color darkText = Color(0xFF26354A);
  static const Color greyText = Color(0xFF65758B);

  // =========================================================
  // BUILD
  // =========================================================

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background,
      body: Row(
        children: [
          _buildSidebar(),

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
                    child: Column(
                      crossAxisAlignment:
                          CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'PROFIL PENJUAL',
                          style: TextStyle(
                            fontSize: 21,
                            fontWeight: FontWeight.bold,
                            color: darkText,
                          ),
                        ),

                        const SizedBox(height: 18),

                        _buildProfileSection(),
                      ],
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

  // =========================================================
  // SIDEBAR
  // =========================================================

  Widget _buildSidebar() {
    return Container(
      width: 170,
      color: Colors.white,
      child: SafeArea(
        child: Column(
          crossAxisAlignment:
              CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.fromLTRB(
                28,
                30,
                20,
                25,
              ),
              child: Text(
                'FOOD FLOW',
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                  color: orange,
                ),
              ),
            ),

            _sectionTitle('MAIN MENU'),
            _sidebarItem(
              'Dashboard',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        const PenjualDashboardPage(),
                  ),
                );
              },
            ),

            const SizedBox(height: 16),

            _sectionTitle('STOK'),

            _sidebarItem(
              'Pengambilan Stok',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        const PengambilanStokPage(),
                  ),
                );
              },
            ),

            _sidebarItem(
              'Stok',
              onTap: () {
                _showInfo('Stok');
              },
            ),

            const SizedBox(height: 16),

            _sectionTitle('TRANSAKSI'),

            _sidebarItem(
              'Struk Transparansi',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        StrukTransparansiPage(
                      menu: const [
                        {
                          'nama': 'Udang Keju',
                          'jumlah': '0',
                        },
                        {
                          'nama': 'Tahu Crispy',
                          'jumlah': '0',
                        },
                        {
                          'nama': 'Es Teh',
                          'jumlah': '0',
                        },
                      ],
                      tanggal: DateTime.now(),
                    ),
                  ),
                );
              },
            ),

            const SizedBox(height: 16),

            _sectionTitle('AKUN'),

            _sidebarItem(
              'Profil',
              selected: true,
              onTap: () {},
            ),

            _sidebarItem(
              'Logout',
              logout: true,
              onTap: () {
                _showLogoutDialog();
              },
            ),
          ],
        ),
      ),
    );
  }

  // =========================================================
  // TOP BAR
  // =========================================================

  Widget _buildTopBar() {
    return Container(
      height: 65,
      color: background,
      padding: const EdgeInsets.only(
        left: 28,
        right: 24,
      ),
      child: Row(
        mainAxisAlignment:
            MainAxisAlignment.end,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 15,
              vertical: 9,
            ),
            decoration: BoxDecoration(
              color: orange,
              borderRadius:
                  BorderRadius.circular(6),
            ),
            child: const Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Penjual',
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),

                SizedBox(width: 4),

                Icon(
                  Icons.arrow_drop_down,
                  size: 16,
                  color: Colors.white,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // =========================================================
  // PROFILE SECTION
  // =========================================================

  Widget _buildProfileSection() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(
        0,
        0,
        0,
        20,
      ),
      child: Column(
        crossAxisAlignment:
            CrossAxisAlignment.start,
        children: [
          // HEADER PROFIL SAYA
          Container(
            width: 156,
            height: 36,
            alignment: Alignment.center,
            color: const Color(0xFFD9D9D9),
            child: const Text(
              'PROFIL SAYA',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Colors.black,
              ),
            ),
          ),

          const SizedBox(height: 14),

          // FOTO PROFIL
          _buildProfilePhoto(),

          const SizedBox(height: 12),

          // NAMA
          Text(
            nama,
            style: const TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w500,
              color: Colors.black,
            ),
          ),

          const SizedBox(height: 3),

          // EMAIL
          Text(
            email,
            style: const TextStyle(
              fontSize: 11,
              color: Colors.black,
            ),
          ),

          const SizedBox(height: 20),

          // ROLE
          const Text(
            'Role',
            style: TextStyle(
              fontSize: 10,
              color: Colors.black,
            ),
          ),

          const SizedBox(height: 3),

          Text(
            role,
            style: const TextStyle(
              fontSize: 10,
              color: Colors.black,
            ),
          ),

          const SizedBox(height: 18),

          // OUTLET
          const Text(
            'Outlet',
            style: TextStyle(
              fontSize: 10,
              color: Colors.black,
            ),
          ),

          const SizedBox(height: 3),

          Text(
            outlet,
            style: const TextStyle(
              fontSize: 10,
              color: Colors.black,
            ),
          ),

          const SizedBox(height: 18),

          // NO HP
          const Text(
            'No. HP',
            style: TextStyle(
              fontSize: 10,
              color: Colors.black,
            ),
          ),

          const SizedBox(height: 3),

          Text(
            noHp,
            style: const TextStyle(
              fontSize: 10,
              color: Colors.black,
            ),
          ),

          const SizedBox(height: 28),

          // EDIT PROFIL
          SizedBox(
            width: 74,
            height: 25,
            child: ElevatedButton(
              onPressed: _showEditProfile,
              style: ElevatedButton.styleFrom(
                backgroundColor: orange,
                foregroundColor: Colors.black,
                elevation: 0,
                padding: EdgeInsets.zero,
                shape: RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.circular(5),
                ),
              ),
              child: const Text(
                'Edit Profil',
                style: TextStyle(
                  fontSize: 8,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),

          const SizedBox(height: 39),

          // GARIS
          Container(
            width: 163,
            height: 1,
            color: Colors.grey,
          ),

          const SizedBox(height: 17),

          // LOGOUT
          SizedBox(
            width: 74,
            height: 26,
            child: ElevatedButton(
              onPressed: _showLogoutDialog,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                foregroundColor: Colors.black,
                elevation: 0,
                padding: EdgeInsets.zero,
                shape: RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.circular(5),
                ),
              ),
              child: const Text(
                'Logout',
                style: TextStyle(
                  fontSize: 8,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // =========================================================
  // FOTO PROFIL
  // =========================================================

  Widget _buildProfilePhoto() {
    return Container(
      width: 124,
      height: 124,
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        color: Color(0xFF8B0000),
      ),
      child: const Center(
        child: Icon(
          Icons.person,
          size: 75,
          color: Colors.white,
        ),
      ),
    );
  }

  // =========================================================
  // EDIT PROFIL
  // =========================================================

  void _showEditProfile() {
    final namaController =
        TextEditingController(text: nama);

    final emailController =
        TextEditingController(text: email);

    final outletController =
        TextEditingController(text: outlet);

    final hpController =
        TextEditingController(text: noHp);

    showDialog(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title: const Text(
            'Edit Profil',
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),

          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: namaController,
                  decoration:
                      const InputDecoration(
                    labelText: 'Nama',
                  ),
                ),

                TextField(
                  controller: emailController,
                  decoration:
                      const InputDecoration(
                    labelText: 'Email',
                  ),
                ),

                TextField(
                  controller: outletController,
                  decoration:
                      const InputDecoration(
                    labelText: 'Outlet',
                  ),
                ),

                TextField(
                  controller: hpController,
                  keyboardType:
                      TextInputType.phone,
                  decoration:
                      const InputDecoration(
                    labelText: 'No. HP',
                  ),
                ),
              ],
            ),
          ),

          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(
                  dialogContext,
                );
              },
              child: const Text(
                'Batal',
              ),
            ),

            ElevatedButton(
              onPressed: () {
                setState(() {
                  nama =
                      namaController.text;
                  email =
                      emailController.text;
                  outlet =
                      outletController.text;
                  noHp =
                      hpController.text;
                });

                Navigator.pop(
                  dialogContext,
                );
              },
              style:
                  ElevatedButton.styleFrom(
                backgroundColor: orange,
                foregroundColor:
                    Colors.white,
              ),
              child: const Text(
                'Simpan',
              ),
            ),
          ],
        );
      },
    );
  }

  // =========================================================
  // LOGOUT DIALOG
  // =========================================================

  void _showLogoutDialog() {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (dialogContext) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius:
                BorderRadius.circular(10),
          ),

          contentPadding:
              const EdgeInsets.fromLTRB(
            20,
            15,
            20,
            20,
          ),

          content: SizedBox(
            width: 220,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(
                  Icons.logout,
                  size: 22,
                  color: Color(0xFF9A4E25),
                ),

                const SizedBox(height: 12),

                const Text(
                  'Yakin ingin keluar',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight:
                        FontWeight.bold,
                    color: darkText,
                  ),
                ),

                const SizedBox(height: 5),

                const Text(
                  'Anda akan keluar dari akun FoodFlow saat ini.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 8,
                    color: greyText,
                  ),
                ),

                const SizedBox(height: 18),

                Row(
                  children: [
                    Expanded(
                      child: SizedBox(
                        height: 26,
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.pop(
                              dialogContext,
                            );
                          },
                          style:
                              ElevatedButton.styleFrom(
                            backgroundColor:
                                const Color(
                              0xFFD9DDE3,
                            ),
                            foregroundColor:
                                Colors.white,
                            elevation: 0,
                            padding:
                                EdgeInsets.zero,
                            shape:
                                RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius
                                      .zero,
                            ),
                          ),
                          child: const Text(
                            'Batal',
                            style: TextStyle(
                              fontSize: 9,
                              fontWeight:
                                  FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(width: 45),

                    Expanded(
                      child: SizedBox(
                        height: 26,
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.pop(
                              dialogContext,
                            );

                            Navigator.pop(dialogContext);
                            Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const LoginPage(),
                              ),
                              (route) => false,
                            );
                          },
                          style:
                              ElevatedButton.styleFrom(
                            backgroundColor:
                                orange,
                            foregroundColor:
                                Colors.black,
                            elevation: 0,
                            padding:
                                EdgeInsets.zero,
                            shape:
                                RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius
                                      .zero,
                            ),
                          ),
                          child: const Text(
                            'Ya',
                            style: TextStyle(
                              fontSize: 9,
                              fontWeight:
                                  FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  // =========================================================
  // SECTION TITLE
  // =========================================================

  static Widget _sectionTitle(
    String title,
  ) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 15,
        bottom: 2,
      ),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 6,
          fontWeight: FontWeight.bold,
          color: Colors.grey,
        ),
      ),
    );
  }

  // =========================================================
  // SIDEBAR ITEM
  // =========================================================

  static Widget _sidebarItem(
    String title, {
    bool selected = false,
    bool logout = false,
    required VoidCallback onTap,
  }) {
    return Padding(
      padding:
          const EdgeInsets.symmetric(
        horizontal: 8,
        vertical: 2,
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius:
            BorderRadius.circular(5),
        child: Container(
          height: 27,
          padding:
              const EdgeInsets.symmetric(
            horizontal: 9,
          ),
          decoration: BoxDecoration(
            color: selected
                ? peach
                : Colors.transparent,
            borderRadius:
                BorderRadius.circular(5),
          ),
          alignment:
              Alignment.centerLeft,
          child: Row(
            children: [
              Text(
                '•',
                style: TextStyle(
                  fontSize: 10,
                  color: logout
                      ? Colors.red
                      : selected
                          ? orange
                          : greyText,
                ),
              ),

              const SizedBox(width: 5),

              Expanded(
                child: Text(
                  title,
                  style: TextStyle(
                    fontSize: 8,
                    color: logout
                        ? Colors.red
                        : selected
                            ? orange
                            : greyText,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // =========================================================
  // INFO
  // =========================================================

  void _showInfo(String menuName) {
    ScaffoldMessenger.of(context)
        .showSnackBar(
      SnackBar(
        content: Text(
          '$menuName akan dibuka pada halaman berikutnya.',
        ),
      ),
    );
  }
}