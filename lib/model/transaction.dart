class Transaction {
  final int id;
  final String to;
  final String amount;
  final String date;
  final String description;
  final String tindakan;

  Transaction(
    this.id,
    this.to,
    this.amount,
    this.date,
    this.tindakan,
    this.description,
  );
}

final List<Transaction> transactions = [
  Transaction(
    1,
    'Dyah Ayu',
    '350.00',
    '202200004',
    'Konsultasi Dokter Umum',
    '16-02-2023',
  ),
  Transaction(
    2,
    'MUAWAN',
    '950.00',
    '2004-0000003',
    'Konsultasi Dokter Spesialis',
    '15-02-2023',
  ),
  Transaction(
    3,
    'Anisa, Ny.',
    '440.00',
    'Income',
    'Hematologi Rutin',
    '13-Sep-2022 12:13',
  ),
  Transaction(
    4,
    'Aghmaelia',
    '500.00',
    '2005-0000002',
    'Karcis / Pendaftaran baru',
    '20-02-2023',
  ),
  Transaction(
    5,
    '	NURUL WALIDAIN, An.',
    '350.00',
    '12-19-00464',
    'Karcis / Pendaftaran lama',
    '15-02-2023',
  ),
  Transaction(
    6,
    'SARAH',
    '440.00',
    '2004-0000001',
    'Konsultasi Dokter Gigi',
    '16-02-2023	',
  ),
];
