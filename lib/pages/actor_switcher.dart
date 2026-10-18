import 'package:flutter/material.dart';

// ===========================================================
// ACTOR SWITCHER FOODFLOW
// ===========================================================

class ActorSwitcher extends StatelessWidget {
  final String currentActor;

  const ActorSwitcher({
    super.key,
    required this.currentActor,
  });

  // =========================================================
  // WARNA
  // =========================================================

  static const Color orange = Color(0xFFFF7518);
  static const Color darkText = Color(0xFF26354A);

  // =========================================================
  // DAFTAR AKTOR DAN ROUTE
  // =========================================================

  static const Map<String, String> actorRoutes = {
    'Owner': '/owner',
    'Admin': '/admin',
    'Checker': '/checker',
    'Penjual': '/penjual',
  };

  // =========================================================
  // BUILD DROPDOWN
  // =========================================================

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<String>(
      tooltip: 'Ganti aktor',
      position: PopupMenuPosition.under,
      offset: const Offset(0, 5),
      color: Colors.white,
      elevation: 8,

      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),

      // UKURAN MENU
      constraints: const BoxConstraints(
        minWidth: 155,
      ),

      // =====================================================
      // AKSI SAAT AKTOR DIPILIH
      // =====================================================

      onSelected: (actor) {
        // Tidak melakukan navigasi apabila aktor yang dipilih
        // sama dengan aktor yang sedang digunakan.
        if (actor == currentActor) return;

        final String? targetRoute = actorRoutes[actor];

        if (targetRoute == null) return;

        // Bersihkan halaman sebelumnya dan langsung buka
        // dashboard aktor yang dipilih.
        Navigator.of(context).pushNamedAndRemoveUntil(
          targetRoute,
          (route) => false,
        );
      },

      // =====================================================
      // ISI DROPDOWN
      // =====================================================

      itemBuilder: (context) {
        return actorRoutes.keys.map((actor) {
          final bool isSelected = actor == currentActor;

          return PopupMenuItem<String>(
            value: actor,
            height: 38,

            child: Row(
              children: [
                Expanded(
                  child: Text(
                    actor,
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: isSelected
                          ? FontWeight.bold
                          : FontWeight.w500,
                      color: darkText,
                    ),
                  ),
                ),

                if (isSelected)
                  const Icon(
                    Icons.check,
                    size: 16,
                    color: orange,
                  ),
              ],
            ),
          );
        }).toList();
      },

      // =====================================================
      // TOMBOL UTAMA
      // =====================================================

      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 10,
          vertical: 7,
        ),

        decoration: BoxDecoration(
          color: orange,
          borderRadius: BorderRadius.circular(7),
        ),

        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              currentActor,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),

            const SizedBox(width: 3),

            const Icon(
              Icons.arrow_drop_down,
              size: 19,
              color: Colors.black,
            ),
          ],
        ),
      ),
    );
  }
}