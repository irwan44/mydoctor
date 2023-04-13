import 'dart:ffi';
import 'package:flutter/material.dart';

class DetailMRPasien {
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
  String dt_vs;
  String suhu;
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
  String subjektif;
  String objektif;
  String assesment;
  String code;
  String px;
  String vital_sign;
  String soap;
  String no_mr;
  String tindakan;

  DetailMRPasien({
    this.tindakan ="",
    this.soap ="",
    this.vital_sign ="",
    this.px ="",
    this.no_mr ="",
    this.nama_px ="",
    this.nomr_px ="",
    this.ktp_px ="",
    this.dt_vs ="",
    this.gender ="",
    this.gol_darah ="",
    this.umur ="",
    this.alergi ="",
    this.alamat_px ="",
    this.keadaan_umum = "",
    this.kesadaran_pasien = "",
    this.tekanan_darah = "",
    this.nadi = "",
    this.suhu = "",
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
    this.lingkar_perut = ""
  });

  factory DetailMRPasien.fromJson(Map<String, dynamic> json) {
    return DetailMRPasien(
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
      nama_px : json ["nama_px"] ?? '-',
      nomr_px : json ["nomr_px"] ?? '-',
      ktp_px : json ["ktp_px"] ?? '-',
      gender : json ["gender "] ?? '-',
      gol_darah : json ["gol_darah "] ?? '-',
      umur: json ["umur"] ?? '-',
      alergi: json ["alergi"] ?? '-',
      alamat_px: json ["alamat_px"] ?? '-',
      px : json ["px"] ?? '-',
      vital_sign : json ["vital_sign"] ?? '-',
      soap : json ["soap"] ?? '-',
      tindakan : json ["tindakan"] ?? '-',
        dt_vs : json ["dt_vs"] ?? '-',
      no_mr: json ["no_mr"] ?? '-',

    );
  }

  factory DetailMRPasien.fromJsonMR(Map<String, dynamic> json) {
    return DetailMRPasien(
      px : json ["px"] ?? '-',
      vital_sign : json ["vital_sign"] ?? '-',
      soap : json ["soap"] ?? '-',
      tindakan : json ["tindakan"] ?? '-',
      gol_darah : json ["icd10"] ?? '-',
      umur: json ["resep"] ?? '-',
      alergi: json ["hasil_lab"] ?? '-',
      alamat_px: json ["hasil_rad"] ?? '-',
      nama_px : json ["nama_px"] ?? '-',
      nomr_px : json ["nomr_px"] ?? '-',
      ktp_px : json ["ktp_px"] ?? '-',
      gender : json ["gender "] ?? '-',
      no_mr: json ["no_mr"] ?? '-',

    );
  }

}
