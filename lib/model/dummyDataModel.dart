class DummyDataModel {
  String title, subTitle, imageUrl, mobileNumber, date, status;

  DummyDataModel({
    required this.title,
    required this.subTitle,
    required this.imageUrl,
    required this.date,
    required this.status,
    required this.mobileNumber,
  });
}

class kesadaranDataModel {
  String? kode;
  String? keterangan;

  kesadaranDataModel({
    this.kode,
    this.keterangan,
  });
}

class ICD10DataModel {
  String? kode;
  String? keterangan;

  ICD10DataModel({
    this.kode,
    this.keterangan,
  });
}
