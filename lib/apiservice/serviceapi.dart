import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:doctorapp/model/hissmodel.dart';
import 'package:http/http.dart' as http;
import 'package:doctorapp/utils/constant.dart';
import 'package:doctorapp/model/usermodel.dart';
import 'package:doctorapp/model/pasienmodel.dart';
import 'package:doctorapp/model/periksamodel.dart';

import '../model/dataHomePageModel.dart';

class UserApiService {
  static Future<UserProfile?> getUser(String uid, String pass) async {
    String uidMember = "dr_harry";
    String passMember = "averin";

    Map databody = {'User': uid, 'Pass': pass};
    String bodyRaw = json.encode(databody);
    UserProfile? userReturn = UserProfile();

    try {
      Map<String, String> header = new Map();

      header["X-Api-Token"] = "a";
      header["token"] = "a";

      Uri url = Uri.parse('${URLS.BASE_URL}/_api_soap/act_login_dokter.php');
      final response = await http.post(
        url,
        body: bodyRaw,
      );

      List<UserProfile> myModels = [];

      if (response.statusCode == 200) {
        Map<String, dynamic> map = json.decode(response.body);

        var result = map["code"];

        if (result.toString() == "500") {
          var resulterror = map["msg"];
          userReturn = UserProfile();
          userReturn.userName = "No";
          userReturn.userTitle = resulterror.toString();
        } else {
          var dataUser = map["dt_dokter"];
          final parsed = List<Map<String, dynamic>>.from(dataUser).toList();

          print(parsed);
          myModels = parsed
              .map<UserProfile>((parsed) => UserProfile.fromJson(parsed))
              .toList();
          UserProfile? userGet = myModels.first;
          userReturn = userGet;
        }
      }

      return userReturn;
    } catch (error) {
      print('no akses');
      userReturn = UserProfile();
      userReturn.userName = "No";
      userReturn.userTitle = 'Tidak bisa akses';

      throw error;
    }

    // finally {
    //   return userReturn;
    // }
  }

  static Future<PeriksaPasienProfile> getHasilICD10(String mrNo,
      String regNo, String visitNo) async {
    try {
      PeriksaPasienProfile? userReturn = PeriksaPasienProfile();
      Map<String, String> header = new Map();

      header["X-Api-Token"] = "a";
      header["token"] = "a";

      Uri url = Uri.parse('${URLS.BASE_URL}/_api_soap/get_hasil_icd10_px.php');
      // var response = await Dio().get(
      //   url.toString(),
      //   queryParameters: queryParameters, //{"kd": tp},
      // );

      Map databody = {
        'no_mr': mrNo,
        'no_registrasi': regNo
      };

      String bodyRaw = json.encode(databody);

      final response = await http.post(
        url,
        body: bodyRaw,
      );
      List<PeriksaPasienProfile> myModels = [];

      if (response.statusCode == 200) {
        Map<String, dynamic> map = json.decode(response.body);

        var result = map["code"];

        if (result.toString() == "500") {
          userReturn.code = result.toString();
        } else if (result.toString() == "201" || result.toString() == "301") {
          userReturn.code = result.toString();
        } else {
          var dataUser = map["icd10_px"];

          PeriksaPasienProfile? userMap = PeriksaPasienProfile();
          userMap = PeriksaPasienProfile.fromJson(dataUser);

          var resultobj = map["icd10_px"];

          userMap.tanggal = resultobj["tanggal"].toString();
          userMap.jam = resultobj["jam"].toString();
          userMap.kelompok_icd = resultobj["kelompok_icd"].toString();
          userMap.nama_kelompok = resultobj["nama_kelompok"].toString();
          userMap.kodeICD = resultobj["kodeICD"].toString();
          userMap.nama_icd10 = resultobj["nama_icd10"].toString();
          userMap.diagnosa = resultobj["diagnosa"].toString();

          userReturn = userMap;
          userReturn.code = result.toString();
        }
      }

      return userReturn;
    } catch (error) {
      throw error;
    }
  }

  static Future<PeriksaPasienProfile> getVitalSignPasienPost(String mrNo,
      String regNo, String visitNo) async {
    try {
      PeriksaPasienProfile? userReturn = PeriksaPasienProfile();
      Map<String, String> header = new Map();

      header["X-Api-Token"] = "a";
      header["token"] = "a";

      Uri url = Uri.parse('${URLS.BASE_URL}/_api_soap/get_vital_sign_px.php');
      // var response = await Dio().get(
      //   url.toString(),
      //   queryParameters: queryParameters, //{"kd": tp},
      // );

      Map databody = {
        'no_mr': mrNo,
        'no_registrasi': regNo,
        'no_kunjungan': visitNo
      };

      String bodyRaw = json.encode(databody);

      final response = await http.post(
        url,
        body: bodyRaw,
      );
      List<PeriksaPasienProfile> myModels = [];

      if (response.statusCode == 200) {
        Map<String, dynamic> map = json.decode(response.body);

        var result = map["code"];

        if (result.toString() == "500") {
          userReturn.code = result.toString();
        } else if (result.toString() == "201" || result.toString() == "301") {
          userReturn.code = result.toString();
        } else {
          var dataUser = map["data_vital_sign"];

          PeriksaPasienProfile? userMap = PeriksaPasienProfile();
          userMap = PeriksaPasienProfile.fromJson(dataUser);

          var resultobj = map["data_soap"];

          userMap.subjektif = resultobj["subjektif"].toString();
          userMap.objektif = resultobj["objektif"].toString();
          userMap.assesment = resultobj["assesment"].toString();
          userMap.id_tc_soap = resultobj["id_tc_soap"].toString();
          userMap.id_tc_status_pasien =
              resultobj["id_tc_status_pasien"].toString();

          userReturn = userMap;
          userReturn.code = result.toString();
        }
      }

      return userReturn;
    } catch (error) {
      throw error;
    }
  }

  static Future<PeriksaPasienProfile> getDetaiMRPasienPost(
      String regNo) async {
    try {
      PeriksaPasienProfile? userReturn = PeriksaPasienProfile();
      Map<String, String> header = new Map();

      header["X-Api-Token"] = "a";
      header["token"] = "a";

      Uri url = Uri.parse('${URLS.BASE_URL}/_api_soap/get_detail_mr.php');
      // var response = await Dio().get(
      //   url.toString(),
      //   queryParameters: queryParameters, //{"kd": tp},
      // );

      Map databody = {
        'no_registrasi': regNo,
      };

      String bodyRaw = json.encode(databody);

      final response = await http.post(
        url,
        body: bodyRaw,
      );
      List<PeriksaPasienProfile> myModels = [];

      if (response.statusCode == 200) {
        Map<String, dynamic> map = json.decode(response.body);

        var result = map["code"];

        if (result.toString() == "500") {
          userReturn.code = result.toString();
        } else if (result.toString() == "201" || result.toString() == "301") {
          userReturn.code = result.toString();
        } else {
          var dataUser = map["data_vital_sign"];
          PeriksaPasienProfile? userMap = PeriksaPasienProfile();
          userMap = PeriksaPasienProfile.fromJson(dataUser);
          var resultobj = map["data_soap"];

          userMap.subjektif = resultobj["subjektif"].toString();
          userMap.objektif = resultobj["objektif"].toString();
          userMap.assesment = resultobj["assesment"].toString();
          userMap.id_tc_soap = resultobj["id_tc_soap"].toString();
          userMap.id_tc_status_pasien = resultobj["id_tc_status_pasien"].toString();

          userReturn = userMap;
          userReturn.code = result.toString();
        }
      }

      return userReturn;
    } catch (error) {
      throw error;
    }
  }





  static Future<PeriksaPasienProfile> getMRDetailPasienPost(String mrNo,
      String regNo, String visitNo) async {
    try {
      PeriksaPasienProfile? userReturn = PeriksaPasienProfile();
      Map<String, String> header = new Map();

      header["X-Api-Token"] = "a";
      header["token"] = "a";

      Uri url = Uri.parse('${URLS.BASE_URL}/_api_soap/get_detail_mr.php');
      // var response = await Dio().get(
      //   url.toString(),
      //   queryParameters: queryParameters, //{"kd": tp},
      // );

      Map databody = {
        'no_registrasi': regNo,
      };

      String bodyRaw = json.encode(databody);

      final response = await http.post(
        url,
        body: bodyRaw,
      );
      List<PeriksaPasienProfile> myModels = [];

      if (response.statusCode == 200) {
        Map<String, dynamic> map = json.decode(response.body);

        var result = map["code"];

        if (result.toString() == "500") {
          userReturn.code = result.toString();
        } else if (result.toString() == "201" || result.toString() == "301") {
          userReturn.code = result.toString();
        } else {
          var dataUser = map["dt_px"];

          PeriksaPasienProfile? userMap = PeriksaPasienProfile();
          userMap = PeriksaPasienProfile.fromJson(dataUser);

          var resultobj = map["dt_soap"];

          userMap.subjektif = resultobj["subjektif"].toString();
          userMap.objektif = resultobj["objektif"].toString();
          userMap.assesment = resultobj["assesment"].toString();
          userReturn = userMap;
          userReturn.code = result.toString();
        }
      }

      return userReturn;
    } catch (error) {
      throw error;
    }
  }

  static Future<List<AntrianPasienProfile>> getPasienAntri(String search,
      String idDokter) async {
    try {
      UserProfile? userReturn = UserProfile();
      Map<String, String> header = new Map();

      header["X-Api-Token"] = "a";
      header["token"] = "a";

      final queryParameters = {
        'search': search,
        'kode_dokter': idDokter,
      };

      Uri url =
      Uri.parse('${URLS.BASE_URL}/_api_soap/get_antrian_dokter_soap.php');
      var response = await Dio().get(
        url.toString(),
        queryParameters: queryParameters,
      );

      List<AntrianPasienProfile> myModels = [];

      final data = response.data;
      if (data != null) {
        Map<String, dynamic> map = json.decode(data);
        var result = map["code"];

        if (result.toString() == "500" || result == null) {} else {
          var dataUser = map["dt_antrian"];
          final parsed = List<Map<String, dynamic>>.from(dataUser).toList();
          print(parsed);
          myModels = parsed
              .map<AntrianPasienProfile>(
                  (parsed) => AntrianPasienProfile.fromJson(parsed))
              .toList();
        }
      }

      return myModels;
    } catch (error) {
      throw error;
    }
  }

  static Future<List<AntrianPasienProfile>> getPasienMRDokterList(String search,
      String idDokter) async {
    try {
      UserProfile? userReturn = UserProfile();
      Map<String, String> header = new Map();

      header["X-Api-Token"] = "a";
      header["token"] = "a";

      final queryParameters = {
        'search': search,
        'kode_dokter': idDokter,
      };

      Uri url =
      Uri.parse('${URLS.BASE_URL}/_api_soap/get_antrian_dokter_soap.php');
      var response = await Dio().get(
        url.toString(),
        queryParameters: queryParameters,
      );

      List<AntrianPasienProfile> myModels = [];

      final data = response.data;
      if (data != null) {
        Map<String, dynamic> map = json.decode(data);
        var result = map["code"];
        if (result.toString() == "500" || result == null) {} else {
          var dataUser = map["dt_antrian"];
          final parsed = List<Map<String, dynamic>>.from(dataUser).toList();
          print(parsed);
          myModels = parsed
              .map<AntrianPasienProfile>(
                  (parsed) => AntrianPasienProfile.fromJson(parsed))
              .toList();
        }
      }

      return myModels;
    } catch (error) {
      throw error;
    }
  }

  static Future<List<AntrianPasienProfile>> getPasienMRPasienList(
      String tanggal, String idPasien, String regNo) async {
    try {
      UserProfile? userReturn = UserProfile();
      Map<String, String> header = new Map();

      header["X-Api-Token"] = "a";
      header["token"] = "a";

      final queryParameters = {
        'tgl': tanggal,
        'no_mr': idPasien,
      };

      Uri url = Uri.parse('${URLS.BASE_URL}/_api_soap/get_list_mr.php');
      var response = await Dio().get(
        url.toString(),
        queryParameters: queryParameters,
      );

      List<AntrianPasienProfile> myModels = [];

      final data = response.data;
      if (data != null) {
        Map<String, dynamic> map = json.decode(data);
        var result = map["code"];

        if (result.toString() == "500" || result == null) {} else {
          var dataUser = map["res"];
          final parsed = List<Map<String, dynamic>>.from(dataUser).toList();
          print(parsed);
          myModels = parsed
              .map<AntrianPasienProfile>(
                  (parsed) => AntrianPasienProfile.fromJsonMR(parsed))
              .toList();
          print('jumlah record ' + myModels.length.toString());
        }
      }

      return myModels;
    } catch (error) {
      throw error;
    }
  }

  static Future<List<AntrianPasienProfile>> getPasienMRPasienDetail(
      String search, String idDokter) async {
    try {
      UserProfile? userReturn = UserProfile();
      Map<String, String> header = new Map();

      header["X-Api-Token"] = "a";
      header["token"] = "a";

      final queryParameters = {
        'search': search,
        'kode_dokter': idDokter,
      };

      Uri url =
      Uri.parse('${URLS.BASE_URL}/_api_soap/get_antrian_dokter_soap.php');
      var response = await Dio().get(
        url.toString(),
        queryParameters: queryParameters,
      );

      List<AntrianPasienProfile> myModels = [];

      final data = response.data;
      if (data != null) {
        Map<String, dynamic> map = json.decode(data);
        var result = map["code"];
        if (result.toString() == "500" || result == null) {} else {
          var dataUser = map["dt_antrian"];
          final parsed = List<Map<String, dynamic>>.from(dataUser).toList();
          print(parsed);
          myModels = parsed
              .map<AntrianPasienProfile>(
                  (parsed) => AntrianPasienProfile.fromJson(parsed))
              .toList();
        }
      }

      return myModels;
    } catch (error) {
      throw error;
    }
  }


  static Future<bool> postvitalSignPasienAntri(PeriksaPasienProfile data,
      AntrianPasienProfile dataprofile) async {
    bool okeh = false;
    try {
      Uri url = Uri.parse('${URLS.BASE_URL}/_api_soap/edit_vital_sign.php');
      Map databody = {
        "no_mr": dataprofile.no_mr,
        "no_registrasi": dataprofile.no_registrasi,
        "no_kunjungan": dataprofile.no_kunjungan,
        "keadaan_umum": data.keadaan_umum,
        "kesadaran_pasien": data.kesadaran_pasien,
        "tekanan_darah": data.tekanan_darah,
        "nadi": data.nadi,
        "suhu": data.suhu,
        "pernafasan": data.pernafasan,
        "berat_badan": data.berat_badan,
        "tinggi_badan": data.tinggi_badan,
        "heart_rate": "1",
        "lingkar_perut": "0",
      };
      String bodyRaw = json.encode(databody);

      final response = await http.post(
        url,
        body: bodyRaw,
      );

      if (response.statusCode == 200) {
        okeh = true;
      }

      return okeh;
    } catch (error) {
      throw error;
    }
  }

  static Future<bool> postTindakanPasien(Map isiEntry) async {
    bool okeh = false;

    Uri? url = Uri.parse('${URLS.BASE_URL}/_api_soap/add_tindakan.php');
    Map databody = isiEntry;

    try {
      databody = {
        "no_registrasi": "212",
        "no_kunjungan": "111",
        "kode_bagian_tujuan": "268",
        "kode_dokter": "1",
        "no_mr": "12-19-00464",
        "nama_pasien": "Musa",
        "kode_tarif": "20290",
        "jumlah_tindakan": "2",
        "kode_brg": "23",
        "jumlah_obat": "3",
        "id_user": "1",
      };

      String bodyRaw = json.encode(databody);

      final response = await http.post(
        url,
        body: bodyRaw,
      );

      if (response.statusCode == 200) {
        okeh = true;
      }

      return okeh;
    } catch (error) {
      okeh = false;
      return okeh;
    }
  }

  static Future<bool> postvitalSOAPPasienAntri(PeriksaPasienProfile data,
      AntrianPasienProfile dataprofile) async {
    bool okeh = false;
    try {
      Uri? url =
      Uri.parse('${URLS.BASE_URL}/_api_soap/addedit_soap_dokter.php');

      String kode = "edit";
      Map databody = {};

      if (data.code == "301") {
        kode = "add";
      }

      if (kode == "edit") {
        databody = {
          "act": kode,
          "id_user": dataprofile.dokterid,
          "id_tc_status_pasien": data.id_tc_status_pasien,
          "id_tc_soap": data.id_tc_soap,
          "no_mr": dataprofile.no_mr,
          "subjectiv": data.subjektif,
          "terapi": data.assesment,
          "keterangan": data.objektif
        };

        databody = {
          "act": kode,
          "id_user": dataprofile.dokterid,
          "id_tc_status_pasien": data.id_tc_status_pasien,
          "id_tc_soap": data.id_tc_soap,
          "no_mr": dataprofile.no_mr,
          "subjectiv": data.subjektif,
          "terapi": data.assesment,
          "keterangan": data.objektif
        };
      } else {}

      String bodyRaw = json.encode(databody);

      final response = await http.post(
        url,
        body: bodyRaw,
      );

      if (response.statusCode == 200) {
        okeh = true;
      }

      return okeh;
    } catch (error) {
      throw error;
    }
  }

  static Future<List<HISSData>> getHISSNamaPenyakit(String kelompok) async {
    String uidMember = "dr_harry";
    String passMember = "averin";

    Map databody = {'src_penyakit': kelompok};
    String bodyRaw = json.encode(databody);

    try {
      Map<dynamic, dynamic> header = new Map();

      // header["X-Api-Token"] = "a";
      // header["token"] = "a";

      Uri url =
      Uri.parse('${URLS.BASE_URL}/_api_soap/get_nama_penyakit_hiss.php');

      final response = await http.post(
        url,
        body: bodyRaw,
      );

      List<HISSData> myModels = [];

      if (response.statusCode == 200) {
        Map<String, dynamic> map = json.decode(response.body);

        var result = map["code"];

        if (result.toString() == "500") {} else {
          Map<dynamic, dynamic> maps = json.decode(response.body);
          var Data = maps["list"];
          print(Data);

          final parsed = List<Map<dynamic, dynamic>>.from(Data).toList();
          //header = parsed;
          //print(parsed);
          // //.where((element) => );
          myModels = Data.map<HISSData>((parsed) => HISSData.fromJson(parsed))
              .toList();
        }
      }

      return myModels;
    } catch (error) {
      throw error;
    }
  }

  static Future<GetHomePage> getHomePage(
      {required String bulan, required String idDokter,}) async {
    final response = await http.post(
        Uri.parse('${URLS.BASE_URL}/_api_soap/get_homepage.php'),
        headers: {
          'X-Api-Token': '',
          'token': '',
        }, body: json.encode({
      "bln": bulan,
      "kode_dokter": idDokter
    }));
    return GetHomePage.fromJson(jsonDecode(response.body));
  }

}

