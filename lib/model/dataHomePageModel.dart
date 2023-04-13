class GetHomePage {
  List<Lists>? list;

  GetHomePage({this.list});

  GetHomePage.fromJson(Map<String, dynamic> json) {
    if (json['list'] != null) {
      list = <Lists>[];
      json['list'].forEach((v) {
        list!.add(Lists.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (list != null) {
      data['list'] = list!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Lists {
  String? jmlKunjungan;
  String? jmlResep;
  int? pendapatan;
  String? jmlRujuk;
  String? periode;

  Lists(
      {this.jmlKunjungan,
        this.jmlResep,
        this.pendapatan,
        this.jmlRujuk,
        this.periode});

  Lists.fromJson(Map<String, dynamic> json) {
    jmlKunjungan = json['jml_kunjungan'];
    jmlResep = json['jml_resep'];
    pendapatan = json['pendapatan'];
    jmlRujuk = json['jml_rujuk'];
    periode = json['periode'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['jml_kunjungan'] = jmlKunjungan;
    data['jml_resep'] = jmlResep;
    data['pendapatan'] = pendapatan;
    data['jml_rujuk'] = jmlRujuk;
    data['periode'] = periode;
    return data;
  }
}