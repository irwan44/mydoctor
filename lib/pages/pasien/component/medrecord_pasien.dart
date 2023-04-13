import 'dart:developer';

import 'package:calendar_timeline/calendar_timeline.dart';
import 'package:doctorapp/apiservice/serviceapi.dart';
import 'package:doctorapp/pages/pasien/component/medrecord_pasien_det.dart';
import 'package:doctorapp/utils/colors.dart';
import 'package:doctorapp/utils/constant.dart';
import 'package:doctorapp/utils/utility.dart';
import 'package:doctorapp/widgets/custom_card.dart';
import 'package:doctorapp/widgets/my_colors.dart';
import 'package:doctorapp/widgets/mysvgassetsimg.dart';
import 'package:doctorapp/widgets/mytext.dart';
import 'package:flutter/material.dart';
import 'package:doctorapp/model/periksamodel.dart';
import 'package:doctorapp/model/pasienmodel.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:google_fonts/google_fonts.dart';

class MedicalRecPasienList extends StatefulWidget {
  final AntrianPasienProfile detailpasienProfile;
  const MedicalRecPasienList({Key? key, required this.detailpasienProfile})
      : super(key: key);

  @override
  State<MedicalRecPasienList> createState() => _MedicalRecPasienListState();
}

class _MedicalRecPasienListState extends State<MedicalRecPasienList> {
  PeriksaPasienProfile vitalSignPasien = new PeriksaPasienProfile();

  int selectedPos = 0;
  double bottomNavBarHeight = 60;
  final controller = ScrollController();

  var _scrollControllertrans = ScrollController();
  String _hasBeenPressed = '';
  List<AntrianPasienProfile> AntrianPasienList = [];
  List<AntrianPasienProfile> MRPasienList = [];
  late DateTime _selectedDate;

  @override
  void initState() {
    _getFirtsInfo();
    _resetSelectedDate();
    super.initState();
  }
  void _resetSelectedDate() {
    _selectedDate = DateTime.now().add(const Duration(days: 2));
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
                  onTap: () {
                    // Navigator.push(
                    //     context,
                    //     MaterialPageRoute(
                    //         builder: (context) => PrescriptionF()));
                  },
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
                        "Isi Tindakan",
                        style: TextStyle(
                            color: MyColors.blackText,
                            fontSize: 11,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
                CustomCard(
                  onTap: () {
                    // Navigator.push(
                    //     context,
                    //     MaterialPageRoute(
                    //         builder: (context) => ListingAntrianPasien()));
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
                    // Navigator.push(
                    //     context,
                    //     MaterialPageRoute(
                    //         builder: (context) => ListingAntrianPasien()));
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
    //return FirtsInfoPasienList;

    await UserApiService.getPasienMRPasienList(
        '', widget.detailpasienProfile.no_mr,

    widget.detailpasienProfile.tgl_periksa)
        .then((Vitaldata) {
      setState(() {
        MRPasienList = Vitaldata;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset : false,
        appBar: myAppBar(),
        body: SingleChildScrollView(
                  child: Column(
            children: [
            Container(
            child: Column (
            children: [
              CardProfile(vitalSignPasien),
              Calender(),
              Container(
                child : Padding( padding: const EdgeInsets.all(9.0),
                  child: Column(
                    children: [
                      ListIsiRiwayat(),
            ],
          )),
              )]))])));
  }

  Future<void> ProfileDetail() async {}



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
        mTitle: 'History Medical Record',
        mFontSize: 18,
        mFontStyle: FontStyle.normal,
        mFontWeight: FontWeight.normal,
        mTextAlign: TextAlign.center,
        mTextColor: white,
      ),
    );
  }
  @override
  Widget CardProfile(PeriksaPasienProfile item) {
    final String NoKontrak;
    final GestureTapCallback? onTap;

    String urlfoto = widget.detailpasienProfile.url_foto_px;
    urlfoto = urlfoto.replaceAll('..', '');
    print(urlfoto);

    return Container(
          // 125,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            //decoration for the outer wrapper
            color: white,
            borderRadius: BorderRadius.circular(0),
          ),
          child: ClipRRect(
              borderRadius: BorderRadius.circular(0),
              child: Container(
                height: 200,
                  child: Stack(children: <Widget>[
                    Positioned(
                      child: Container(
                          alignment: Alignment.center,
                          child: Padding(
                            padding: const EdgeInsets.all(9.0),
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
                                                  borderRadius:
                                                  BorderRadius.circular(40),
                                                  child: FadeInImage.assetNetwork(
                                                    placeholder:
                                                    'assets/images/avatar.png',
                                                    image:
                                                    urlfoto, //infoIsi.url_foto_px,
                                                    fit: BoxFit.fill,
                                                    width: 80,
                                                    height: 90,
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
                  ]))),
    );
  }
  @override
  Widget Calender() {
    return  Column(
      children: [
      Card(
      child : Padding( padding: const EdgeInsets.only(left: 0, right: 10),
      child : Column(
      children: [
        const SizedBox(
          height: 10,
        ),
        Text("Calender"),
        CalendarTimeline(
          showYears: false,
          initialDate: _selectedDate,
          firstDate: DateTime.now(),
          lastDate: DateTime.now().add(const Duration(days: 365 * 4)),
          onDateSelected: (date) => setState(() => _selectedDate = date),
          leftMargin: 20,
          monthColor: Colors.black54,
          dayColor: Colors.black54,
          dayNameColor: Colors.blue,
          activeDayColor: Colors.blue,
          activeBackgroundDayColor: Colors.white,
          dotsColor: const Color(0xFF333A47),
          selectableDayPredicate: (date) => date.day != 23,
          locale: 'in',
        ),
        const SizedBox(
          height: 10,
        ),
      ],
    )))]);
  }

  Widget IsiCardProfileL(PeriksaPasienProfile item) {
    return ConstrainedBox(
          constraints: BoxConstraints(),
          child:
          Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(widget.detailpasienProfile.nama_px,
                style: GoogleFonts.poppins(
                    fontSize: 16, fontWeight: FontWeight.w800)),
            new SizedBox(
              height: 20,
              child: new Center(
                child: new Container(
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
      ),
    );
  }

  @override
  Widget ListIsiRiwayat() {
    return FutureBuilder<List<PeriksaPasienProfile>>(
      //future: _getFirtsInfo,
        builder: (context, _) => Container(//  displayWidth(context),
              child: LayoutBuilder(builder: (context, constraints) {
                final List<AntrianPasienProfile>? items =
                    MRPasienList;
                return items!.length == 0
                    ? Center(child: CircularProgressIndicator())
                    : Container(
                  child: ListView.builder(
                      shrinkWrap:true,
                    physics: const NeverScrollableScrollPhysics(), //Even if zero elements to update scroll
                    itemCount: items.length,
                    itemBuilder: (context, index) {
                      return items[index] == null
                          ? CircularProgressIndicator()
                          : Container(
                        padding: const EdgeInsets.only(bottom: 15.0),
                        child: items.length == 0
                            ? const Text('tak ada data')
                            : IsiInfoRiwayatSearchandFilter(
                          action: (() async {
                            Navigator.of(context).push(
                                MaterialPageRoute(
                                    builder: (context) =>
                                        Detailmr(
                                          detailpasienProfile:
                                          widget.detailpasienProfile,
                                        )
                                ));
                          }),
                          infoIsi: items[index],
                          actionhover: () {
                            MyTooltip(
                                child: Text('Oke'),
                                message: 'msg');
                          },
                        ),
                      );
                    },
                  ),
                );
              }),
            ));
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
            height: 110,
            width: 390,
            child: IntrinsicHeight(
                child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(0),
                    ),
                    shadowColor: Color.fromARGB(255, 198, 240, 11),
                    elevation: 0,
                    child: Padding(
                      padding: const EdgeInsets.all(4.0),
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
                                          BorderRadius.circular(8),
                                          child: MySvgAssetsImg(
                                            imageName: infoIsi
                                                .kode_bagian_tujuan ==
                                                "Laboratorium"
                                                ? "laboratorium.svg"
                                                : "doctor-checking-patient.svg",
                                            imgHeight: 90,
                                            imgWidth: 90,
                                            fit: BoxFit.contain,
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
                                        Text(infoIsi.no_registrasi,
                                            style: GoogleFonts.poppins(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w800)),
                                        SizedBox(
                                          height: 4,
                                          child: Center(
                                            child: Container(
                                              margin:
                                              const EdgeInsetsDirectional
                                                  .only(
                                                  start: 1.0, end: 1.0),
                                              height: 2.0,
                                              color: const Color.fromARGB(
                                                  255, 241, 187, 183),
                                            ),
                                          ),
                                        ),
                                        SizedBox(height: 5),
                                        Text('Dokter. ' + infoIsi.nama_dokter,
                                            style: GoogleFonts.poppins(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w600)),
                                        SizedBox(height: 2),
                                        Text(
                                            'Tanggal Periksa ',
                                            style: GoogleFonts.poppins(
                                                fontSize: 12,
                                                fontWeight: FontWeight.w400)),
                                      ]))
                            ])
                      ]),
                    )))));
  }
}

class IsiInfoRiwayatSearchandFilter extends StatelessWidget {
  final AntrianPasienProfile infoIsi;
  final Widget? prefWidget;
  final VoidCallback action;
  final VoidCallback actionhover;
  //final FocusNode myFocusNode;
  const IsiInfoRiwayatSearchandFilter(
      {Key? key,
        required this.infoIsi,
        required this.action,
        required this.actionhover,
        this.prefWidget})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    String urlfoto = infoIsi.url_foto_px;
    urlfoto = urlfoto.replaceAll('..', '');

    return InkWell(
        onTap: () => action(),
        onHover: (val) => actionhover(),
        child: Container(
          //color: white,
            decoration: BoxDecoration(
              color: white,
              borderRadius: BorderRadius.circular(15),

            ),
            height: 160,
            width: 146,
            child: IntrinsicHeight(
                child: Padding(
                  padding: const EdgeInsets.all(0.0),
                  child: Column(children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              //flex: 8,
                                child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(top: 10.0),
                                        child: Text('Nama Dokter .' + infoIsi.nama_dokter,
                                            style: GoogleFonts.nunito(
                                                fontSize: 15,
                                                fontWeight: FontWeight.w800)),
                                      ),
                                      SizedBox(height: 10),
                                      Text(' Bagian . ' + infoIsi.nama_bagian,
                                          style: GoogleFonts.nunito(
                                              fontSize: 13,
                                              color: blue,
                                              fontWeight: FontWeight.w800)),
                                      SizedBox(height: 10),
                                      Text(' Tanggal Pemeriksaan .',
                                          style: GoogleFonts.nunito(
                                              fontSize: 13,
                                              color: black,
                                              fontWeight: FontWeight.w800)),
                                      SizedBox(height: 15),
                                      Column(
                                        mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            children: [
                                              Container(
                                                child: Row(
                                                  mainAxisAlignment:
                                                  MainAxisAlignment.spaceBetween,
                                                  children: [
                                                    Container(
                                                      //Text(text),
                                                      child: Icon(
                                                        Icons.calendar_month,
                                                        size: 20.0,
                                                        color: blue,
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      width: 10,
                                                    ),
                                                    Text('' + infoIsi.tgl_periksa,
                                                        style: GoogleFonts.nunito(
                                                            fontSize: 12,
                                                            color: black,
                                                            fontWeight: FontWeight.w800)),
                                                  ],
                                                ),
                                              ),
                                              SizedBox(
                                                width: 25,
                                              ),
                                              Container(
                                                child: Row(
                                                  mainAxisAlignment:
                                                  MainAxisAlignment.spaceBetween,
                                                  children: [
                                                    Container(
                                                      //Text(text),
                                                      child: Icon(
                                                        Icons.watch_later_outlined,
                                                        size: 20.0,
                                                        color: blue,
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      width: 10,
                                                    ),
                                                    Text('' + infoIsi.wkt_periksa,
                                                        style: GoogleFonts.nunito(
                                                            fontSize: 12,
                                                            color: black,
                                                            fontWeight: FontWeight.w800)),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          )
                                        ],
                                      )
                                    ]))
                          ]),
                    ),
                  ]),
                )))
      //)
    );
  }
}
