import 'dart:async';
import 'dart:convert';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:dio/dio.dart';
import 'package:doctorapp/apiservice/serviceapi.dart';
import 'package:doctorapp/model/hissmodel.dart';
import 'package:doctorapp/model/periksamodel.dart';
import 'package:doctorapp/model/usermodel.dart';
import 'package:doctorapp/pages/itemantrian.dart';
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
import 'package:flutter_icons_null_safety/flutter_icons_null_safety.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:doctorapp/pages/pasien/component/itemantrian_pasien.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:http/http.dart' as http;

class ICD10Dokter extends StatefulWidget {
  const ICD10Dokter({Key? key}) : super(key: key);

  @override
  State<ICD10Dokter> createState() => _ICD10DokterState();
}

class _ICD10DokterState extends State<ICD10Dokter> {
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
  DataICD10 isiItemICD = new DataICD10();

  TextEditingController jumlahTindakan = TextEditingController();
  TextEditingController jumlahObat = TextEditingController();
  String _hasBeenPressed = '';
  late FocusNode myFocusNode;
  bool typesearch = false;
  Map<dynamic, dynamic> _selectedItemUser = {"icd_10": "-", "nama_icd": "-"};
  List<Map<dynamic, dynamic>> datalist = [];
  List<Map<dynamic, dynamic>> dataSoap = [];
  late List<HISSData> listSearchIsi = [];
  Map<dynamic, dynamic> _selectedICD10 = {"icd_10x": "-", "nama_icdx": "-"};
  Map<dynamic, dynamic> _selectedICD10Astr = {"ID1": "-", "nama_penyakit": "-"};
  late List<DataICD10> listSearchIsiICD10 = [];
  late List<HISSData> listSearchIsiICD10Astr = [];
  List<Map<dynamic, dynamic>> datalistIcd = [];
  List<Map<dynamic, dynamic>> datalistIcdAst = [];

  List _getAsterix = [];

  @override
  void initState() {
    super.initState();
    Provider.of<TindakanList>(context, listen: false).resetItem();
    EasyLoading.addStatusCallback(statusCallback);
    myFocusNode = FocusNode();
  }

  @override
  void deactivate() {
    EasyLoading.dismiss();
    EasyLoading.removeCallback(statusCallback);
    super.deactivate();
  }

  void statusCallback(EasyLoadingStatus status) {
    print('Test EasyLoading Status $status');
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    Future<bool> _AddTindakanObat() async {
      AntrianPasienProfile pasien =
          Provider.of<AuthPasienData>(context, listen: false).DataPeriksaProfile;

      bool okeh = false;
      Map dataentry = {
        "no_mr": pasien.no_mr,
        "no_registrasi": pasien.no_registrasi
      };

      Uri? url = Uri.parse('${URLS.BASE_URL}/_api_soap/get_hasil_icd10_px.php');

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
    return Scaffold(
        resizeToAvoidBottomInset: true, // blue,
        body: Container(
            width: size.width,
            child: Stack(
              alignment: Alignment.topLeft,
              children: [
                profile(),
                Container(
                    child: Padding(
                        padding: const EdgeInsets.only(
                          top: 170,
                        ),
                        child: Container(
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(5, 40, 0, 5),
                              child: Form(
                                key: _formKey,
                                child:
                                ListView(padding: EdgeInsets.all(2), children: <
                                    Widget>[
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: ItemSearch(),
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Container(
                                        decoration: BoxDecoration(
                                          color: white,
                                          borderRadius: BorderRadius.circular(15),

                                        ),
                                        height: 235,
                                        child: Column(
                                          crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                          children: [
                                            Expanded(
                                                child: ListComboItemKelompok()),
                                            Expanded(child: ListComboItemICD()),
                                          ],
                                        )),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: ElevatedButton(
                                        child: Text('Submit'),
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
                                            BorderRadius.circular(10.0),
                                          ),
                                          primary:
                                          const Color.fromRGBO(38, 153, 249, 1),
                                          onPrimary: white,
                                          textStyle: const TextStyle(
                                              fontSize: 17,
                                              fontWeight: FontWeight.w700,
                                              color: black),
                                        )),
                                  ),
                                  ListItemAdd()
                                ]),
                              ),
                            )))),
              ],
            )),
      );
  }

  Future postData() async {
    //Change values on setState
    await new Future.delayed(const Duration(seconds: 3));
    setState(() {
      var progress = false;
      isiItem.type = pilTindakan == 1
          ? _selectedItemUserTindakan['no_mr']
          : _selectedItemUserObat['no_registrasi'];
    });

    print(isiItem);
  }

  @override
  Widget ItemSearch() {
    final _debouncer = WaitingType(milliseconds: 1000);

    return Container(
      decoration: BoxDecoration(
        color: white,
        borderRadius: BorderRadius.circular(15),

      ),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
        child: TextFormField(
          maxLines: 1,
          textAlign: TextAlign.start,
          textInputAction: TextInputAction.next,
          style: TextStyle(
              color: Color.fromARGB(255, 19, 1, 1),
              fontSize: 16,
              fontWeight: FontWeight.bold),
          cursorColor: Colors.black,
          decoration: const InputDecoration(
            contentPadding: EdgeInsets.fromLTRB(10, 14, 10, 0),
            suffixIcon: Icon(
              Icons.search,
              color: Color.fromARGB(255, 12, 11, 11),
            ),
            border: InputBorder.none,
            hintText: "Nama Penyakit",
            //filled: true,
            //fillColor: Color.fromARGB(255, 238, 232, 232)
          ),
          onChanged: (data) {
            _hasBeenPressed = data;
            typesearch = true;
            _debouncer.run(() async {
              if (typesearch == true) {
                await _getSearchInfo();
                FocusScope.of(context).nextFocus();
              }
              typesearch = false;
            });
          },
        ),
      ),
    );
  }
  @override
  Widget ListComboItemICD() {
    return FutureBuilder<List<AntrianPasienProfile>>(
        builder: (context, _) => Container(
          height: double.infinity,
          width: double.infinity, //  displayWidth(context),
          child: LayoutBuilder(builder: (context, constraints) {
            var parentHeight = constraints.maxHeight;
            var parentWidth = constraints.maxWidth;
            final List<DataICD10>? items = listSearchIsiICD10;
            //AntrianPasienList;
            return Container(
              child: Padding(
                  padding:
                  const EdgeInsets.only(top: 2.0, bottom: 1, right: 1),
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(10, 0, 5, 0),
                    //padding: const EdgeInsets.only(top: 5, bottom: 5),
                    child: Container(
                      height: 30,
                      child: DropdownSearch<Map<dynamic, dynamic>?>(
                        selectedItem: _selectedItemUser,
                        items: datalist,
                        mode: Mode.BOTTOM_SHEET,
                        isFilteredOnline: true,
                        // showClearButton: true,
                        showSearchBox: true,
                        dropdownSearchDecoration: InputDecoration(
                            labelText: "Asterix",
                            filled: true,
                            fillColor: white),
                        dropdownBuilder: (context, selectedItem) =>
                            ListTile(
                              title: Text(selectedItem!["nama_icdx"] ??
                                  'Belum Pilih ICD-10'),
                            ),
                        popupItemBuilder: (context, item, isSelected) =>
                            ListTile(
                              title: Text(
                                item!["nama_icdx"],
                                style: GoogleFonts.roboto(fontSize: 16),
                              ),
                            ),

                        onChanged: (value) async {
                          _selectedICD10 = value!;

                          // await _getSearchSOAPInfo(
                          //     _selectedItemUser["ID1"]);
                        },
                      ),
                    ),
                  )
                //],
                //),
              ),
            );
          }),
          //)
        ));
  }
  @override
  Widget ListComboItemKelompok() {
    return FutureBuilder<List<AntrianPasienProfile>>(
      //future: _getFirtsInfo,
        builder: (context, _) => Container(
          height: double.infinity,
          width: double.infinity, //  displayWidth(context),
          child: LayoutBuilder(builder: (context, constraints) {
            var parentHeight = constraints.maxHeight;
            var parentWidth = constraints.maxWidth;
            final List<HISSData>? items = listSearchIsi;
            //AntrianPasienList;
            return Container(
              child: Padding(
                  padding:
                  const EdgeInsets.only(top: 1.0, bottom: 1, right: 1, left: 10),
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(0, 0, 5, 0),
                    //padding: const EdgeInsets.only(top: 5, bottom: 5),
                    child: Container(
                      height: 35,
                      child: DropdownSearch<Map<dynamic, dynamic>?>(
                        selectedItem: _selectedItemUser,
                        items: datalist,
                        mode: Mode.BOTTOM_SHEET,
                        isFilteredOnline: true,
                        //showClearButton: true,
                        showSearchBox: true,
                        dropdownSearchDecoration: const InputDecoration(
                            labelStyle: TextStyle(fontSize: 14.0),
                            labelText: "Kelompok Penyakit",
                            floatingLabelStyle: TextStyle(fontSize: 14.0),
                            filled: true,
                            fillColor: white),
                        dropdownSearchBaseStyle: TextStyle(fontSize: 16.0),
                        dropdownBuilder: (context, selectedItem) =>
                            ListTile(
                              title: Text(
                                selectedItem!["nama_icd"] ??
                                    'Belum Pilih ICD -10',
                                style: GoogleFonts.roboto(fontSize: 16),
                              ),
                            ),
                        popupItemBuilder: (context, item, isSelected) =>
                            ListTile(
                              title: Text(
                                item!["nama_icd"],
                                style: TextStyle(fontSize: 16),
                              ),
                            ),

                        onChanged: (value) async {
                          _selectedItemUser = value!;
                          _getfillICD10();
                        },
                      ),
                    ),
                  )
                //],
                //),
              ),
            );
          }),
        )
      //)
    );
  }

  @override
  Widget ListComboItemKelompokSimple() {
    return FutureBuilder<List<AntrianPasienProfile>>(
        builder: (context, _) => Container(
          height: double.infinity,
          width: double.infinity, //  displayWidth(context),
          child: LayoutBuilder(builder: (context, constraints) {
            var parentHeight = constraints.maxHeight;
            var parentWidth = constraints.maxWidth;
            final List<HISSData>? items = listSearchIsi;
            //AntrianPasienList;
            return Container(
              child: Padding(
                  padding:
                  const EdgeInsets.only(top: 1.0, bottom: 1, right: 1),
                  child: Padding(
                      padding: const EdgeInsets.fromLTRB(0, 0, 5, 0),
                      //padding: const EdgeInsets.only(top: 5, bottom: 5),
                      child: Container(
                        height: 35,
                        child: DropdownSearch<Map<dynamic, dynamic>?>(
                          selectedItem: _selectedICD10,
                          items: datalistIcd,
                          mode: Mode.BOTTOM_SHEET,
                          isFilteredOnline: true,
                          //showClearButton: true,
                          showSearchBox: true,
                          dropdownSearchDecoration: const InputDecoration(
                              labelStyle: TextStyle(fontSize: 14.0),
                              labelText: "Kelompok Penyakit",
                              floatingLabelStyle: TextStyle(fontSize: 14.0),
                              filled: true,
                              fillColor: Colors.black),
                          dropdownSearchBaseStyle:
                          TextStyle(fontSize: 16.0),
                          dropdownBuilder: (context, selectedItem) =>
                              ListTile(
                                title: Text(
                                  selectedItem!["nama_penyakit"] ??
                                      'Belum Pilih ID Kelompok',
                                  style: GoogleFonts.roboto(fontSize: 16),
                                ),
                              ),
                          popupItemBuilder: (context, item, isSelected) =>
                              ListTile(
                                title: Text(
                                  item!["nama_penyakit"],
                                  style: TextStyle(fontSize: 16),
                                ),
                              ),

                          onChanged: (value) async {
                            _selectedICD10 = value!;


                            // await _getSearchSOAPInfo(
                            //     _selectedItemUser["ID1"]);
                          },
                        ),

                        //     DropdownSearch<dynamic>(
                        //   dropdownSearchDecoration: InputDecoration(
                        //     labelText: "Provinsi",
                        //     hintText: "Pilih Provinsi",
                        //   ),

                        //   //have two mode: menu mode and dialog mode
                        //   mode: Mode.DIALOG,
                        //   //if you want show search box
                        //   showSearchBox: true,

                        //   onFind: (text) async {
                        //     var response = await http.get(Uri.parse(
                        //         "https://dev.farizdotid.com/api/daerahindonesia/provinsi"));

                        //     if (response.statusCode == 200) {
                        //       final data = jsonDecode(response.body);

                        //       setState(() {
                        //         _getKelompok = data['provinsi'];
                        //       });
                        //     }

                        //     return _getKelompok as List<dynamic>;
                        //   },
                        // )),
                      ))),
            );
          }),
        )
      //)
    );
  }



  @override
  Widget ListComboItemICDAsterik() {
    return FutureBuilder<List<AntrianPasienProfile>>(
      //future: _getFirtsInfo,
        builder: (context, _) =>
        // Padding(
        //     padding: EdgeInsets.only(
        //       top: 5, //ScreenUtil().setHeight(ScreenUtil().setHeight(10)),
        //       left: 5,
        //     ), //ScreenUtil().setHeight(ScreenUtil().setWidth(10.0))),
        //child:
        Container(
          height: double.infinity,
          width: double.infinity, //  displayWidth(context),
          child: LayoutBuilder(builder: (context, constraints) {
            var parentHeight = constraints.maxHeight;
            var parentWidth = constraints.maxWidth;
            final List<HISSData>? items = listSearchIsiICD10Astr;
            //AntrianPasienList;
            return Container(
              child: Padding(
                  padding:
                  const EdgeInsets.only(top: 2.0, bottom: 0, right: 5 ),
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(10, 0, 5, 0),
                    //padding: const EdgeInsets.only(top: 5, bottom: 5),
                    child: Container(
                      height: 35,
                      child: DropdownSearch<Map<dynamic, dynamic>?>(
                        selectedItem: _selectedICD10Astr,
                        items: datalistIcdAst,
                        mode: Mode.BOTTOM_SHEET,
                        isFilteredOnline: true,
                        //showClearButton: true,
                        showSearchBox: true,
                        dropdownSearchDecoration: InputDecoration(
                            labelText: "Asterikx",
                            filled: true,
                            fillColor: white),
                        dropdownBuilder: (context, selectedItem) =>
                            ListTile(
                              title: Text(selectedItem!["nama_penyakit"] ??
                                  'Belum Pilih Asterik'),
                            ),
                        popupItemBuilder: (context, item, isSelected) =>
                            ListTile(
                              title: Text(
                                item!["nama_penyakit"],
                                style: GoogleFonts.roboto(fontSize: 16),
                              ),
                            ),

                        onChanged: (value) async {
                          _selectedItemUser = value!;

                          // await _getSearchSOAPInfo(
                          //     _selectedItemUser["ID1"]);
                        },
                      ),
                    ),
                  )
                //],
                //),
              ),
            );
          }),
          //)
        ));
  }

  Future<void> _getfillICD10() async {
    try {
      await EasyLoading.show(status: 'ISI data');

      setState(() {
        listSearchIsiICD10 = [];
        datalistIcd = [];
        _selectedICD10 = _selectedItemUser;
        _selectedICD10['nama_icdx'] =
            _selectedItemUser['icd_10'] + ',' + _selectedItemUser['nama_icd'];
        print(_selectedICD10);
        print(_selectedItemUser);
        _selectedICD10 = _selectedItemUser;
        DataICD10 isi = new DataICD10(
            idCD10: _selectedItemUser['icd_10'],
            idCD10Ket: _selectedItemUser['icd_10'] +
                ' ,' +
                _selectedItemUser['nama_icd']);
        print(_selectedItemUser);
        listSearchIsiICD10.add(isi);
        datalistIcd =
            List<Map<dynamic, dynamic>>.from(listSearchIsiICD10).toList();
      });

      print('icd10 ' + datalistIcd.length.toString());
    } catch (error) {
      await EasyLoading.dismiss();

      return;
      //throw error;
    } finally {
      await EasyLoading.dismiss();
    }
  }

  Future<void> _getSearchInfo() async {
    Uri url = Uri.parse('${URLS.BASE_URL}/_api_soap/get_icd10_px.php');

    try {
      await EasyLoading.show(status: 'search data');

      var response = await Dio().get(url.toString(),
          queryParameters: {"act": "get_icd10", "src_icd": _hasBeenPressed});

      _selectedItemUser = {"icd_10": "--", "nama_icd": "-"};

      final data = response.data;
      //datalist = [];
      setState(() {
        datalist = [];
        dataSoap = [];
      });

      if (data != null) {
        Map<dynamic, dynamic> map = json.decode(response.data);
        var result = map["nama_icd10"];

        setState(() {
          datalist = List<Map<dynamic, dynamic>>.from(result).toList();
        });
      }

      if (datalist.length == 0) {
        _selectedItemUser = {"icd_10": "0", "nama_icd": "tidak ada data"};
      } else {
        _selectedItemUser = {
          "icd_10": "1",
          "nama_icd": "pilih kelompok penyakit"
        };
      }
    } catch (error) {
      await EasyLoading.dismiss();

      return;
      //throw error;
    } finally {
      await EasyLoading.dismiss();
    }

    print('Jumlah nya ' + datalist.length.toString());
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
              height: 200,
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
                              padding: const EdgeInsets.only(top: 44.0),
                              height: displayHeight(context) * .55, // 125,
                              width: displayWidth(context),
                              child: Column(
                                children: [
                                  Row(
                                    children: <Widget>[
                                      Container(
                                        width: 68,
                                        child: IconButton(
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
                                      ),
                                      Expanded(
                                        child: Align(
                                            alignment: Alignment.center,
                                            child: Padding(
                                              padding: const EdgeInsets.only(right: 50.0),
                                              child: MyText(
                                                mTitle: 'Isi ICD-10',
                                                mFontSize: 20,
                                                mFontStyle: FontStyle.normal,
                                                mFontWeight: FontWeight.normal,
                                                mTextAlign: TextAlign.center,
                                                mTextColor: white,
                                              ),
                                            )),
                                      ),
                                    ],
                                  ),
                                  Container(
                                      decoration: const BoxDecoration(
                                        color: Color.fromARGB(255, 35, 163, 223),
                                        borderRadius: BorderRadius.only(
                                            bottomLeft: Radius.circular(10),
                                            bottomRight: Radius.circular(10)),
                                        image: DecorationImage(
                                            image: AssetImage('assets/images/Design1.png'),
                                            fit: BoxFit.cover),
                                      ),
                                      width: displayWidth(context),
                                      height: 230,
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
      padding: const EdgeInsets.all(10),
      child: Container(
          height: MediaQuery.of(context).size.height * 0.10, // 125,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            //decoration for the outer wrapper
            color: Color.fromARGB(255, 250, 249, 248),
            borderRadius: BorderRadius.circular(10),

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
                        child: Padding(
                          padding: const EdgeInsets.all(0.0),
                          child: Card(
                            clipBehavior: Clip.antiAlias,
                            elevation: 3,
                            color: white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: Container(
                              padding: const EdgeInsets.only(top: 5),
                              child: Padding(
                                  padding: const EdgeInsets.all(10),
                                  child: Container(
                                    //height: double.infinity,
                                      child: Padding(
                                        padding: const EdgeInsets.all(0.0),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          mainAxisSize: MainAxisSize.max,
                                          children: [
                                            ElevatedButtonTheme(
                                              data: ElevatedButtonThemeData(
                                                  style: ElevatedButton.styleFrom(
                                                      minimumSize: Size(160, 60))),
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
                                                            ? Color.fromRGBO(
                                                            38, 153, 249, 1)
                                                            : white,
                                                        onPrimary: pilTindakan == 1
                                                            ? white
                                                            : black,
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
                                                        primary: pilTindakan == 2
                                                            ? Color.fromRGBO(
                                                            38, 153, 249, 1)
                                                            : white,
                                                        onPrimary: pilTindakan == 2
                                                            ? white
                                                            : black,
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
                                      ))),
                            ),
                          ),
                        ),
                      ),
                    ],
                  )))),
    );
  }

  @override
  Widget IsiTindakan(BuildContext context, List<Map<dynamic, dynamic>> item) {
    final String NoKontrak;
    final GestureTapCallback? onTap;

    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Container(
          height: MediaQuery.of(context).size.height * 0.22, // 125,
          width: MediaQuery.of(context).size.width,
          child: ClipRRect(
              borderRadius: BorderRadius.circular(0),
              child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: blue, //                   <--- border color
                      width: 3.0,
                    ),
                  ),
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
                            Padding(
                              padding: const EdgeInsets.all(20.0),
                              child: const Text('Jumlah',
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                    fontFamily: 'RobotoMono',
                                  )),
                            ),
                            MyTextFormFieldEntry(
                              mController: jumlahTindakan, //mEmailController,
                              mObscureText: false,
                              mMaxLine: 1,
                              mHintTextColor: textHintColor,
                              mTextColor: otherColor,
                              mkeyboardType: TextInputType.number,
                              mTextInputAction: TextInputAction.next,
                              mWidth: 75,
                              mHeight: 25,
                              //mInputBorder: InputBorder.,
                            ),
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
          child: ClipRRect(
              borderRadius: BorderRadius.circular(0),
              child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: blue, //                   <--- border color
                      width: 3.0,
                    ),
                  ),
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
                            Padding(
                              padding: const EdgeInsets.all(20.0),
                              child: const Text('Jumlah',
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                    fontFamily: 'RobotoMono',
                                  )),
                            ),
                            MyTextFormFieldEntry(
                              mController: jumlahObat, //mEmailController,
                              mObscureText: false,
                              mMaxLine: 1,
                              mHintTextColor: textHintColor,
                              mTextColor: otherColor,
                              mkeyboardType: TextInputType.number,
                              mTextInputAction: TextInputAction.next,
                              mWidth: 75,
                              mHeight: 25,
                              //mInputBorder: InputBorder.,
                            ),
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
                            mode: Mode.DIALOG,
                            isFilteredOnline: true,
                            //showClearButton: true,
                            showSearchBox: true,
                            dropdownSearchDecoration: InputDecoration(
                                filled: true,
                                fillColor: Theme.of(context)
                                    .inputDecorationTheme
                                    .fillColor),
                            dropdownBuilder: (context, selectedItem) =>
                                ListTile(
                                  title: Text(selectedItem!["nama_icd"] ??
                                      'Belum Pilih ICD-10'),
                                ),
                            popupItemBuilder: (context, item, isSelected) =>
                                ListTile(
                                  title: Text(item!["nama_icd"]),
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
                            mode: Mode.DIALOG,
                            isFilteredOnline: true,
                            //showClearButton: true,
                            showSearchBox: true,
                            dropdownSearchDecoration: InputDecoration(
                                filled: true,
                                fillColor: Theme.of(context)
                                    .inputDecorationTheme
                                    .fillColor),
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
            height: MediaQuery.of(context).size.height * 0.22, // 125,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              color: white,
              borderRadius: BorderRadius.circular(15),

            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //Text('Tindakan dan Obat'),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text('List ICD-10'),
                ),
                SizedBox(
                  height: 5,
                ),
                Expanded(
                  child: TindakanListEntry(
                      _scrollControllertrans, itemTindakanObat),
                )
              ],
            )
          //TindakanListEntry(_scrollControllertrans, itemTindakanObat),
        ));

    // return Container(
    //     child: FutureBuilder<List<DataTindakan>>(
    //         //future: getData(),
    //         builder: (context, _) => Padding(
    //             padding: EdgeInsets.only(),
    //             child: Container(
    //               height: displayHeight(context),
    //               width: double.infinity, //  displayWidth(context),
    //               child: LayoutBuilder(builder: (context, constraints) {
    //                 var parentHeight = constraints.maxHeight;
    //                 var parentWidth = constraints.maxWidth;
    //                 final List<DataTindakan>? items = itemTindakanObat;
    //                 return Padding(
    //                   padding: const EdgeInsets.all(3.0),
    //                   child: Scrollbar(
    //                     child: ListView.builder(
    //                       physics:
    //                           const AlwaysScrollableScrollPhysics(), //Even if zero elements to update scroll
    //                       itemCount: items!.length,
    //                       scrollDirection: Axis.vertical,
    //                       controller: _scrollControllertrans,
    //                       itemBuilder: (context, index) {
    //                         return items[index] == null
    //                             ? CircularProgressIndicator()
    //                             : Padding(
    //                                 padding: const EdgeInsets.all(5.0),
    //                                 child: Text(items[index].keterangan));

    //                         //: Text(items![index].Subtitle);
    //                       },
    //                     ),
    //                   ),
    //                 );
    //               }),
    //             )))
    //     // body: Container(
    //     //     child: SingleChildScrollView(
    //     //         scrollDirection: Axis.vertical,
    //     //         child: Container(
    //     //           child: Column(
    //     //               mainAxisAlignment: MainAxisAlignment.start,
    //     //               children: [
    //     //                 ...Iterable<int>.generate(itemTindakanObat.length)
    //     //                     .map((int pageIndex) =>
    //     //                     Container(
    //     //                       child: LayoutBuilder(builder: (context, constraints) {},
    //     //                     )
    //     //               ]),
    //     //         ))),
    //     );
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
                  left: 8.0, top: 0.0, bottom: 8.0, right: 12.0),
              width: 15.0,
              height: 15.0,
              decoration: BoxDecoration(
                  color: Colors.red, borderRadius: BorderRadius.circular(40.0)),
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
                  'TANGGAL:' +  data.tanggal,
                  style: TextStyle(color: Colors.black, fontSize: 14.0),
                ),
                Text(
                  'KELOMPOK ICD-10:' +  data.keterangan,
                  style: TextStyle(color: Colors.black, fontSize: 14.0),
                ),
                Text(
                  'NAMA KELOMPOK:' +  data.keterangan,
                  style: TextStyle(color: Colors.black, fontSize: 14.0),
                ),
                Text(
                  'KODE ICD-10:' +  data.keterangan,
                  style: TextStyle(color: Colors.black, fontSize: 14.0),
                ),
                Text(
                  'NAMA ICD-10:' +  data.keterangan,
                  style: TextStyle(color: Colors.black, fontSize: 14.0),
                ),
                Text(
                  'KODE ASTERIK:' +  data.keterangan,
                  style: TextStyle(color: Colors.black, fontSize: 14.0),
                ),
                Text(
                  'NAMA ASTERIK:' +  data.keterangan,
                  style: TextStyle(color: Colors.black, fontSize: 14.0),
                ),

              ],
            ),

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
