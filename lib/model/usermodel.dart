import 'package:flutter/material.dart';

class UserProfile {
  String jml_kunjungan;
  String jml_resep;
  String jml_rujuk;
  String pendapatan;
  String periode;
  String userId;
  String id_tc_status_pasien;
  String userName;
  String userTitle;
  String userUrl;
  String Bln;
  String userIdlain;
  String resultcode;
  String url_foto_karyawan;

  UserProfile({
    this.Bln = "",
    this.pendapatan ="",
    this.jml_kunjungan ="",
    this.jml_resep ="",
    this.jml_rujuk ="",
    this.periode ="",
    this.id_tc_status_pasien ="",
    this.url_foto_karyawan ="",
    this.userId = "",
    this.userName = "",
    this.userTitle = "",
    this.userUrl = "",
    this.userIdlain = "",
    this.resultcode = "",
  });

  factory UserProfile.fromJson(Map<String, dynamic> json) {
    return UserProfile(
      Bln: json["bln"] ?? '-',
      userId: json["kode_dokter"] ?? '-',
      userName: json["nama_pegawai"] ?? '-',
      userTitle: json["nama_spesialisasi"] ?? '-',
      url_foto_karyawan: json["url_foto_karyawan"] ?? '-',
      userIdlain: json["id_dd_user"] ?? '-',
      resultcode: json["code"] ?? '-',
      jml_kunjungan : json ["jml_kunjungan"] ?? '-',
      jml_resep : json ["jml_resep"] ?? '-',
      jml_rujuk : json ["jml_rujukan"] ?? '-',
      pendapatan:  json ["pendaptan"] ?? '-',
      periode : json ["periode"] ?? '-',
        id_tc_status_pasien : json ["id_tc_status_pasien"] ?? '-',
    );
  }




  static List<UserProfile> fromJsonList(List list) {
    return list.map((item) => UserProfile.fromJson(item)).toList();
  }
}
