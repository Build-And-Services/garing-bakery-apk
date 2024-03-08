class ArgumentReportTransaction {
  String tanggal = '';
  String bulan = '';
  String tahun = '';
  ArgumentReportTransaction(
    this.tanggal,
    this.bulan,
    this.tahun,
  );
  String get date => tanggal;
  String get month => bulan;
  String get year => tahun;
}
