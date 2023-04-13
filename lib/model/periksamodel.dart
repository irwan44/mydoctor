import 'package:flutter/material.dart';

class PeriksaPasienProfile {
  String jml_kunjungan;
  String jml_resep;
  String jml_rujuk;
  String periode;
  String nama_px;
  String nomr_px;
  String ktp_px;
  String gender;
  String gol_darah;
  String umur;
  String alergi;
  String alamat_px;
  String keadaan_umum;
  String kesadaran_pasien;
  String tekanan_darah;
  String nadi;
  String suhu;
  String nama_bagian;
  String no_mr;
  String pernafasan;
  String berat_badan;
  String tinggi_badan;
  String lingkar_kepala;
  String lingkar_dada;
  String skala_nyeri_face_number;
  String heart_rate;
  String lingkar_perut;
  String id_tc_status_pasien;
  String id_tc_soap;
  int? no;
  String tanggal;
  String jam;
  String nama_kelompok ;
  String kelompokIcd;
  String namaKelompok;
  String kodeICD;
  String namaIcd10;
  String diagnosa;
  String Vitaldata;
  String subjektif;
  String objektif;
  String assesment;
  String no_registrasi;
  String nama_dokter;
  String code;
  String nama_icd10;
  String no_kunjungan;
  String gol_darah_px;
  String dt_vs;
  String kelompok_icd;

  PeriksaPasienProfile(
      {this.keadaan_umum = "",
        this.jml_kunjungan ="",
        this.jml_resep ="",
        this.kelompok_icd ="",
        this.jml_rujuk ="",
        this.nama_kelompok ="",
        this.periode ="",
        this.tanggal = "",
        this.jam ="",
        this.nama_icd10 ="",
        this.kelompokIcd ="",
        this.namaKelompok="",
        this.kodeICD="",
        this.namaIcd10="",
        this.diagnosa="",
        this.kesadaran_pasien = "",
        this.tekanan_darah = "",
        this.dt_vs = "",
        this.nama_dokter ="",
        this.nama_px ="",
        this.nomr_px ="",
        this.ktp_px ="",
        this.gender ="",
        this.gol_darah ="",
        this.umur ="",
        this.alergi ="",
        this.alamat_px ="",
        this.no_kunjungan ="",
        this.nadi = "",
        this.suhu = "",
        this.gol_darah_px ="",
        this.no_mr = "",
        this.nama_bagian ="",
        this.no_registrasi ="",
        this.Vitaldata = "",
        this.pernafasan = "",
        this.berat_badan = "",
        this.lingkar_kepala = "",
        this.lingkar_dada = "",
        this.tinggi_badan = "",
        this.skala_nyeri_face_number = "",
        this.subjektif = "",
        this.objektif = "",
        this.assesment = "",
        this.id_tc_status_pasien = "",
        this.id_tc_soap = "",
        this.code = "",
        this.heart_rate = "",
        this.lingkar_perut = ""});

  factory PeriksaPasienProfile.fromJson(Map<String, dynamic> json) {
    return PeriksaPasienProfile(

      keadaan_umum: json["keadaan_umum"] ?? '-',
      kesadaran_pasien: json["kesadaran_pasien"] ?? '-',
      tekanan_darah: json["tekanan_darah"] ?? '-',
      nadi: json["nadi"] ?? '-',
      suhu: json["suhu"] ?? '-',
      pernafasan: json["pernafasan"] ?? false,
      berat_badan: json["berat_badan"] ?? '-',
      lingkar_kepala: json["lingkar_kepala"] ?? '-',
      lingkar_dada: json["lingkar_dada"] ?? '-',
      tinggi_badan: json["tinggi_badan"] ?? '-',
      skala_nyeri_face_number: json["skala_nyeri_face_number"] ?? '-',
      id_tc_status_pasien: json["id_tc_status_pasien"] ?? '-',
      id_tc_soap: json["id_tc_soap"] ?? '-',
      heart_rate: json["heart_rate"] ?? '-',
      lingkar_perut: json["lingkar_perut"] ?? '-',
      no_mr : json ["no_mr;"] ?? '_',
      no_registrasi : json ["no_registrasi"] ?? '-',
      nama_bagian : json ["nama_bagian;"] ?? '-',
        nama_dokter: json ["nama_dokter"] ?? '-',
      no_kunjungan: json["no_kunjungan"] ?? '-',
      nomr_px : json ["nomr_px"] ?? '-',
      ktp_px : json ["ktp_px"] ?? '-',
      gender : json ["gender "] ?? '-',
      gol_darah : json ["gol_darah "] ?? '-',
      umur: json ["umur"] ?? '-',
      alergi: json ["alergi"] ?? '-',
      alamat_px: json ["alamat_px"] ?? '-',
      gol_darah_px : json ["gol_darah_px;"] ?? '-',
      jml_kunjungan : json ["jml_kunjungan"] ?? '-',
      jml_resep : json ["jml_resep"] ?? '-',
      jml_rujuk : json ["jml_rujukan"] ?? '-',
      periode : json ["periode"] ?? '-',
        tanggal : json ["tanggal"] ?? '-',
        jam : json ["tanggal"] ?? '-',
        kelompokIcd  : json ["tanggal"] ?? '-',
        namaKelompok  : json ["tanggal"] ?? '-',
    kodeICD  : json ["tanggal"] ?? '-',
    namaIcd10  : json ["tanggal"] ?? '-',
        diagnosa :  json ["tanggal"] ?? '-',
        kelompok_icd : json ["kelompok_icd"] ?? '-',
      nama_icd10: json ["nama_icd10"] ?? '-',
      nama_kelompok: json["nama_kelompok"] ?? '-',
    );
  }

  static List<PeriksaPasienProfile> fromJsonList(List list) {
    return list.map((item) => PeriksaPasienProfile.fromJson(item)).toList();
  }
}
