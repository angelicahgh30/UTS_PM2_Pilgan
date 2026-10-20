class Validators {
  Validators._();

  static String? name(String? value) {
    final v = value?.trim() ?? '';
    if (v.isEmpty) return 'Nama wajib diisi';
    if (v.length < 3) return 'Nama minimal 3 huruf';
    if (!RegExp(r"^[a-zA-Z\s.'-]+$").hasMatch(v)) {
      return 'Nama hanya boleh berisi huruf';
    }
    return null;
  }
}
