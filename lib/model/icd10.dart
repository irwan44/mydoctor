class icd10 {
  List<Icd10Px>? icd10Px;
  int? code;

  icd10({this.icd10Px, this.code});

  icd10.fromJson(Map<String, dynamic> json) {
    if (json['icd10_px'] != null) {
      icd10Px = <Icd10Px>[];
      json['icd10_px'].forEach((v) {
        icd10Px!.add(new Icd10Px.fromJson(v));
      });
    }
    code = json['code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.icd10Px != null) {
      data['icd10_px'] = this.icd10Px!.map((v) => v.toJson()).toList();
    }
    data['code'] = this.code;
    return data;
  }
}

class Icd10Px {
  int? no;
  String? tanggal;
  String? jam;
  String? kelompokIcd;
  String? namaKelompok;
  String? kodeICD;
  String? namaIcd10;
  String? diagnosa;
  Null? kodeAsterik;
  Null? namaAterik;

  Icd10Px(
      {this.no,
        this.tanggal,
        this.jam,
        this.kelompokIcd,
        this.namaKelompok,
        this.kodeICD,
        this.namaIcd10,
        this.diagnosa,
        this.kodeAsterik,
        this.namaAterik});

  Icd10Px.fromJson(Map<String, dynamic> json) {
    no = json['no'];
    tanggal = json['tanggal'];
    jam = json['jam'];
    kelompokIcd = json['kelompok_icd'];
    namaKelompok = json['nama_kelompok'];
    kodeICD = json['kodeICD'];
    namaIcd10 = json['nama_icd10'];
    diagnosa = json['diagnosa'];
    kodeAsterik = json['kodeAsterik'];
    namaAterik = json['nama_aterik'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['no'] = this.no;
    data['tanggal'] = this.tanggal;
    data['jam'] = this.jam;
    data['kelompok_icd'] = this.kelompokIcd;
    data['nama_kelompok'] = this.namaKelompok;
    data['kodeICD'] = this.kodeICD;
    data['nama_icd10'] = this.namaIcd10;
    data['diagnosa'] = this.diagnosa;
    data['kodeAsterik'] = this.kodeAsterik;
    data['nama_aterik'] = this.namaAterik;
    return data;
  }
}
