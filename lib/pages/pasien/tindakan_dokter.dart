import 'dart:async';
import 'dart:convert';
//import 'dart:html';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:http/http.dart' as http;
import 'package:dio/dio.dart';
import 'package:doctorapp/apiservice/serviceapi.dart';
import 'package:doctorapp/model/hissmodel.dart';
import 'package:doctorapp/model/periksamodel.dart';
import 'package:doctorapp/model/usermodel.dart';
import 'package:doctorapp/pages/itemantrian.dart';
//import 'package:doctorapp/pages/pasien/component/list_antrian_pasiendetail.dart';
import 'package:doctorapp/provider/auth_user.dart';
import 'package:doctorapp/utils/colors.dart';
import 'package:doctorapp/utils/constant.dart';
import 'package:doctorapp/utils/strings.dart';
import 'package:doctorapp/utils/utility.dart';
import 'package:doctorapp/widgets/mysvgassetsimg.dart';
import 'package:doctorapp/widgets/mytext.dart';
import 'package:doctorapp/widgets/mytextformfield.dart';
import 'package:flutter/material.dart';
import 'package:doctorapp/provider/pasien_prov.dart';
import 'package:doctorapp/model/pasienmodel.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:doctorapp/pages/pasien/component/itemantrian_pasien.dart';
import 'package:dropdown_search/dropdown_search.dart';

class TindakanDokter extends StatefulWidget {
  const TindakanDokter({Key? key}) : super(key: key);

  @override
  State<TindakanDokter> createState() => _TindakanDokterState();
}

class _TindakanDokterState extends State<TindakanDokter> {

  final _formKey = GlobalKey<FormState>();
  int pilTindakan = 1;
  List<Map<dynamic, dynamic>> dataTindakan = [];
  List<Map<dynamic, dynamic>> dataObat = [];
  late List<HISSData> listSearchObat = [];
  late List<HISSData> listSearchTindakan = [];

  Map<dynamic, dynamic> _selectedItemUserTindakan = {
    "kode_tindakan": "-",
    "nama_tindakan": "-"
  };

  Map<dynamic, dynamic> _selectedItemUserObat = {
    "kode_obat": "-",
    "nama_obat": "-"
  };

  DataTindakan isiItem = new DataTindakan();

  TextEditingController jumlahTindakan = TextEditingController();
  TextEditingController jumlahObat = TextEditingController();
  TextEditingController BiayaTindakan = TextEditingController();
  TextEditingController BiayaObat = TextEditingController();
  bool progress = false;

  @override
  void initState() {
    _getFirtsInfoTindakan();
    _getFirtsInfoObat();
    super.initState();
    Provider.of<TindakanList>(context, listen: false).resetItem();
  }

  Future<void> _getFirtsInfoTindakan() async {
    final AuthPasienData tablesProvider =
    Provider.of<AuthPasienData>(context, listen: false);
    AntrianPasienProfile pasien = tablesProvider.DataPeriksaProfile;
    Uri urlTindakan = Uri.parse('${URLS.BASE_URL}/_api_soap/get_tindakan_px.php');

    var response = await Dio().get(
      urlTindakan.toString(),
      queryParameters: {"kode_bagian_tujuan": pasien.kode_bagian_tujuan},
    );

    try {
      final data = response.data;

      if (data != null) {
        Map<dynamic, dynamic> map = json.decode(response.data);
        var result = map["arr_tindakan"];

        setState(() {
          dataTindakan = List<Map<dynamic, dynamic>>.from(result).toList();
        });
        print(dataTindakan);
      } else {print('no ');}
    } catch (error) {
      // showAlertDialog(
      //     context: context, title: "Error ", content: error.toString());
      print(error.toString());
      return;
      //throw error;
    }
// finally {
//       await EasyLoading.dismiss();
//     }

    // AntrianPasienList;
  }


  Future<void> _getFirtsInfoObat() async {
    final AuthPasienData tablesProvider =
    Provider.of<AuthPasienData>(context, listen: false);
    AntrianPasienProfile pasien = tablesProvider.DataPeriksaProfile;

    Uri urlObat = Uri.parse('${URLS.BASE_URL}/_api_soap/get_obat_tindakan.php');

    var response = await Dio().get(
      urlObat.toString(),
      queryParameters: {"kode_bagian_tujuan": pasien.kode_bagian_tujuan},
    );

    try {
      final data = response.data;

      if (data != null) {
        Map<dynamic, dynamic> map = json.decode(response.data);
        var result = map["arr_obat"];

        setState(() {
          dataObat = List<Map<dynamic, dynamic>>.from(result).toList();
        });

        print(dataObat);
      } else {
        print('no ');
      }
    } catch (error) {
      // showAlertDialog(
      //     context: context, title: "Error ", content: error.toString());
      print(error.toString());
      return;
      //throw error;
    }
// finally {
//       await EasyLoading.dismiss();
//     }

    // AntrianPasienList;
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: myAppBar(),
      resizeToAvoidBottomInset: true, // blue,
      body: Container(
          width: size.width,
          child: Stack(
            alignment: Alignment.topLeft,
            children: [
              profile(),
              Container(
                child: Padding(
                  padding: const EdgeInsets.only(top: 100),
                  child: Container(
                    child: Padding(
                      //padding: const EdgeInsets.all(5.0),
                      padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                      child: Padding(
                        padding: const EdgeInsets.all(0.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Expanded(
                              child: ButtonPasien(),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ), //groupCategory
              Container(
                  child: Padding(
                      padding: const EdgeInsets.only(
                        top: 130,
                      ),
                      child: Container(
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(0, 60, 0, 0),
                            child: Form(
                                key: _formKey,
                                child: Container(
                                    height: MediaQuery.of(context).size.height,
                                    child: Column(children: [

                                      Expanded(
                                          child: Container(
                                            decoration: BoxDecoration(
                                              border: Border.all(
                                                color: Colors
                                                    .white24, //                   <--- border color
                                                width: 5.0,
                                              ),
                                              color:
                                              Color.fromARGB(255, 255, 255, 255),
                                              borderRadius: BorderRadius.only(
                                                topLeft: const Radius.circular(25.0),
                                                topRight: const Radius.circular(25.0),
                                              ), // BorderRadius
                                            ), // BoxDe
                                            child: ListView(
                                              children: [
                                            Padding(
                                            padding: const EdgeInsets.only(left: 10),
                                                child : Text('Pilih Tindakan dan Obat'),
                                            ),
                                                pilTindakan == 1
                                                    ? IsiTindakan(
                                                    context, dataTindakan)
                                                    : IsiObat(context, dataObat),
                                                ElevatedButton(
                                                    child: Text('Update'),
                                                    onPressed: () async {
                                                      postData();
                                                      bool _valid =
                                                      await _AddTindakanObat();

                                                      if (_valid) {
                                                        Provider.of<TindakanList>(
                                                            context,
                                                            listen: false)
                                                            .addItem(isiItem);
                                                      }

                                                      String mess = _valid
                                                          ? 'Data berhasil di tambahkan'
                                                          : 'Data gagal di tambahkan';
                                                      await AwesomeDialog(
                                                        context: context,
                                                        dialogType: DialogType.INFO,
                                                        animType: AnimType.SCALE,
                                                        title: 'Simpan Data',
                                                        desc: mess,
                                                        autoHide: const Duration(
                                                            seconds: 5),
                                                      ).show();
                                                      return;
                                                    },
                                                    style: ElevatedButton.styleFrom(
                                                      shape: RoundedRectangleBorder(
                                                        borderRadius:
                                                        BorderRadius.circular(
                                                            10.0),
                                                      ),
                                                      minimumSize: Size(100, 40),
                                                      primary: blue,
                                                      onPrimary: white,
                                                      textStyle: const TextStyle(
                                                          fontSize: 17,
                                                          fontWeight: FontWeight.w700,
                                                          color: black),
                                                    )),
                                                ListItemAdd()
                                              ],
                                            ),
                                          )),
                                    ]))),
                          )))),
            ],
          )),

    );
  }
  AppBar myAppBar() {
    return AppBar(
      elevation: 4,
      centerTitle: true,
      backgroundColor: Color.fromARGB(255, 35, 163, 223),
      shape: ContinuousRectangleBorder(
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(20),
          bottomRight: Radius.circular(20),

        ),),
      //statusBarColor,
      leading: IconButton(
        onPressed: () {
          Navigator.of(context).pop();
        },
        icon: MySvgAssetsImg(
          imageName: "back.svg",
          fit: BoxFit.contain,
          imgHeight: 35,
          imgWidth: 30,
        ),
      ),
      title: MyText(
        mTitle: 'Tindakan Dokter',
        mFontSize: 18,
        mFontStyle: FontStyle.normal,
        mFontWeight: FontWeight.normal,
        mTextAlign: TextAlign.center,
        mTextColor: white,
      ),
    );
  }
  Future<bool> _AddTindakanObat() async {
    AntrianPasienProfile pasien =
        Provider.of<AuthPasienData>(context, listen: false).DataPeriksaProfile;

    bool okeh = false;
    Map dataentry = {
      "no_registrasi": pasien.no_registrasi,
      "no_kunjungan": pasien.no_kunjungan,
      "kode_bagian_tujuan": pasien.kode_bagian_tujuan,
      "kode_dokter": pasien.dokterid,
      "no_mr": pasien.no_mr,
      "nama_pasien": pasien.nama_px,
      "kode_tarif": "20290",
      "jumlah_tindakan": jumlahTindakan.text,
      "kode_brg": _selectedItemUserTindakan['kode_tindakan'],
      "jumlah_obat": jumlahTindakan.text,
      "id_user": "1",
    };

    Uri? url = Uri.parse('${URLS.BASE_URL}/_api_soap/add_tindakan.php');

    String bodyRaw = json.encode(dataentry);

    final response = await http.post(
      url,
      body: bodyRaw,
    );

    if (response.statusCode == 200) {
      okeh = true;
    }

    return okeh;
  }

  Future<void> ProfileDetail() async {}
  Widget profile() {
    final AuthPasienData tablesProvider =
    Provider.of<AuthPasienData>(context, listen: false);
    AntrianPasienProfile _modelprofile = tablesProvider.DataPeriksaProfile;

    return FutureBuilder(
        future: ProfileDetail(),
        builder: (context, _) => Padding(
          // padding: EdgeInsets.symmetric(horizontal: 0),
            padding: EdgeInsets.only(top: 0),
            child: Container(
              height: 90,
              decoration: BoxDecoration(
                color: blue,
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(10),
                    bottomRight: Radius.circular(10)),
              ),
              width: displayWidth(context),
              child: LayoutBuilder(builder: (context, constraints) {
                var parentHeight = constraints.maxHeight;
                var parentWidth = constraints.maxWidth;
                return SingleChildScrollView(
                    physics: NeverScrollableScrollPhysics(),
                    child: Column(children: [
                      Stack(
                          children: [
                            Container(
                              height: displayHeight(context) * .55, // 125,
                              width: displayWidth(context),
                              child: Column(
                                children: [
                                 Container(
                                      width: displayWidth(context),
                                      height: 200,
                                      decoration: const BoxDecoration(
                                        color: Color.fromARGB(255, 35, 163, 223),
                                        borderRadius: BorderRadius.only(
                                            bottomLeft: Radius.circular(10),
                                            bottomRight: Radius.circular(10)),
                                        image: DecorationImage(
                                            image: AssetImage('assets/images/Design1.png'),
                                            fit: BoxFit.cover),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(15.0),
                                        child: Column(
                                          children: [
                                            _textWidgetRow(
                                                title: "Pasien yang Sedang di periksa"),
                                            SizedBox(
                                              height: 10,
                                            ),
                                            _textWidgetRow(
                                                title: "Nama Pasien :",
                                                value: _modelprofile.nama_px),
                                            SizedBox(
                                              height: 10,
                                            ),
                                            _textWidgetRow(
                                                title: "No MR:",
                                                value: _modelprofile.no_mr),
                                          ],
                                        ),
                                      ),
                                      //color: Colors.deepPurpleAccent,
                                    ),
                                ],
                              ),
                            )])]));
              }),
            )));
  }

  Widget _textWidgetRow({String? title, String? value}) {
    return Padding(
      padding: const EdgeInsets.all(0.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        //mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Text(title ?? '',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(255, 252, 248, 248),
                fontFamily: 'RobotoMono',
              )),
          SizedBox(width: 10),
          Flexible(
            child: new Text(value ?? '',
                textAlign: TextAlign.start,
                //overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 252, 248, 248),
                  fontFamily: 'RobotoMono',
                )),
          )
        ],
      ),
    );
  }

  @override
  Widget ButtonPasien() {
    final String NoKontrak;
    final GestureTapCallback? onTap;

    PeriksaPasienProfile vitalsignDataDef;
    final AuthPasienData tablesProvider =
    Provider.of<AuthPasienData>(context, listen: false);
    vitalsignDataDef = tablesProvider.DataPeriksa;

    return Padding(
      padding: const EdgeInsets.only(top: 0),
      child: Container(
          child: ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: Container(
                  child: Stack(
                    children: <Widget>[
                      ConstrainedBox(
                        constraints: BoxConstraints(
                          minHeight: 82,
                          minWidth: MediaQuery.of(context).size.width,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(0.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              ElevatedButtonTheme(
                                data: ElevatedButtonThemeData(
                                    style: ElevatedButton.styleFrom(
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(10.0),
                                        ),
                                        minimumSize: Size(160, 40))),
                                child: ButtonBar(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    ElevatedButton(
                                      child: Text('Tindakan'),
                                      onPressed: () {
                                        setState(() {
                                          pilTindakan = 1;
                                        });
                                      },
                                      style: ElevatedButton.styleFrom(
                                          primary: pilTindakan == 1
                                              ? Colors.blue
                                              : white,
                                          onPrimary:
                                          pilTindakan == 1 ? white : black,
                                          textStyle: TextStyle(
                                              fontSize: 17,
                                              fontWeight: FontWeight.w700,
                                              color: black)),
                                    ),
                                    ElevatedButton(
                                        child: Text('Pemberian Obat'),
                                        onPressed: () {
                                          setState(() {
                                            pilTindakan = 2;
                                          });
                                        },
                                        style: ElevatedButton.styleFrom(
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                            BorderRadius.circular(10.0),
                                          ),
                                          primary: pilTindakan == 2
                                              ? Color.fromRGBO(38, 153, 249, 1)
                                              : white,
                                          onPrimary:
                                          pilTindakan == 2 ? white : black,
                                          textStyle: TextStyle(
                                              fontSize: 17,
                                              fontWeight: FontWeight.w700,
                                              color: black
                                            //  pilTindakan == 2
                                            //   ? white
                                            //   : black
                                          ),
                                        )),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  )))),
    );
  }

  Future postData() async {
    //Change values on setState
    await new Future.delayed(const Duration(seconds: 3));
    setState(() {
      progress = false;
      isiItem.keterangan = pilTindakan == 1
          ? _selectedItemUserTindakan['nama_tindakan']
          : _selectedItemUserObat['nama_obat'];
      isiItem.type = pilTindakan == 1
          ? _selectedItemUserTindakan['kode_tindakan']
          : _selectedItemUserObat['kode_obat'];
    });

    print(isiItem);
  }

  @override
  Widget IsiTindakan(BuildContext context, List<Map<dynamic, dynamic>> item) {
    final String NoKontrak;
    final GestureTapCallback? onTap;

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
          height: MediaQuery.of(context).size.height * 0.22, // 125,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            color: white,
            borderRadius: BorderRadius.circular(15),
          ),
          child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Container(
                  child: Stack(
                    children: <Widget>[
                      ConstrainedBox(
                        constraints: BoxConstraints(
                          minHeight: 82,
                          minWidth: MediaQuery.of(context).size.width,
                        ),
                        child: Container(
                          padding: const EdgeInsets.only(top: 5),
                          child: Padding(
                              padding: const EdgeInsets.all(8),
                              child: Container(
                                //height: double.infinity,
                                child: ListComboItemTindakan(),
                              )),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.only(top: 115),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            // Padding(
                            //   padding: const EdgeInsets.all(20.0),
                            //   child: const Text('Jumlah',
                            //       style: TextStyle(
                            //         fontSize: 14,
                            //         fontWeight: FontWeight.bold,
                            //         color: Colors.black,
                            //         fontFamily: 'RobotoMono',
                            //       )),
                            // ),
                            // MyTextFormFieldEntry(
                            //   mController: jumlahTindakan, //mEmailController,
                            //   mObscureText: false,
                            //   mMaxLine: 1,
                            //   mHintTextColor: textHintColor,
                            //   mTextColor: otherColor,
                            //   mkeyboardType: TextInputType.number,
                            //   mTextInputAction: TextInputAction.next,
                            //   mWidth: 75,
                            //   mHeight: 25,
                            //   //mInputBorder: InputBorder.,
                            // ),
                          ],
                        ),
                      ),
                    ],
                  )))),
    );
  }

  @override
  Widget IsiObat(BuildContext context, List<Map<dynamic, dynamic>> item) {
    final String NoKontrak;
    final GestureTapCallback? onTap;

    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Container(
          height: MediaQuery.of(context).size.height * 0.22, // 125,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            color: white,
            borderRadius: BorderRadius.circular(15),
          ),
          child: ClipRRect(
              borderRadius: BorderRadius.circular(0),
              child: Container(
                // decoration: BoxDecoration(
                //   border: Border.all(
                //     color: gray, //                   <--- border color
                //     width: 3.0,
                //   ),
                // ),
                  child: Stack(
                    children: <Widget>[
                      ConstrainedBox(
                        constraints: BoxConstraints(
                          minHeight: 82,
                          minWidth: MediaQuery.of(context).size.width,
                        ),
                        child: Container(
                          padding: const EdgeInsets.only(top: 5),
                          child: Padding(
                              padding: const EdgeInsets.all(8),
                              child: Container(
                                child: ListComboItemObat(),
                              )),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.only(top: 115),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            // Padding(
                            //   padding: const EdgeInsets.all(20.0),
                            //   child: const Text('Jumlah',
                            //       style: TextStyle(
                            //         fontSize: 14,
                            //         fontWeight: FontWeight.bold,
                            //         color: Colors.black,
                            //         fontFamily: 'RobotoMono',
                            //       )),
                            // ),
                            // MyTextFormFieldEntry(
                            //   mController: jumlahObat, //mEmailController,
                            //   mObscureText: false,
                            //   mMaxLine: 1,
                            //   mHintTextColor: textHintColor,
                            //   mTextColor: otherColor,
                            //   mkeyboardType: TextInputType.number,
                            //   mTextInputAction: TextInputAction.next,
                            //   mWidth: 75,
                            //   mHeight: 25,
                            //   //mInputBorder: InputBorder.,
                            // ),
                          ],
                        ),
                      ),
                    ],
                  )))),
    );
  }

  @override
  Widget ListComboItemTindakan() {
    return FutureBuilder<List<AntrianPasienProfile>>(
      //future: _getFirtsInfo,
        builder: (context, _) => Padding(
            padding: EdgeInsets.only(
              top: 10, //ScreenUtil().setHeight(ScreenUtil().setHeight(10)),
              left: 10,
            ), //ScreenUtil().setHeight(ScreenUtil().setWidth(10.0))),
            child: Container(
              height: double.infinity * 0.55,
              width: double.infinity, //  displayWidth(context),
              child: LayoutBuilder(builder: (context, constraints) {
                var parentHeight = constraints.maxHeight;
                var parentWidth = constraints.maxWidth;
                final List<HISSData>? items = listSearchTindakan;
                //AntrianPasienList;
                return Container(
                  child: Padding(
                      padding: const EdgeInsets.only(top: 8.0, bottom: 8),
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(5, 0, 15, 5),
                        //padding: const EdgeInsets.only(top: 5, bottom: 5),
                        child: Container(
                          height: 35,
                          child: DropdownSearch<Map<dynamic, dynamic>?>(
                            selectedItem: _selectedItemUserTindakan,
                            items: dataTindakan,
                            mode: Mode.BOTTOM_SHEET,
                            isFilteredOnline: true,
                            // showClearButton: true,
                            showSearchBox: true,
                            dropdownSearchDecoration:
                            InputDecoration(filled: true, fillColor: white),
                            dropdownBuilder: (context, selectedItem) =>
                                ListTile(
                                  title: Text(selectedItem!["nama_tindakan"] ??
                                      'Belum Pilih Tindakan'),
                                ),
                            popupItemBuilder: (context, item, isSelected) =>
                                ListTile(
                                  title: Text(item!["nama_tindakan"]),
                                ),
                            onChanged: (value) async {
                              _selectedItemUserTindakan = value!;
                            },
                          ),
                        ),
                      )
                    //],
                    //),
                  ),
                );
              }),
            )));
  }

  @override
  Widget ListComboItemObat() {
    return FutureBuilder<List<AntrianPasienProfile>>(
      //future: _getFirtsInfo,
        builder: (context, _) => Padding(
            padding: EdgeInsets.only(
              top: 10, //ScreenUtil().setHeight(ScreenUtil().setHeight(10)),
              left: 10,
            ), //ScreenUtil().setHeight(ScreenUtil().setWidth(10.0))),
            child: Container(
              height: double.infinity * 0.55,
              width: double.infinity, //  displayWidth(context),
              child: LayoutBuilder(builder: (context, constraints) {
                var parentHeight = constraints.maxHeight;
                var parentWidth = constraints.maxWidth;
                final List<HISSData>? items = listSearchObat;
                //AntrianPasienList;
                return Container(
                  child: Padding(
                      padding: const EdgeInsets.only(top: 8.0, bottom: 8),
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(5, 0, 15, 5),
                        //padding: const EdgeInsets.only(top: 5, bottom: 5),
                        child: Container(
                          height: 35,
                          child: DropdownSearch<Map<dynamic, dynamic>?>(
                            selectedItem: _selectedItemUserObat,
                            items: dataObat,
                            mode: Mode.BOTTOM_SHEET,
                            isFilteredOnline: true,
                            //showClearButton: true,
                            showSearchBox: true,
                            dropdownSearchDecoration:
                            InputDecoration(filled: true, fillColor: white),
                            dropdownBuilder: (context, selectedItem) =>
                                ListTile(
                                  title: Text(selectedItem!["nama_obat"] ??
                                      'Belum Pilih Obat'),
                                ),
                            popupItemBuilder: (context, item, isSelected) =>
                                ListTile(
                                  title: Text(item!["nama_obat"]),
                                ),
                            onChanged: (value) async {
                              _selectedItemUserObat = value!;
                            },
                          ),
                        ),
                      )
                    //],
                    //),
                  ),
                );
              }),
            )));
  }
}

class ListItemAdd extends StatelessWidget {
  const ListItemAdd({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TindakanList tablesProvider =
    Provider.of<TindakanList>(context, listen: false);

    List<DataTindakan> itemTindakanObat = tablesProvider.DataTindakanPasien;
    var _scrollControllertrans = ScrollController();

    return Padding(
        padding: const EdgeInsets.all(5.0),
        child: Container(
            height: MediaQuery.of(context).size.height * 0.38, // 125,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              color: white,
              borderRadius: BorderRadius.circular(15),
            ),
            child:
            //TindakanListEntry(_scrollControllertrans, itemTindakanObat),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //Text('Tindakan dan Obat'),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text('Tindakan dan Obat'),
                ),
                SizedBox(
                  height: 5,
                ),
                Expanded(
                  child: TindakanListEntry(
                      _scrollControllertrans, itemTindakanObat),
                )
              ],
            )));
  }

  Widget TindakanListEntry(
      ScrollController controltrans, List<DataTindakan> itemTindakanObat) {
    return Container(
        child: FutureBuilder<List<DataTindakan>>(
          //future: getData(),
            builder: (context, _) => Padding(
                padding: EdgeInsets.only(),
                child: Container(
                  height: displayHeight(context),
                  width: double.infinity, //  displayWidth(context),
                  child: LayoutBuilder(builder: (context, constraints) {
                    var parentHeight = constraints.maxHeight;
                    var parentWidth = constraints.maxWidth;
                    final List<DataTindakan>? items = itemTindakanObat;
                    return Padding(
                      padding: const EdgeInsets.all(3.0),
                      child: Scrollbar(
                        child: ListView.builder(
                          physics:
                          const AlwaysScrollableScrollPhysics(), //Even if zero elements to update scroll
                          itemCount: items!.length,
                          scrollDirection: Axis.vertical,
                          controller: controltrans,
                          itemBuilder: (context, index) {
                            return items[index] == null
                                ? CircularProgressIndicator()
                                : Padding(
                                padding: const EdgeInsets.all(5.0),
                                child:
                                //Text(items[index].keterangan)
                                Column(
                                  children: [
                                    IsiTindakanListEntry(items[index]),
                                  ],
                                ));

                            //: Text(items![index].Subtitle);
                          },
                        ),
                      ),
                    );
                  }),
                ))));
  }

  Widget IsiTindakanListEntry(DataTindakan data) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Column(children: [
        Row(
          mainAxisAlignment:
          MainAxisAlignment.start, //change here don't //worked
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(
                  left: 8.0, top: 8.0, bottom: 8.0, right: 12.0),
              width: 15.0,
              height: 15.0,
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(40.0)),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  data.keterangan,
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 14.0,
                      fontWeight: FontWeight.bold),
                ),
                Text(
                  'Jumlah: ${data.qty}',
                  style: TextStyle(color: Colors.black, fontSize: 14.0),
                )
              ],
            ),
            new Spacer(), // I just added one line
            InkWell(
                borderRadius: BorderRadius.circular(4),
                onTap: () {},
                child: Icon(Icons.delete_forever, color: Colors.black)),

            // This Icon
          ],
        ),
        Padding(
          padding: const EdgeInsets.only(left: 5, right: 5),
          child: Divider(color: Colors.black),
        ),
      ]),
    );
  }
}
