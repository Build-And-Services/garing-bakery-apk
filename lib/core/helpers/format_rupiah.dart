String formatRupiah(int amount) {
  String rupiah = 'Rp ';

  // Ubah ke format mata uang Rupiah dengan titik sebagai pemisah ribuan
  rupiah += amount.toString().replaceAllMapped(
        RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
        (Match m) => '${m[1]}.',
      );

  // Tambahkan ,00 di belakangnya jika tidak memiliki desimal
  if (!rupiah.contains(',')) {
    rupiah += ',00';
  }

  return rupiah;
}
