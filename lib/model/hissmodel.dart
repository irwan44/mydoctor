import 'package:flutter/material.dart';

class HISSData {
  String no;
  String ID;
  String Nama_Penyakit;
  String kode_obat;
  String nama_obat;
  String kode_tindakan;
  String nama_tindakan;

  HISSData({
    this.no = "",
    this.ID = "",
    this.Nama_Penyakit = "",
    this.kode_obat = "",
    this.nama_obat = "",
    this.kode_tindakan = "",
    this.nama_tindakan = "",
  });

  factory HISSData.fromJson(Map<String, String> json) {
    return HISSData(
      no: json["ID1"] ?? '-',
      ID: json["ID"] ?? '-',
      Nama_Penyakit: json["Nama_Penyakit"] ?? '-',
    );
  }

  static List<HISSData> fromJsonList(List list) {
    return list.map((item) => HISSData.fromJson(item)).toList();
  }
}

class DataTindakan {
  String type;
  String iD;
  String keterangan;
  String qty;
  String tanggal;
  String jumlah;

  DataTindakan({
    this.type = "",
    this.iD = "",
    this.tanggal = "",
    this.keterangan = "",
    this.qty = "",
    this.jumlah = "",
  });

  factory DataTindakan.fromJson(Map<String, String> json) {
    return DataTindakan(
      type: json["ID1"] ?? '-',
      iD: json["ID"] ?? '-',
      keterangan: json["Nama_Penyakit"] ?? '-',
      qty: json["ID"] ?? '-',
      tanggal: json ["tanggal"] ?? '-',
      jumlah: json["Nama_Penyakit"] ?? '-',
    );
  }

  static List<HISSData> fromJsonList(List list) {
    return list.map((item) => HISSData.fromJson(item)).toList();
  }
}

class DataICD10 {
  String type;
  String idCD10;
  String idCD10Astr;
  String idCD10Kel;
  String idCD10Ket;
  String idCD10AstrKet;
  String idCD10KelKet;

  DataICD10({
    this.type = "",
    this.idCD10 = "",
    this.idCD10Astr = "",
    this.idCD10Kel = "",
    this.idCD10Ket = "",
    this.idCD10AstrKet = "",
    this.idCD10KelKet = "",
  });

  factory DataICD10.fromJson(Map<String, String> json) {
    return DataICD10(
      type: json["ID1"] ?? '-',
      idCD10: json["ID"] ?? '-',
      idCD10Astr: json["Nama_Penyakit"] ?? '-',
      idCD10Kel: json["ID"] ?? '-',
      idCD10Ket: json["Nama_Penyakit"] ?? '-',
      idCD10AstrKet: json["Nama_Penyakit"] ?? '-',
      idCD10KelKet: json["Nama_Penyakit"] ?? '-',
    );
  }

  static List<HISSData> fromJsonList(List list) {
    return list.map((item) => HISSData.fromJson(item)).toList();
  }
}
