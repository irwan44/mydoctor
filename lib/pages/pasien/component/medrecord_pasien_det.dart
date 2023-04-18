import 'dart:developer';

//import 'package:circular_bottom_navigation/circular_bottom_navigation.dart';
import 'package:doctorapp/apiservice/serviceapi.dart';
import 'package:doctorapp/pages/pasien/component/medrecord_pasien.dart';
import 'package:doctorapp/pages/pasien/list_ICD10.dart';
import 'package:doctorapp/pages/pasien/list_hiss.dart';

import 'package:doctorapp/pages/pasien/list_tindakan_obat.dart';
import 'package:doctorapp/pages/pemeriksaan.dart';
import 'package:doctorapp/utils/colors.dart';
import 'package:doctorapp/utils/constant.dart';
import 'package:doctorapp/utils/strings.dart';
import 'package:doctorapp/utils/utility.dart';
import 'package:doctorapp/widgets/custom_card.dart';
import 'package:doctorapp/widgets/my_colors.dart';
import 'package:doctorapp/widgets/my_font_size.dart';
import 'package:doctorapp/widgets/mynetworkimg.dart';
import 'package:doctorapp/widgets/mysvgassetsimg.dart';
import 'package:doctorapp/widgets/mytext.dart';
import 'package:doctorapp/widgets/mytextformfield.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:doctorapp/model/periksamodel.dart';
import 'package:doctorapp/model/pasienmodel.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:doctorapp/pages/pasien/component/vitalsign_entry.dart';
import 'package:doctorapp/pages/pasien/component/soap_entry.dart';
import 'package:provider/provider.dart';
import 'package:doctorapp/provider/pasien_prov.dart';
import 'package:doctorapp/pages/pasien/component/diagnosis_entry.dart';

class  Detailmr extends StatefulWidget {
  final AntrianPasienProfile detailpasienProfile;
  const  Detailmr({Key? key, required this.detailpasienProfile})
      : super(key: key);

  @override
  State< Detailmr> createState() =>
      _DetailmrState();
}

class _DetailmrState extends State< Detailmr> {
  PeriksaPasienProfile vitalSignPasien = new PeriksaPasienProfile();
  String _hasBeenPressed = '';
  //late CircularBottomNavigationController _navigationController;
  int selectedPos = 0;
  double bottomNavBarHeight = 60;
  final controller = ScrollController();
  List<AntrianPasienProfile> AntrianPasienList = [];
  List<AntrianPasienProfile> MRPasienList = [];
  late PeriksaPasienProfile vitalSignUpdate;
  late FocusNode myFocusNode;
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
  void initState() {
    _hasBeenPressed = "";
    _getFirtsInfo();
    super.initState();
    EasyLoading.addStatusCallback(statusCallback);
    myFocusNode = FocusNode();
    //_navigationController = CircularBottomNavigationController(selectedPos);
  }
  Widget bottomNav() {
    return Column(
      mainAxisSize: MainAxisSize.max,
      children: <Widget>[
        Padding(
            padding: const EdgeInsets.fromLTRB(16, 10, 16, 0),
            child: StaggeredGrid.count(
              crossAxisCount: 3,
              mainAxisSpacing: 20,
              crossAxisSpacing: 20,
              children: [
                CustomCard(
                  onTap: () {},
                  shadow: false,
                  width: double.infinity,
                  bgColor: MyColors.white,
                  borderRadius: BorderRadius.circular(15),
                  padding: EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      CustomCard(
                        shadow: false,
                        height: 50,
                        width: 50,
                        bgColor: blue,
                        borderRadius: BorderRadius.circular(100),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Text(
                        "Tindakan",
                        style: TextStyle(
                            color: MyColors.blackText,
                            fontSize: 11,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
                CustomCard(
                  // onTap: () {
                  //   Navigator.of(context).push(MaterialPageRoute(
                  //       builder: (context) => const ListingTindakanObat()));
                  // },
                  shadow: false,
                  width: double.infinity,
                  bgColor: MyColors.white,
                  borderRadius: BorderRadius.circular(15),
                  padding: EdgeInsets.all(18),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      CustomCard(
                        shadow: false,
                        height: 50,
                        width: 50,
                        bgColor: blue,
                        borderRadius: BorderRadius.circular(100),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Text(
                        "Isi Resep",
                        style: TextStyle(
                            color: MyColors.blackText,
                            fontSize: 11,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                    ],
                  ),
                ),
                CustomCard(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const ListingICD10Doc()));
                  },
                  shadow: false,
                  width: double.infinity,
                  bgColor: MyColors.white,
                  borderRadius: BorderRadius.circular(15),
                  padding: EdgeInsets.all(18),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      CustomCard(
                        shadow: false,
                        height: 50,
                        width: 50,
                        bgColor: blue,
                        borderRadius: BorderRadius.circular(100),
                        // child: Center(
                        //     child: Icon(
                        //   MyFlutterApp.group_96,
                        //   color: MyColors.white,
                        // ))
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Text(
                        "Isi ICD-10",
                        style: TextStyle(
                            color: MyColors.blackText,
                            fontSize: 11,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                    ],
                  ),
                ),
              ],
            )),
      ],
    );
  }

  Future<void> _getFirtsInfo() async {
    await UserApiService.getDetaiMRPasienPost(
        widget.detailpasienProfile.no_registrasi)
        .then((Vitaldata) {
    setState(() {
    vitalSignPasien = Vitaldata;
    });
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: myAppBar(),
      body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Container(
              margin: const EdgeInsets.fromLTRB(10, 0, 10, 10),
              child: Column(children: <Widget>[
                titel1(vitalSignPasien),
                CardProfile(vitalSignPasien),
                titel2(vitalSignPasien),
                VitalSign(context, vitalSignPasien),
                SOAPSubyektif(vitalSignPasien),
                SOAPObjektif(vitalSignPasien),
                SOAPAssestment(vitalSignPasien),
                PasienResep(vitalSignPasien),
                PasienRadiologi(vitalSignPasien),
                PasienLaboratorium(vitalSignPasien),

              ]))),
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
        mTitle: 'Medical Record Pasien',
        mFontSize: 18,
        mFontStyle: FontStyle.normal,
        mFontWeight: FontWeight.normal,
        mTextAlign: TextAlign.center,
        mTextColor: white,
      ),
    );
  }

  @override
  Widget titel1(PeriksaPasienProfile item){
    return  Container(
        alignment: Alignment.centerLeft,
        child: Padding (
            padding: const EdgeInsets.only(left: 20, top: 10),
            child:Text(
                'Profile Pasien',
                style: GoogleFonts.nunito(
                    fontSize: 16, fontWeight: FontWeight.w800))));
  }
  @override
  Widget titel2(PeriksaPasienProfile item){
    return Container(
        alignment: Alignment.centerLeft,
        child: Padding (
            padding: const EdgeInsets.only(left: 20),
            child: Text(
                'Vital Sign',
                style: GoogleFonts.nunito(
                    fontSize: 16, fontWeight: FontWeight.w800))));
  }

  Widget titel3(PeriksaPasienProfile item){
    return Text(
        'Riawayat SOAP',
        style: GoogleFonts.nunito(
            fontSize: 16, fontWeight: FontWeight.w800));
  }
  @override
  Widget CardPemeriksaan(PeriksaPasienProfile item) {
    final String NoKontrak;
    final GestureTapCallback? onTap;
    return Padding(
      padding: const EdgeInsets.all(0),
      child: Container(
          height: MediaQuery.of(context).size.height * 0.2, // 125,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            color: white,
            borderRadius: BorderRadius.circular(10),
          ),
          child: ClipRRect(
              borderRadius: BorderRadius.circular(0),
              child: Container(
                  child: Stack(children: <Widget>[
                    Positioned(
                      child: Container(
                          height: 300,
                          alignment: Alignment.center,
                          child: Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Expanded(
                                          flex: 8,
                                          child: Column(
                                              crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                              children: [IsiCardPemeriksa(item)])),
                                      Expanded(
                                          flex: 2,
                                          child: Column(
                                              crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                              children: [
                                                ClipRRect(
                                                  // borderRadius:
                                                  //     BorderRadius.circular(6),
                                                  borderRadius:
                                                  BorderRadius.circular(40),
                                                  clipBehavior: Clip.antiAlias,
                                                ),
                                                //dropdownMenu(),
                                                //Container(child: dropdownMenu())
                                              ])),
                                    ],
                                  )
                                ]),
                          )),
                    )
                  ])))),
    );
  }
  Widget IsiCardPemeriksa(PeriksaPasienProfile item) {
    return Padding(
        padding: const EdgeInsets.all(10.0),
        child: Container(
          child:
          Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            SizedBox(height: 5),
            IntrinsicHeight(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  //signSatu(context)
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _textWidgeColumn(
                            title: "Diperiksan Oleh :",
                            value: vitalSignPasien.nama_dokter),
                        SizedBox(height: 10),
                        _textWidgeColumn(
                            title: "Bagian :",
                            value: vitalSignPasien.nama_bagian),
                        SizedBox(height: 10),
                        _textWidgeColumn(
                            title: "Tanggal :",
                            value: vitalSignPasien.tanggal),
                        SizedBox(height: 10),
                        _textWidgeColumn(
                            title: "Jam :",
                            value: vitalSignPasien.jml_rujuk),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                ],
              ),
            ),
          ]),
        ));
  }
  @override
  Widget CardProfile(PeriksaPasienProfile item) {
    final String NoKontrak;
    final GestureTapCallback? onTap;
    String urlfoto = widget.detailpasienProfile.url_foto_px;
    urlfoto = urlfoto.replaceAll('..', '');

    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Container(
          decoration: BoxDecoration(
            color: white,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: gray, width: 0.5),
          ),
          child: ClipRRect(
              borderRadius: BorderRadius.circular(0),
              child: Container(
                  child: Stack(children: <Widget>[
                    Positioned(
                      child: Container(
                          alignment: Alignment.center,
                          child: Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Expanded(
                                          flex: 8,
                                          child: Column(
                                              crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                              children: [IsiCardProfileL(item)])),
                                      Expanded(
                                          flex: 2,
                                          child: Column(
                                              crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                              children: [
                                                ClipRRect(
                                                  // borderRadius:
                                                  //     BorderRadius.circular(6),
                                                  borderRadius:
                                                  BorderRadius.circular(40),
                                                  clipBehavior: Clip.antiAlias,
                                                  child: FadeInImage.assetNetwork(
                                                    placeholder:
                                                    'assets/images/avatar.png',
                                                    image:
                                                    urlfoto, //infoIsi.url_foto_px,
                                                    fit: BoxFit.fill,
                                                    width: 80,
                                                    height: 80,
                                                    imageErrorBuilder:
                                                        (context, url, error) =>
                                                        Icon(Icons.error),
                                                  ),
                                                ),
                                                //dropdownMenu(),
                                                //Container(child: dropdownMenu())
                                              ])),
                                    ],
                                  )
                                ]),
                          )),
                    )
                  ])))),
    );
  }

  Widget IsiCardProfileL(PeriksaPasienProfile item) {
    return Padding(
        padding: const EdgeInsets.all(10.0),
        child: Container(
          child:
          Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(widget.detailpasienProfile.nama_px,
                style: GoogleFonts.poppins(
                    fontSize: 16, fontWeight: FontWeight.w800)),
            new SizedBox(
              height: 4,
              child: new Center(
                child: new Container(
                  margin: new EdgeInsetsDirectional.only(start: 1.0, end: 1.0),
                  height: 2.0,
                  color: const Color.fromARGB(255, 217, 217, 217),
                ),
              ),
            ),
            SizedBox(height: 5),
            IntrinsicHeight(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  //signSatu(context)
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _textWidgeColumn(
                            title: "No MR .",
                            value: widget.detailpasienProfile.no_mr),
                        SizedBox(height: 10),
                        _textWidgeColumn(
                            title: "Umur .",
                            value: widget.detailpasienProfile.umur_px),
                        SizedBox(height: 10),
                        _textWidgeColumn(
                            title: "Golongan Darah .",
                            value: widget.detailpasienProfile.gol_darah_px),
                        SizedBox(height: 10),
                        _textWidgeColumn(
                            title: "Jenis Kelamin .",
                            value: widget.detailpasienProfile.gender_px),
                        SizedBox(height: 10),
                        _textWidgeColumn(
                            title: "Alergi .",
                            value: widget.detailpasienProfile.alergi_px),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                ],
              ),
            ),
          ]),
        ));
  }

  @override
  Widget VitalSign(BuildContext context, PeriksaPasienProfile item) {
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
          decoration: BoxDecoration(
            color: Colors.white,
            //decoration for the outer wrapper
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: gray, width: 0.5),
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
                          child: Container(
                            padding: const EdgeInsets.only(top: 20),
                            child: Padding(
                                padding: const EdgeInsets.all(15),
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
                                                  _textWidgeColumnRow(
                                                      title: "Keadaan Umum .",
                                                      value: item.keadaan_umum),
                                                  SizedBox(height: 10),
                                                  _textWidgeColumnRow(
                                                      title: "Tekanan Darah .",
                                                      value: item.tekanan_darah),
                                                  SizedBox(height: 10),
                                                  _textWidgeColumnRow(
                                                      title: "Suhu .",
                                                      value: item.suhu),
                                                  SizedBox(height: 10),
                                                  _textWidgeColumnRow(
                                                      title: "Tinggi  Badan .",
                                                      value: item.tinggi_badan),
                                                  SizedBox(height: 10),
                                                  _textWidgeColumnRow(
                                                      title: "Heart Rate .",
                                                      value: item.heart_rate),
                                                ],
                                              ),
                                            ),
                                            SizedBox(
                                              width: 5,
                                            ),
                                            Expanded(
                                              child: Column(
                                                crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                                children: [
                                                  _textWidgeColumnRow(
                                                      title: "Kesadaran .",
                                                      value:
                                                      item.kesadaran_pasien),
                                                  SizedBox(height: 10),
                                                  _textWidgeColumnRow(
                                                      title: "Nadi .",
                                                      value:
                                                      vitalsignDataDef.nadi),
                                                  SizedBox(height: 10),
                                                  _textWidgeColumnRow(
                                                      title: "Pernafasan .",
                                                      value: item.pernafasan),
                                                  SizedBox(height: 10),
                                                  _textWidgeColumnRow(
                                                      title: "Berat Badan .",
                                                      value: item.berat_badan),
                                                  SizedBox(height: 10),
                                                  _textWidgeColumnRow(
                                                      title: "Lingkar Perut .",
                                                      value: item.lingkar_perut),
                                                ],
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                )),
                          ),
                        ),
                      ),
                      Container(
                        transform: Matrix4.translationValues(20, 10, 0),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(4.0),
                          clipBehavior: Clip.antiAlias,

                        ),
                      ),
                    ],
                  )))),
    );
  }

  @override
  Widget ButtonTindakan() {
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
          height: MediaQuery.of(context).size.height * 0.24, // 125,
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
                                      child: bottomNav())),
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
                            mTitle: 'Planning',
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

  @override
  Widget ButtonPasien() {
    final String NoKontrak;
    final GestureTapCallback? onTap;

    PeriksaPasienProfile vitalsignDataDef;
    final AuthPasienData tablesProvider =
    Provider.of<AuthPasienData>(context, listen: false);
    vitalsignDataDef = tablesProvider.DataPeriksa;
    print(vitalsignDataDef.nadi);

    return Padding(
      padding: const EdgeInsets.all(10),
      child: Container(
          height: MediaQuery.of(context).size.height * 0.10, // 125,
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
                                                    child: Text('Lihat MR'),
                                                    onPressed: () {
                                                      Navigator.push(
                                                          context,
                                                          MaterialPageRoute(
                                                              builder: (context) =>
                                                                  MedicalRecPasienList(
                                                                    detailpasienProfile:
                                                                    widget
                                                                        .detailpasienProfile,
                                                                  )));
                                                    },
                                                    style: ElevatedButton.styleFrom(
                                                        primary: Color.fromRGBO(
                                                            14, 190, 127, 1),

                                                        // padding: EdgeInsets.symmetric(
                                                        //     horizontal: 50,
                                                        //     vertical: 20),
                                                        textStyle: TextStyle(
                                                            fontSize: 17,
                                                            fontWeight:
                                                            FontWeight.w700)),
                                                  ),
                                                  ElevatedButton(
                                                    child: Text('Dictionary HISS'),
                                                    onPressed: () {
                                                      Navigator.of(context).push(
                                                          MaterialPageRoute(
                                                              builder: (context) =>
                                                              const ListingHISSDoc())); //ListingHISSDoc
                                                    },
                                                    style: ElevatedButton.styleFrom(
                                                        primary: Color.fromRGBO(
                                                            38, 153, 249, 1),

                                                        // padding: EdgeInsets.symmetric(
                                                        //     horizontal: 50,
                                                        //     vertical: 20),
                                                        textStyle: TextStyle(
                                                            fontSize: 17,
                                                            fontWeight:
                                                            FontWeight.w700)),
                                                  ),
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

  Widget PasienResep(PeriksaPasienProfile item) {
    final String NoKontrak;
    final GestureTapCallback? onTap;

    return Padding(
        padding: const EdgeInsets.all(1.0),
        child: Container(
          height: 200, // 125,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            //decoration for the outer wrapper
            color: white,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                  mainAxisAlignment:
                  MainAxisAlignment.start, //change here don't //worked
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    //flex: 5,
                    Text(
                      'Resep',
                      style: TextStyle(
                          color: blue,
                          fontSize: 14.0,
                          fontWeight: FontWeight.bold),
                    ),
                    new Spacer(),
                    Row(
                      children: [
                        Text(''),
                        IconButton(
                          icon: Image.asset(
                              'assets/images/icons/printmedrecord.png'),
                          tooltip: 'Closes application',
                          onPressed: () {},
                        ),
                      ],
                    )
                  ]),
            ),
            new SizedBox(
              height: 4,
              child: new Center(
                child: new Container(
                  margin: new EdgeInsetsDirectional.only(start: 1.0, end: 1.0),
                  height: 2.0,
                  color: const Color.fromARGB(255, 241, 187, 183),
                ),
              ),
            ),
            SizedBox(
              height: 5,
            ),
            Expanded(
                child: Container(
                    padding: const EdgeInsets.only(right: 180,top: 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              'NAMA OBAT:',
                              style: TextStyle(color: Colors.black, fontSize: 14.0),
                            ),
                            Text(
                              'SATUAN:' ,
                              style: TextStyle(color: Colors.black, fontSize: 14.0),
                            ),
                            Text(
                              'JUMLAH:',
                              style: TextStyle(color: Colors.black, fontSize: 14.0),
                            ),
                            Text(
                              'ATURAN PEMAKAIAN:',
                              style: TextStyle(color: Colors.black, fontSize: 14.0),
                            ),
                            Text(
                              'NOTE:',
                              style: TextStyle(color: Colors.black, fontSize: 14.0),
                            ),
                            Text(
                              'KET:' ,
                              style: TextStyle(color: Colors.black, fontSize: 14.0),
                            ),
                          ],
                        ),)),
          ]),
        ));
  }


  Widget PasienRadiologi(PeriksaPasienProfile item) {
    final String NoKontrak;
    final GestureTapCallback? onTap;

    return Padding(
        padding: const EdgeInsets.only(top: 5.0),
        child: Container(
          height: 200, // 125,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            //decoration for the outer wrapper
            color: white,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                  mainAxisAlignment:
                  MainAxisAlignment.start, //change here don't //worked
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    //flex: 5,
                    Text(
                      'Radiologi',
                      style: TextStyle(
                          color: blue,
                          fontSize: 14.0,
                          fontWeight: FontWeight.bold),
                    ),
                    new Spacer(),
                    Row(
                      children: [
                        Text('Print Hasil'),
                        IconButton(
                          icon: Image.asset(
                              'assets/images/icons/printmedrecord.png'),
                          tooltip: 'Closes application',
                          onPressed: () {},
                        ),
                      ],
                    )
                  ]),
            ),
            new SizedBox(
              height: 4,
              child: new Center(
                child: new Container(
                  margin: new EdgeInsetsDirectional.only(start: 1.0, end: 1.0),
                  height: 2.0,
                  color: const Color.fromARGB(255, 241, 187, 183),
                ),
              ),
            ),
            SizedBox(
              height: 5,
            ),
            Expanded(
                child: Container(
                    padding: const EdgeInsets.only(top: 20),
                    child: Padding(
                        padding: const EdgeInsets.all(15),
                        child: Container(
                          //height: double.infinity,
                        )))),
          ]),
        ));
  }

  Widget PasienLaboratorium(PeriksaPasienProfile item) {
    final String NoKontrak;
    final GestureTapCallback? onTap;

    return Padding(
        padding: const EdgeInsets.only(top: 5.0),
        child: Container(
          height: 200, // 125,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            //decoration for the outer wrapper
            color: white,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                  mainAxisAlignment:
                  MainAxisAlignment.start, //change here don't //worked
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    //flex: 5,
                    Text('Laboratorium',
                        style: TextStyle(
                            color: blue,
                            fontSize: 14.0,
                            fontWeight: FontWeight.bold)),
                    new Spacer(),
                    Row(
                      children: [
                        Text('Print Hasil'),
                        IconButton(
                          icon: Image.asset(
                              'assets/images/icons/printmedrecord.png'),
                          tooltip: 'Closes application',
                          onPressed: () {},
                        ),
                      ],
                    )
                  ]),
            ),
            new SizedBox(
              height: 4,
              child: new Center(
                child: new Container(
                  margin: new EdgeInsetsDirectional.only(start: 1.0, end: 1.0),
                  height: 2.0,
                  color: const Color.fromARGB(255, 241, 187, 183),
                ),
              ),
            ),
            SizedBox(
              height: 5,
            ),
            Expanded(
                child: Container(
                    padding: const EdgeInsets.only(top: 20),
                    child: Padding(
                        padding: const EdgeInsets.all(15),
                        child: Container(
                          //height: double.infinity,
                        )))),
          ]),
        ));
  }

  Widget SOAPSubyektif(PeriksaPasienProfile item) {
    final String NoKontrak;
    final GestureTapCallback? onTap;

    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Container(
          height: MediaQuery.of(context).size.height * 0.20, // 125,
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
                            elevation: 0,
                            color: white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: Container(
                              padding: const EdgeInsets.only(top: 20),
                              child: Padding(
                                  padding: const EdgeInsets.all(15),
                                  child: Container(
                                    //height: double.infinity,
                                      child: IsiSUbyektif(
                                        newsPost: item,
                                      )
                                  )),
                            ),
                          ),
                        ),
                      ),
                      Container(
                        transform: Matrix4.translationValues(20, 10, 0),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(4.0),
                          clipBehavior: Clip.antiAlias,
                          child: MyText(
                            mTitle: 'Subyektif',
                            mFontSize: 16,
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

  Widget _textWidgeT({String? title, String? value}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Text(title ?? '-',
              style:
              //  TextStyle(
              //     color: Colors.black,
              //     fontWeight: FontWeight.bold,
              //     fontSize: 16.sp),
              TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: Colors.black,
                fontFamily: 'RobotoMono',
              )),
        ),
        Expanded(
          child: Text(
            value ?? '-',
            textAlign: TextAlign.end,
            style: TextStyle(
              fontSize: 14,
              color: Colors.black,
              fontFamily: 'RobotoMono',
            ),
          ),
        )
      ],
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
                  color: blue,
                  fontFamily: 'RobotoMono',
                )),
          ),
          Flexible(
            child: new Text(value ?? '-',
                textAlign: TextAlign.start,
                //overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                  fontFamily: 'RobotoMono',
                )),
          )
        ],

        //),

        // Expanded(
        //   child: Text(
        //     value ?? '-',
        //     textAlign: TextAlign.end,
        //     style: TextStyle(
        //       fontSize: 14,
        //       color: Colors.black,
        //       fontFamily: 'RobotoMono',
        //     ),
        //   ),
        // )
      ),
    );
  }

  Widget _textWidgeColumnRow({String? title, String? value}) {
    return Padding(
      padding: const EdgeInsets.all(0.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title ?? '-',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: blue,
                    fontFamily: 'RobotoMono',
                  )),
              Text(value ?? '-',
                  textAlign: TextAlign.start,
                  //overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                    fontFamily: 'RobotoMono',
                  )),
            ],
          )
        ],
      ),
    );
  }

  Widget signSatu(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 5),
      child: Container(
        child: Column(
          children: [
            // _textWidgeT(
            //   title: "2. Tekanan Darah .",
            //   value: "1",
            // ),
            // SizedBox(height: 5),
            // _textWidgeT(
            //   title: "2. Tekanan Darah .",
            //   value: "2",
            // ),
            // SizedBox(height: 5),
          ],
        ),
      ),
    );
  }

  Widget SOAPObjektif(PeriksaPasienProfile item) {
    final String NoKontrak;
    final GestureTapCallback? onTap;

    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Container(
          height: MediaQuery.of(context).size.height * 0.20, // 125,
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
                            elevation: 0,
                            color: white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: Container(
                              padding: const EdgeInsets.only(top: 20),
                              child: Padding(
                                  padding: const EdgeInsets.all(15),
                                  child: Container(
                                    //height: double.infinity,
                                      child: IsiObjective(
                                        newsPost: item,
                                      ))),
                            ),
                          ),
                        ),
                      ),
                      Container(
                        transform: Matrix4.translationValues(20, 10, 0),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(4.0),
                          clipBehavior: Clip.antiAlias,
                          child: MyText(
                            mTitle: 'Objective',
                            mFontSize: 15,
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
          height: MediaQuery.of(context).size.height * 0.20, // 125,
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
                            elevation: 0,
                            color: white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: Container(
                              padding: const EdgeInsets.only(top: 20),
                              child: Padding(
                                  padding: const EdgeInsets.all(15),
                                  child: Container(
                                    //height: double.infinity,
                                      child: IsiAnemnese(
                                        newsPost: item,
                                      ))),
                            ),
                          ),
                        ),
                      ),
                      Container(
                        transform: Matrix4.translationValues(20, 10, 0),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(4.0),
                          clipBehavior: Clip.antiAlias,
                          child: MyText(
                            mTitle: 'Assestment',
                            mFontSize: 15,
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
}


class IsiSUbyektif extends StatelessWidget {
  final PeriksaPasienProfile newsPost;
  const IsiSUbyektif({Key? key, required this.newsPost}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Scaffold(
        body: Container(
            width: double.infinity,
            child: Stack(
              children: [
                InteractiveViewer(
                  boundaryMargin: EdgeInsets.all(100),
                  minScale: 0.1,
                  maxScale: 1.5,
                  child: Container(
                    //margin: EdgeInsets.only(top: 10, right: 10),
                    height: 330,
                    decoration: BoxDecoration(color: Colors.white),
                    child: IsiSubyektif(newsPost),
                  ),
                ),
              ],
            )));
  }

  @override
  Widget IsiSubyektif(PeriksaPasienProfile item) {
    return Scrollbar(
        child: ListView.builder(
            physics: const AlwaysScrollableScrollPhysics(),
            itemCount: 1,
            scrollDirection: Axis.vertical,
            //controller: _scrollControllertransIsi,
            itemBuilder: (context, index) {
              return (Html(
                data: item.subjektif,
                //shrinkWrap: true,
              ));
            }));
  }
}

class IsiObjective extends StatelessWidget {
  final PeriksaPasienProfile newsPost;
  const IsiObjective({Key? key, required this.newsPost}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Scaffold(
        body: Container(
            width: double.infinity,
            child: Stack(
              children: [
                InteractiveViewer(
                  boundaryMargin: EdgeInsets.all(100),
                  minScale: 0.1,
                  maxScale: 1.5,
                  child: Container(
                    //margin: EdgeInsets.only(top: 10, right: 10),
                    height: 330,
                    decoration: BoxDecoration(color: Colors.white),
                    child: Isiobjective(newsPost),
                  ),
                ),
              ],
            )));
  }

  @override
  Widget Isiobjective(PeriksaPasienProfile item) {
    return Scrollbar(
        child: ListView.builder(
            physics: const AlwaysScrollableScrollPhysics(),
            itemCount: 1,
            scrollDirection: Axis.vertical,
            //controller: _scrollControllertransIsi,
            itemBuilder: (context, index) {
              return (Html(
                data: item.objektif,
                //shrinkWrap: true,
              ));
            }));
  }
}

class IsiAnemnese extends StatelessWidget {
  final PeriksaPasienProfile newsPost;
  const IsiAnemnese({Key? key, required this.newsPost}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Scaffold(
        body: Container(
            width: double.infinity,
            child: Stack(
              children: [
                InteractiveViewer(
                  boundaryMargin: EdgeInsets.all(100),
                  minScale: 0.1,
                  maxScale: 1.5,
                  child: Container(
                    //margin: EdgeInsets.only(top: 10, right: 10),
                    height: 330,
                    decoration: BoxDecoration(color: Colors.white),
                    child: Isianemnese(newsPost),
                  ),
                ),
              ],
            )));
  }

  @override
  Widget Isianemnese(PeriksaPasienProfile item) {
    return Scrollbar(
        child: ListView.builder(
            physics: const AlwaysScrollableScrollPhysics(),
            itemCount: 1,
            scrollDirection: Axis.vertical,
            //controller: _scrollControllertransIsi,
            itemBuilder: (context, index) {
              return (Html(
                data: item.assesment,
                //shrinkWrap: true,
              ));
            }));
  }
}



class MenuItem {
  final String text;
  final IconData icon;

  const MenuItem({
    required this.text,
    required this.icon,
  });
}
