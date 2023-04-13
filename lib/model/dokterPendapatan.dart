import 'package:flutter/material.dart';

class Pendapatan {
  String jml_kunjungan;
  String jml_resep;
  String jml_rujuk;
  String pendapatan;
  String periode;
  String Bln;
  String userId;

  Pendapatan({
    this.Bln = "",
    this.pendapatan ="",
    this.jml_kunjungan ="",
    this.jml_resep ="",
    this.jml_rujuk ="",
    this.userId = "",
    this.periode ="",
  });

  factory Pendapatan.fromJson(Map<String, dynamic> json) {
    return Pendapatan(
      Bln: json["bln"] ?? '-',
      jml_kunjungan : json ["jml_kunjungan"] ?? '-',
      jml_resep : json ["jml_resep"] ?? '-',
      jml_rujuk : json ["jml_rujukan"] ?? '-',
      pendapatan:  json ["pendaptan"] ?? '-',
      periode : json ["periode"] ?? '-',
      userId: json["kode_dokter"] ?? '-',
    );
  }




  static List<Pendapatan> fromJsonList(List list) {
    return list.map((item) => Pendapatan.fromJson(item)).toList();
  }

  static fromJsonMR(Map<String, dynamic> parsed) {}
  
}
