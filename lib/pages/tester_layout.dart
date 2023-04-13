import 'package:flutter/material.dart';
import 'package:appbar_animated/appbar_animated.dart';
import 'package:google_fonts/google_fonts.dart';

import '../apiservice/serviceapi.dart';
import '../model/pasienmodel.dart';
import '../model/periksamodel.dart';
import '../utils/colors.dart';

class MyApp1 extends StatelessWidget {
  final AntrianPasienProfile detailpasienProfile;
  const MyApp1({Key? key, required this.detailpasienProfile}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: DetailPage(detailpasienProfile: AntrianPasienProfile(),),
    );
  }
}

class DetailPage extends StatefulWidget {
  final AntrianPasienProfile detailpasienProfile;
  const DetailPage({Key? key, required this.detailpasienProfile})
      : super(key: key);

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
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
    super.initState();
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
    return Scaffold(
      body: ScaffoldLayoutBuilder(
        backgroundColorAppBar:
        const ColorBuilder(Colors.transparent, Colors.blue),
        textColorAppBar: const ColorBuilder(Colors.white),
        appBarBuilder: _appBar,
        child: SingleChildScrollView(
          child: Stack(
            children: [
              Container(
                  decoration: BoxDecoration(
                    color: blue,
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(10),
                        bottomRight: Radius.circular(10)),
                    image: DecorationImage(
                        image: AssetImage('assets/images/Design1.png'),
                        fit: BoxFit.cover),
                  ),
              child: Padding(
                padding: const EdgeInsets.only(top: 90.0, right: 20, left: 20),
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
                            const SizedBox(
                              height: 120,
                            )
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
            )),
              Container(
                margin: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height * 0.36,
                ),
                height: 900,
                width: 900,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(40),
                  ),
                  color: Colors.white,
                ),
                child: Text("irwan"),
              ),
            ],
          ),
        ),
      ),
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
                  color: Colors.white,
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

  Widget _appBar(BuildContext context, ColorAnimated colorAnimated) {
    return AppBar(
      backgroundColor: colorAnimated.background,
      elevation: 0,
      title: Text(
        "Medical Record",
        style: TextStyle(
          color: colorAnimated.color,
        ),
      ),
      leading: Icon(
        Icons.arrow_back_ios_new_rounded,
        color: colorAnimated.color,
      ),
      actions: [
      ],
    );
  }
}