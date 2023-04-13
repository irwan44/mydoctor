import 'package:flutter/material.dart';

class AntrianPasienProfile {
  String jml_kunjungan;
  String jml_resep;
  String jml_rujuk;
  String periode;
  String no_kunjungan;
  String userId;
  String nama_px;
  String nomr_px;
  String ktp_px;
  String gender;
  String gol_darah;
  String umur;
  String alergi;
  String alamat_px;
  String wkt_periksa;
  String nama_dokter;
  String tgl_periksa;
  String nama_bagian;
  String no_registrasi;
  String kode_bagian;
  String kode_bagian_tujuan;
  String kode_poli;
  bool flag_bayar;
  String id_pl_tc_poli;
  String no_antrian;
  String no_mr;
  String gender_px;
  String url_foto_px;
  String umur_px;
  String gol_darah_px;
  String alergi_px;
  String jam_daftar;
  String resultcode;
  String dokterid;
  String bln;
  String code;
  String subjektif;
  AntrianPasienProfile({
    this.no_kunjungan ="",
    this.userId ="",
    this.subjektif ="",
    this.jml_kunjungan ="",
    this.jml_resep ="",
    this.bln = "",
    this.jml_rujuk ="",
    this.periode ="",
    this.code ="",
    this.nama_px ="",
    this.nomr_px ="",
    this.ktp_px ="",
    this.gender ="",
    this.gol_darah ="",
    this.umur ="",
    this.alergi ="",
    this.alamat_px ="",
    this.wkt_periksa ="",
    this.nama_bagian ="",
    this.tgl_periksa ="",
    this.nama_dokter ="",
    this.no_registrasi = "",
    this.kode_bagian = "",
    this.kode_bagian_tujuan = "",
    this.kode_poli = "",
    this.flag_bayar = false,
    this.id_pl_tc_poli = "",
    this.no_antrian = "",
    this.no_mr = "",
    this.gender_px = "",
    this.url_foto_px = "",
    this.umur_px = "",
    this.gol_darah_px = "",
    this.alergi_px = "",
    this.jam_daftar = "",
    this.resultcode = "",
    this.dokterid = "",
  });

  factory AntrianPasienProfile.fromJson(Map<String, dynamic> json) {
    return AntrianPasienProfile(
      no_kunjungan: json["no_kunjungan"] ?? '-',
      no_registrasi: json["no_registrasi"] ?? '-',
      kode_bagian: json["kode_bagian"] ?? '-',
      kode_bagian_tujuan: json["kode_bagian_tujuan"] ?? '-',
      kode_poli: json["kode_poli"] ?? '-',
      flag_bayar: json["flag_bayar"] ?? false,
      id_pl_tc_poli: json["id_pl_tc_poli"] ?? '-',
      no_antrian: json["no_antrian"] ?? '-',
      no_mr: json["no_mr"] ?? '-',
      nama_px: json["nama_px"] ?? '-',
      gender_px: json["gender_px"] ?? '-',
      url_foto_px: json["url_foto_px"] ?? '-',
      umur_px: json["umur_px"] ?? '-',
      gol_darah_px: json["gol_darah_px"] ?? '-',
      alergi_px: json["alergi_px"] ?? '-',
      jam_daftar: json["jam_daftar"] ?? '-',
      tgl_periksa: json["tgl_periksa"] ?? '-',
      resultcode: json["resultcode"] ?? '-',
        wkt_periksa : json ["wkt_periksa"] ?? '-',
      nomr_px : json ["nomr_px"] ?? '-',
      ktp_px : json ["ktp_px"] ?? '-',
      gender : json ["gender "] ?? '-',
      gol_darah : json ["gol_darah "] ?? '-',
      alergi: json ["alergi"] ?? '-',
      alamat_px: json ["alamat_px"] ?? '-',
        nama_bagian : json ["nama_bagian"] ?? '-',
        code : json ["code"] ?? '-',
        subjektif : json ["subjektif"] ?? '-',

    );
  }

  factory AntrianPasienProfile.fromJsonMR(Map<String, dynamic> json) {
    return AntrianPasienProfile(
      no_kunjungan: json["no_kunjungan"] ?? '-',
      no_registrasi: json["no_registrasi"] ?? '-',
      kode_bagian: json["kode_bagian"] ?? '-',
      kode_bagian_tujuan: json["kode_bagian_tujuan"] ?? '-',
      kode_poli: json["kode_poli"] ?? '-',
      flag_bayar: json["flag_bayar"] ?? false,
      id_pl_tc_poli: json["id_pl_tc_poli"] ?? '-',
      no_antrian: json["no_antrian"] ?? '-',
      no_mr: json["no_mr"] ?? '-',
      nama_px: json["nama_px"] ?? '-',
      gender_px: json["gender_px"] ?? '-',
      url_foto_px: json["url_foto_px"] ?? '-',
      umur_px: json["umur_px"] ?? '-',
      gol_darah_px: json["gol_darah_px"] ?? '-',
      alergi_px: json["alergi_px"] ?? '-',
      jam_daftar: json["jam_daftar"] ?? '-',
      tgl_periksa: json["tgl_periksa"] ?? '-',
      resultcode: json["resultcode"] ?? '-',
      wkt_periksa : json ["wkt_periksa"] ?? '-',
      nomr_px : json ["nomr_px"] ?? '-',
      ktp_px : json ["ktp_px"] ?? '-',
      gender : json ["gender "] ?? '-',
      gol_darah : json ["gol_darah "] ?? '-',
      umur: json ["umur"] ?? '-',
      alergi: json ["alergi"] ?? '-',
      alamat_px: json ["alamat_px"] ?? '-',
      nama_bagian : json ["nama_bagian"] ?? '-',
      nama_dokter: json ["nama_dokter"] ?? '-',
      code : json ["code"] ?? '-',
      jml_kunjungan : json ["jml_kunjungan"] ?? '-',
      jml_resep : json ["jml_resep"] ?? '-',
      jml_rujuk : json ["jml_rujukan"] ?? '-',
      periode : json ["periode"] ?? '-',
      subjektif : json ["subjektif"] ?? '-',


    );
  }



  static List<AntrianPasienProfile> fromJsonList(List list) {
    return list.map((item) => AntrianPasienProfile.fromJson(item)).toList();
  }

  void setDatapendapatan(List<AntrianPasienProfile> hAntrian) {}
}
