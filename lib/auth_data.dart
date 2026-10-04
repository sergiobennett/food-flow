class AuthData {
  static String? email;
  static String? password;
  static String? nama;

  static bool sudahTerdaftar() {
    return email != null && password != null;
  }

  static void daftar({
    required String namaBaru,
    required String emailBaru,
    required String passwordBaru,
  }) {
    nama = namaBaru;
    email = emailBaru;
    password = passwordBaru;
  }
}