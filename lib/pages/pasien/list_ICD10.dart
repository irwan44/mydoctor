import 'dart:async';
import 'dart:convert';

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
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:doctorapp/pages/pasien/component/itemantrian_pasien.dart';
import 'package:dropdown_search/dropdown_search.dart';
//mport 'package:pluto_grid/pluto_grid.dart';

class ListingICD10Doc extends StatefulWidget {
  const ListingICD10Doc({Key? key}) : super(key: key);

  @override
  State<ListingICD10Doc> createState() => _ListingICD10DocState();
}

class _ListingICD10DocState extends State<ListingICD10Doc> {
  var _scrollControllertrans = ScrollController();
  String _hasBeenPressed = '';
  List<HISSData> KelompokPenyakitList = [];
  List<AntrianPasienProfile> AntrianPasienList = [];
  late List<HISSData> listSearchIsi = [];
  late List<AntrianPasienProfile> listSearchKelompok = [];
  bool searchSts = false;
  late int pilihgroup = 1;
  Map<dynamic, dynamic> _selectedItemUser = {"ID1": "-", "nama_penyakit": "-"};
  List<Map<dynamic, dynamic>> datalist = [];
  PeriksaPasienProfile vitalSignPasien = new PeriksaPasienProfile();
  List<Map<dynamic, dynamic>> dataSoap = [];
  final _formKey = GlobalKey<FormState>();

  TextEditingController HISSPenyakit = TextEditingController();
  TextEditingController HISSSubyektif = TextEditingController();
  TextEditingController HISSObyektif = TextEditingController();
  TextEditingController HISSAnalis = TextEditingController();

  @override
  void initState() {
    _hasBeenPressed = "";
    Provider.of<TindakanList>(context, listen: false).resetItem();
    print('reset');
    super.initState();
    _selectedItemUser = {"ID1": "--", "nama_penyakit": "-"};
    HISSPenyakit.text = "";
    listSearchIsi = [];
  }

  Future<void> _getFirtsInfo() async {
    final AuthPasienData tablesProvider =
        Provider.of<AuthPasienData>(context, listen: false);

    List<AntrianPasienProfile> FirtsInfoPasienList = [];
    AntrianPasienList = tablesProvider.DataAntrian;
    listSearchIsi = [];
  }

  Future<void> _getSearchInfo() async {
    Uri url =
        Uri.parse('${URLS.BASE_URL}/_api_soap/get_nama_penyakit_hiss.php');

    var response = await Dio().get(
      url.toString(),
      queryParameters: {"src_penyakit": _hasBeenPressed},
    );

    _selectedItemUser = {"ID1": "--", "nama_penyakit": "-"};

    final data = response.data;
    //datalist = [];
    setState(() {
      datalist = [];
      pilihgroup = 1;
      HISSPenyakit.text = "";
      HISSSubyektif.text = "";
      HISSObyektif.text = "";
      HISSAnalis.text = "";
      dataSoap = [];
    });

    if (data != null) {
      Map<dynamic, dynamic> map = json.decode(response.data);
      var result = map["list"];

      setState(() {
        datalist = List<Map<dynamic, dynamic>>.from(result).toList();
      });
    }

    if (datalist.length == 0) {
      _selectedItemUser = {"ID1": "0", "nama_penyakit": "tidak ada data"};
    } else {
      _selectedItemUser = {
        "ID1": "1",
        "nama_penyakit": "pilih kelompok penyakit"
      };
    }
    //print('Jumlah nya ' + datalist.length.toString());
  }

  Future<void> _getSearchSOAPInfo(String IDSoap) async {
    print(IDSoap);

    Uri url = Uri.parse('${URLS.BASE_URL}/_api_soap/get_soap_hiss.php');

    var response = await Dio().get(
      url.toString(),
      queryParameters: {"ID": IDSoap},
    );

    final data = response.data;
    List<HISSData> myModels = [];

    if (data != null) {
      Map<String, dynamic> map = json.decode(response.data);
      var result = map["list"];
      setState(() {
        dataSoap = List<Map<dynamic, dynamic>>.from(result).toList();
        HISSPenyakit.text = dataSoap[0]['Nama_Penyakit'];
        HISSSubyektif.text = dataSoap[0]['Penyebab'];
        HISSObyektif.text = dataSoap[0]['GKlinis'];
        HISSAnalis.text = dataSoap[0]['Pengobatan'];
        pilihgroup += 1;
      });

      print(pilihgroup);
    }
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: white, // blue,
      appBar: myAppBar(),
      body: Container(
          width: size.width,
          child: Stack(
            alignment: Alignment.topLeft,
            children: [
              Container(
                child: Padding(
                  padding: const EdgeInsets.only(top: 5),
                  child: Container(
                    child: Padding(
                      //padding: const EdgeInsets.all(5.0),
                      padding: const EdgeInsets.fromLTRB(8, 0, 0, 20),
                      child: Padding(
                        padding: const EdgeInsets.all(18.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Expanded(flex: 8, child: ItemSearch()),
                            Expanded(
                              flex: 1,
                              child: GestureDetector(
                                onTap: () async {
                                  searchSts = true;
                                  await _getSearchInfo();
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(10)
                                  ),
                                  padding: EdgeInsets.all(5),
                                  margin: EdgeInsets.only(top: 10, right: 20),
                                  child: Icon(
                                    Icons.search_sharp,
                                    size: 28,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Container(
                  child: Padding(
                      padding: const EdgeInsets.only(top: 60),
                      child: Container(
                          child: Padding(
                        padding: const EdgeInsets.fromLTRB(8, 0, 0, 20),
                        child: ListComboItemSearch(),
                      )))),
              // Container(
              //     child: Padding(
              //         padding: const EdgeInsets.only(top: 190),
              //         child: Container(
              //             child: Padding(
              //           padding: const EdgeInsets.fromLTRB(8, 0, 0, 10),
              //           child: Form(
              //             key: _formKey,
              //             child: Padding(
              //               padding: EdgeInsets.symmetric(horizontal: 0),
              //               child: Container(
              //                 height: MediaQuery.of(context).size.height,
              //                 child: Column(
              //                   children: [
              //                     Expanded(
              //                         child: Padding(
              //                       //padding: const EdgeInsets.all(8.0),
              //                       padding: const EdgeInsets.only(
              //                           top: 6, left: 5, right: 5, bottom: 15),
              //                       child: Container(
              //                         decoration: BoxDecoration(
              //                           border: Border.all(
              //                             color: Colors
              //                                 .white24, //                   <--- border color
              //                             width: 3.0,
              //                           ),
              //                           color: Colors.white,
              //                           borderRadius: BorderRadius.only(
              //                             topLeft: const Radius.circular(25.0),
              //                             topRight: const Radius.circular(25.0),
              //                           ), // BorderRadius
              //                         ), // BoxDe
              //                         child: Container(
              //                           height:
              //                               MediaQuery.of(context).size.height,
              //                           width:
              //                               MediaQuery.of(context).size.width,
              //                           child: ClipPath(
              //                             clipper: ShapeBorderClipper(
              //                                 shape: RoundedRectangleBorder(
              //                                     borderRadius:
              //                                         BorderRadius.all(
              //                                             Radius.circular(
              //                                                 25)))),
              //                             child: Padding(
              //                               //padding: const EdgeInsets.all(15.0),
              //                               padding: const EdgeInsets.only(
              //                                   left: 5, right: 5),
              //                               child: Container(
              //                                   child: ListView(children: [
              //                                 HISSKelompok(),
              //                                 //
              //                                 Column(
              //                                   children: [
              //                                     const Text('Subyektif',
              //                                         style: TextStyle(
              //                                           fontSize: 14,
              //                                           fontWeight:
              //                                               FontWeight.bold,
              //                                           color: Colors.black,
              //                                           fontFamily:
              //                                               'RobotoMono',
              //                                         )),
              //                                     MyTextFormFieldEntry(
              //                                       mController:
              //                                           HISSSubyektif, //mEmailController,
              //                                       mObscureText: false,
              //                                       mMaxLine: 10,
              //                                       mHintTextColor:
              //                                           textHintColor,
              //                                       mTextColor: otherColor,
              //                                       mkeyboardType:
              //                                           TextInputType.text,
              //                                       mTextInputAction:
              //                                           TextInputAction.next,
              //                                       mWidth: 500,
              //                                       mHeight: 100,
              //                                       //mInputBorder: InputBorder.,
              //                                     ),
              //                                     const Text('Objektif',
              //                                         style: TextStyle(
              //                                           fontSize: 14,
              //                                           fontWeight:
              //                                               FontWeight.bold,
              //                                           color: Colors.black,
              //                                           fontFamily:
              //                                               'RobotoMono',
              //                                         )),
              //                                     MyTextFormFieldEntry(
              //                                       mController:
              //                                           HISSObyektif, //mEmailController,
              //                                       mObscureText: false,
              //                                       mMaxLine: 10,
              //                                       mHintTextColor:
              //                                           textHintColor,
              //                                       mTextColor: otherColor,
              //                                       mkeyboardType:
              //                                           TextInputType.text,
              //                                       mTextInputAction:
              //                                           TextInputAction.next,
              //                                       mWidth: 500,
              //                                       mHeight: 100,
              //                                       //mInputBorder: InputBorder.,
              //                                     ),
              //                                     const Text('Analisys',
              //                                         style: TextStyle(
              //                                           fontSize: 14,
              //                                           fontWeight:
              //                                               FontWeight.bold,
              //                                           color: Colors.black,
              //                                           fontFamily:
              //                                               'RobotoMono',
              //                                         )),
              //                                     MyTextFormFieldEntry(
              //                                       mController:
              //                                           HISSAnalis, //mEmailController,
              //                                       mObscureText: false,
              //                                       mMaxLine: 10,
              //                                       mHintTextColor:
              //                                           textHintColor,
              //                                       mTextColor: otherColor,
              //                                       mkeyboardType:
              //                                           TextInputType.text,
              //                                       mTextInputAction:
              //                                           TextInputAction.next,
              //                                       mWidth: 500,
              //                                       mHeight: 100,
              //                                       //mInputBorder: InputBorder.,
              //                                     ),
              //                                     Container(
              //                                         child: SizedBox(
              //                                       width: 200,
              //                                       height: 40,
              //                                       child: FittedBox(
              //                                           child:
              //                                               FloatingActionButton
              //                                                   .extended(
              //                                         heroTag: 'SOAPSubmit',
              //                                         onPressed: () async {},
              //                                         icon: const Icon(
              //                                             Icons.edit),
              //                                         label:
              //                                             const Text('Submit'),
              //                                         backgroundColor:
              //                                             Colors.redAccent,
              //                                       )),
              //                                     )),
              //                                   ],
              //                                 ),
              //                               ])),
              //                             ),
              //                           ),
              //                         ),
              //                       ),
              //                     ))
              //                   ],
              //                 ),
              //               ),
              //             ),
              //           ),
              //         )))),
            ],
          )),
    );
  }

  @override
  Widget ItemSearch() {
    final _debouncer = WaitingType(milliseconds: 1000);
    return Container(
      decoration: BoxDecoration(
          color: Color.fromARGB(255, 96, 155, 223),
          borderRadius: BorderRadius.circular(100),
          border: Border.all(width: 1.5, color: Color(0xFFE8E8E8))),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(15, 0, 15, 5),
        child: TextFormField(
          textAlign: TextAlign.center,
          style: TextStyle(
              color: Color.fromARGB(255, 19, 1, 1),
              fontSize: 16,
              fontWeight: FontWeight.bold),
          cursorColor: Colors.black,
          decoration: const InputDecoration(
            suffixIcon: Icon(
              Icons.people_rounded,
              color: Color.fromARGB(255, 243, 234, 234),
            ),
            border: InputBorder.none,
            hintText: "Nama Penyakit",
            //filled: true,
            //fillColor: Color.fromARGB(255, 238, 232, 232)
          ),
          onChanged: (data) {
            _hasBeenPressed = data;
            _debouncer.run(() async {
              //Perform your search
              //print('ini yah ' + _hasBeenPressed);
              await _getSearchInfo();
            });
          },
        ),
      ),
    );
  }

  AppBar myAppBar() {
    return AppBar(
      elevation: 0,
      backgroundColor: statusBarColor,
      centerTitle: true,
      flexibleSpace: Container(
        decoration: Utility.toolbarGradientBG(),
      ),
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
        mTitle: 'Form ICD 10',
        mFontSize: 20,
        mFontStyle: FontStyle.normal,
        mFontWeight: FontWeight.normal,
        mTextAlign: TextAlign.center,
        mTextColor: white,
      ),
    );
  }

  @override
  Widget ListComboItemSearch() {
    return FutureBuilder<List<AntrianPasienProfile>>(
        //future: _getFirtsInfo,
        builder: (context, _) => Padding(
            padding: EdgeInsets.only(
              top: 10, //ScreenUtil().setHeight(ScreenUtil().setHeight(10)),
              left: 10,
            ), //ScreenUtil().setHeight(ScreenUtil().setWidth(10.0))),
            child: Container(
              height: double.infinity * 0.1,
              width: double.infinity, //  displayWidth(context),
              child: LayoutBuilder(builder: (context, constraints) {
                var parentHeight = constraints.maxHeight;
                var parentWidth = constraints.maxWidth;
                final List<HISSData>? items = listSearchIsi;
                //AntrianPasienList;
                return Container(
                  child: Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child:
                          // Column(
                          //   children: [
                          //     SizedBox(height: 5),
                          //     Text('Group Kelompok Penyakit'),
                          //     SizedBox(height: 5),

                          Padding(
                        padding: const EdgeInsets.fromLTRB(15, 0, 15, 5),
                        child: Container(
                          height: 35,
                          child: DropdownSearch<Map<dynamic, dynamic>?>(
                            selectedItem: _selectedItemUser,
                            items: datalist,
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
                              title: Text(selectedItem!["nama_penyakit"] ??
                                  'Belum Pilih ID Kelompok'),
                            ),
                            popupItemBuilder: (context, item, isSelected) =>
                                ListTile(
                              title: Text(item!["nama_penyakit"]),
                            ),

                            onChanged: (value) async {
                              _selectedItemUser = value!;
                              //print(value['ID1']);
                              await _getSearchSOAPInfo(
                                  _selectedItemUser["ID1"]);
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

  Widget tabBar() {
    return Container(
      margin: EdgeInsets.only(bottom: 15),
      height: 40,
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color.fromARGB(0, 88, 64, 64),
            Color.fromARGB(0, 247, 243, 243),
            Color.fromARGB(204, 36, 101, 241),
          ],
        ),
      ),
      // color:,
      // borderRadius: BorderRadius.circular(100)),
      child: Row(
        children: [
          // tabBarItem(0),
          // tabBarItem(1),
          // tabBarItem(2),
          // tabBarItem(3),
        ],
      ),
    );
  }

  @override
  Widget IsiKelompokICD10(
      BuildContext context, List<Map<dynamic, dynamic>> item) {
    final String NoKontrak;
    final GestureTapCallback? onTap;

    return Padding(
      padding: const EdgeInsets.all(2.0),
      child: Container(
          height: MediaQuery.of(context).size.height * 0.20, // 125,
          width: MediaQuery.of(context).size.width,
          //child: Text('1'),

          child: ClipRRect(
              borderRadius: BorderRadius.circular(0),
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
                            child: Column(
                              children: [
                                IntrinsicHeight(
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.stretch,
                                    children: [
                                      //signSatu(context)
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            _textWidgeColumn(
                                                title: "Kode ICD-10 .",
                                                value: item.length == 0
                                                    ? ''
                                                    : item[0]['IcdX']),
                                            SizedBox(height: 10),
                                            _textWidgeColumn(
                                                title: "Diagnosa .",
                                                value: item.length == 0
                                                    ? ''
                                                    : item[0]['Diagnosa_Icdx']),
                                            SizedBox(height: 10),
                                            _textWidgeColumn(
                                                title: "Kelompok .",
                                                value: item.length == 0
                                                    ? ''
                                                    : item[0]['kelompok']),
                                            SizedBox(height: 10),
                                            _textWidgeColumn(
                                                title: "Rawa Inap .",
                                                value: item.length == 0
                                                    ? ''
                                                    : item[0]['Lama_Rawat']),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          )),
                    ),
                  ),

                  // Container(
                  //   transform: Matrix4.translationValues(20, -4, 0),
                  //   child: ClipRRect(
                  //     borderRadius: BorderRadius.circular(4.0),
                  //     clipBehavior: Clip.antiAlias,
                  //     child: MyText(
                  //       mTitle: 'Data ICD-10',
                  //       mFontSize: 18,
                  //       mOverflow: TextOverflow.ellipsis,
                  //       mMaxLine: 1,
                  //       mFontWeight: FontWeight.normal,
                  //       mTextAlign: TextAlign.start,
                  //       mTextColor: textTitleColor,
                  //     ),
                  //   ),
                  // ),
                ],
              )))),
    );
  }

  @override
  Widget IsiItemComboGroup(BuildContext context) {
    final String NoKontrak;
    final GestureTapCallback? onTap;

    PeriksaPasienProfile vitalsignDataDef;
    final AuthPasienData tablesProvider =
        Provider.of<AuthPasienData>(context, listen: false);
    vitalsignDataDef = tablesProvider.DataPeriksa;
    print(vitalsignDataDef.nadi);

    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Container(
          height: MediaQuery.of(context).size.height * 0.07, // 125,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            //decoration for the outer wrapper
            color: Color.fromARGB(255, 250, 249, 248),
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: Color.fromARGB(255, 253, 250, 250)
                    .withOpacity(0.5), //color of shadow
                spreadRadius: 2, //spread radius
                blurRadius: 2, // blur radius
                offset: Offset(0, 2), // changes position of shadow
              ),
              //you can set more BoxShadow() here
            ],
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
                          padding: const EdgeInsets.only(top: 20),
                          child: Padding(
                              padding: const EdgeInsets.all(15),
                              child: Container(
                                //height: double.infinity,
                                child: Column(
                                  children: [
                                    IntrinsicHeight(
                                      child: ListComboItemSearch(),
                                    ),
                                  ],
                                ),
                              )),
                        ),
                      ),
                    ),
                  ),
                ],
              )))),
    );
  }

  Widget _textWidgeColumn({String? title, String? value}) {
    return Padding(
      padding: const EdgeInsets.all(0.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Text(title ?? '-',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                  fontFamily: 'RobotoMono',
                )),
          ),
          Flexible(
            child: new Text(value ?? '-',
                textAlign: TextAlign.start,
                //overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.normal,
                  color: Colors.black,
                  fontFamily: 'RobotoMono',
                )),
          )
        ],
      ),
    );
  }

  Widget SOAPSubyektif(PeriksaPasienProfile item) {
    final String NoKontrak;
    final GestureTapCallback? onTap;

    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Container(
          height: MediaQuery.of(context).size.height * 0.15, // 125,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            //decoration for the outer wrapper
            color: Color.fromARGB(255, 250, 249, 248),
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: Color.fromARGB(255, 253, 250, 250)
                    .withOpacity(0.5), //color of shadow
                spreadRadius: 2, //spread radius
                blurRadius: 2, // blur radius
                offset: Offset(0, 2), // changes position of shadow
              ),
              //you can set more BoxShadow() here
            ],
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
                          padding: const EdgeInsets.only(top: 20),
                          child: Padding(
                              padding: const EdgeInsets.all(15),
                              child: Container(
                                  //height: double.infinity,
                                  //     child: IsiSUbyektif(
                                  //   newsPost: item,
                                  // )

                                  )),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    transform: Matrix4.translationValues(20, -4, 0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(4.0),
                      clipBehavior: Clip.antiAlias,
                      child: MyText(
                        mTitle: 'Subyektif',
                        mFontSize: 18,
                        mOverflow: TextOverflow.ellipsis,
                        mMaxLine: 1,
                        mFontWeight: FontWeight.normal,
                        mTextAlign: TextAlign.start,
                        mTextColor: textTitleColor,
                      ),
                    ),
                  ),
                ],
              )))),
    );
  }

  Widget SOAPObjektif(PeriksaPasienProfile item) {
    final String NoKontrak;
    final GestureTapCallback? onTap;

    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Container(
          height: MediaQuery.of(context).size.height * 0.15, // 125,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            //decoration for the outer wrapper
            color: Color.fromARGB(255, 250, 249, 248),
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: Color.fromARGB(255, 253, 250, 250)
                    .withOpacity(0.5), //color of shadow
                spreadRadius: 2, //spread radius
                blurRadius: 2, // blur radius
                offset: Offset(0, 2), // changes position of shadow
              ),
              //you can set more BoxShadow() here
            ],
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
                          padding: const EdgeInsets.only(top: 20),
                          child: Padding(
                              padding: const EdgeInsets.all(15),
                              child: Container(
                                  //height: double.infinity,
                                  //child: Text('2')
                                  //     IsiObjective(
                                  //   newsPost: item,
                                  // )
                                  )),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    transform: Matrix4.translationValues(20, -4, 0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(4.0),
                      clipBehavior: Clip.antiAlias,
                      child: MyText(
                        mTitle: 'Objective',
                        mFontSize: 18,
                        mOverflow: TextOverflow.ellipsis,
                        mMaxLine: 1,
                        mFontWeight: FontWeight.normal,
                        mTextAlign: TextAlign.start,
                        mTextColor: textTitleColor,
                      ),
                    ),
                  ),
                ],
              )))),
    );
  }

  Widget SOAPAssestment(PeriksaPasienProfile item) {
    final String NoKontrak;
    final GestureTapCallback? onTap;

    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Container(
          height: MediaQuery.of(context).size.height * 0.15, // 125,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            //decoration for the outer wrapper
            color: Color.fromARGB(255, 250, 249, 248),
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: Color.fromARGB(255, 253, 250, 250)
                    .withOpacity(0.5), //color of shadow
                spreadRadius: 2, //spread radius
                blurRadius: 2, // blur radius
                offset: Offset(0, 2), // changes position of shadow
              ),
              //you can set more BoxShadow() here
            ],
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
                          padding: const EdgeInsets.only(top: 20),
                          child: Padding(
                              padding: const EdgeInsets.all(15),
                              child: Container(
                                  //height: double.infinity,
                                  //child: Text('3')
                                  )),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    transform: Matrix4.translationValues(20, -4, 0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(4.0),
                      clipBehavior: Clip.antiAlias,
                      child: MyText(
                        mTitle: 'Analisys',
                        mFontSize: 18,
                        mOverflow: TextOverflow.ellipsis,
                        mMaxLine: 1,
                        mFontWeight: FontWeight.normal,
                        mTextAlign: TextAlign.start,
                        mTextColor: textTitleColor,
                      ),
                    ),
                  ),
                ],
              )))),
    );
  }

  Widget HISSKelompok() {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Container(
          height: MediaQuery.of(context).size.height * 0.25, // 125,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            //decoration for the outer wrapper
            color: Color.fromARGB(255, 250, 249, 248),
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: Color.fromARGB(255, 253, 250, 250)
                    .withOpacity(0.5), //color of shadow
                spreadRadius: 2, //spread radius
                blurRadius: 2, // blur radius
                offset: Offset(0, 2), // changes position of shadow
              ),
            ],
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
                              padding: const EdgeInsets.all(8),
                              child: Container(
                                //height: double.infinity,
                                child: Column(
                                  children: [
                                    if (pilihgroup == 1) ...[
                                      IsiKelompokICD10(context, dataSoap),
                                    ] //icdx
                                    else if (pilihgroup == 2) ...[
                                      TextIsi()
                                    ] //gejala
                                    else if (pilihgroup == 3) ...[
                                      TextIsi()
                                    ] //penyebab
                                    else if (pilihgroup == 4) ...[
                                      TextIsi()
                                    ] //penunjang
                                    else if (pilihgroup == 5) ...[
                                      TextIsi()
                                    ] //pengobatan
                                    else if (pilihgroup == 6) ...[
                                      TextIsi()
                                    ] //Komplikasi
                                    else if (pilihgroup == 7) ...[
                                      TextIsi()
                                    ] //Diferensial
                                    else if (pilihgroup == 8) ...[
                                      TextIsi()
                                    ] //Catatan
                                    else if (pilihgroup == 9) ...[
                                      TextIsi()
                                    ] //PreExisting
                                  ],
                                ),
                              )),
                        ),
                      ),
                    ),
                  ),
                ],
              )))),
    );
  }

  Widget TextIsi() {
    return Container(
      child: Text(HISSModul[pilihgroup].toString()),
    );
  }
}

class IsiInfoSearchandFilter extends StatelessWidget {
  final AntrianPasienProfile infoIsi;
  final Widget? prefWidget;
  final VoidCallback action;
  const IsiInfoSearchandFilter(
      {Key? key, required this.infoIsi, required this.action, this.prefWidget})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    String urlfoto = infoIsi.url_foto_px;
    urlfoto = urlfoto.replaceAll('..', '');

    return InkWell(
        onTap: () => action(),
        child: Container(
            height: 100,
            width: 390,
            child: IntrinsicHeight(
                child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(0),
                    ),
                    shadowColor: Color.fromARGB(255, 198, 240, 11),
                    elevation: 4,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(children: <Widget>[
                        Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                  flex: 2,
                                  child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(6),
                                          child: FadeInImage.assetNetwork(
                                            placeholder:
                                                'assets/images/avatar.png',
                                            image:
                                                urlfoto, //infoIsi.url_foto_px,
                                            fit: BoxFit.cover,
                                            width: 120,
                                            height: 60,
                                            imageErrorBuilder:
                                                (context, url, error) =>
                                                    Icon(Icons.error),
                                          ),
                                        ),
                                      ])),
                              SizedBox(
                                width: 20,
                              ),
                              Expanded(
                                  flex: 8,
                                  child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(infoIsi.nama_px,
                                            style: GoogleFonts.poppins(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w800)),
                                        new SizedBox(
                                          height: 4,
                                          child: new Center(
                                            child: new Container(
                                              margin: new EdgeInsetsDirectional
                                                  .only(start: 1.0, end: 1.0),
                                              height: 2.0,
                                              color: const Color.fromARGB(
                                                  255, 241, 187, 183),
                                            ),
                                          ),
                                        ),
                                        SizedBox(height: 5),
                                        Text(
                                            ' No Antrian ' + infoIsi.no_antrian,
                                            style: GoogleFonts.poppins(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w600)),
                                        SizedBox(height: 2),
                                        Text(
                                            ' Pendafatran ' +
                                                infoIsi.jam_daftar,
                                            style: GoogleFonts.poppins(
                                                fontSize: 12,
                                                fontWeight: FontWeight.w400)),
                                      ]))
                            ])
                      ]),
                    )))));
  }
}

class WaitingType {
  final int? milliseconds;
  VoidCallback? action;
  Timer? _timer;

  WaitingType({
    this.milliseconds = 0,
  });

  run(VoidCallback action) {
    if (null != _timer) {
      _timer?.cancel();
    }
    _timer = Timer(Duration(milliseconds: milliseconds!), action);
  }
}
