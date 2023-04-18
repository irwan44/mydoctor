import 'dart:developer';

import 'package:doctorapp/pages/tambah_obat.dart';
import 'package:doctorapp/utils/colors.dart';
import 'package:doctorapp/utils/constant.dart';
import 'package:doctorapp/utils/strings.dart';
import 'package:doctorapp/utils/utility.dart';
import 'package:doctorapp/widgets/mynetworkimg.dart';
import 'package:doctorapp/widgets/mysvgassetsimg.dart';
import 'package:doctorapp/widgets/mytext.dart';
import 'package:doctorapp/widgets/mytextformfield.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../model/pasienmodel.dart';
import '../provider/pasien_prov.dart';

class WritePrescription extends StatefulWidget {
  const WritePrescription({Key? key}) : super(key: key);

  @override
  State<WritePrescription> createState() => _WritePrescriptionState();
}

class _WritePrescriptionState extends State<WritePrescription> {
  final mSymptomsController = TextEditingController();
  final mDiagnosisController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  final List<String> items = [
    'Item1',
    'Item2',
    'Item3',
    'Item4',
    'Item5',
    'Item6',
    'Item7',
    'Item8',
  ];
  String? selectedValue;

  @override
  Widget build(BuildContext context) {
    final AuthPasienData tablesProvider =
    Provider.of<AuthPasienData>(context, listen: false);
    AntrianPasienProfile _modelprofile = tablesProvider.DataPeriksaProfile;
    return Scaffold(
      appBar: myAppBar(),
      body: Column(
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          SingleChildScrollView(
          child : Container(
            padding: const EdgeInsets.fromLTRB(20, 8, 20, 20),
            decoration: const BoxDecoration(
              color: Color.fromARGB(255, 35, 163, 223),
              image: DecorationImage(
                  image: AssetImage('assets/images/Design1.png'),
                  fit: BoxFit.cover),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                Expanded(
                  child:  Container(
                    width: displayWidth(context),
                    height: 70,
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
                      padding: const EdgeInsets.all(0.0),
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
                ),
              ],
            ),
          ),
          ),
          prescriptionTabs(),
        ],
      ),
    );
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
        mTitle: 'Penunjang Medis',
        mFontSize: 18,
        mFontStyle: FontStyle.normal,
        mFontWeight: FontWeight.normal,
        mTextAlign: TextAlign.center,
        mTextColor: white,
      ),
    );
  }
  Widget prescriptionTabs() {
    return Expanded(
      child: DefaultTabController(
        length: 5,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const TabBar(
              isScrollable: true,
              labelColor: blue,
              indicatorSize: TabBarIndicatorSize.label,
              indicatorColor: blue,
              indicatorWeight: 3,
              unselectedLabelColor: tabDefaultColor,
              tabs: <Widget>[
                Tab(text: "Radiologi"),
                Tab(text: "Laboratorium"),
                Tab(text: "Fisoterapi"),
              ],
            ),
            Container(
              margin: const EdgeInsets.only(left: 20, right: 20),
              width: MediaQuery.of(context).size.width,
              height: 1,
              color: boxBorderColor,
            ),
            Expanded(
              child: TabBarView(
                children: [
                  Laboratorium(),
                  Radiologi1(),
                  Fisoterapi2(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget  Radiologi() {
    var mAnalyst;
    var mObjective;
    var mSubyektive;
    final List<String> items = [
      'CONVENTIONAL WITHOUT CONTRA',
      'CONVENTIONAL WITH CONTRAST',
      'USG',
    ];
    return ListView.builder(
      scrollDirection: Axis.vertical,
      physics: const AlwaysScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: 3,
      itemBuilder: (BuildContext context, int position) => Container(
        padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
        child: InkWell(
          borderRadius: BorderRadius.circular(10),
          onTap: () {
            log("$position Item Clicked!");
          },
          child: Container(
            constraints: const BoxConstraints(
              minHeight: 44,
            ),
            padding: const EdgeInsets.only(left: 15, right: 15),
            decoration: BoxDecoration(
              color: white,
              borderRadius: BorderRadius.circular(10),
              shape: BoxShape.rectangle,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                const SizedBox(
                  height: 20,
                ),
                Card(
                    elevation: 0,
                    child :Row(
                        children: [
                          MyText(
                            mTitle: "Kategori",
                            mFontSize: 12,
                            mFontWeight: FontWeight.normal,
                            mFontStyle: FontStyle.normal,
                            mTextAlign: TextAlign.start,
                            mTextColor: textTitleColor,
                          ),
                          Center(
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton2(
                                hint: Text(
                                  'Select Item',
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Theme.of(context).hintColor,
                                  ),
                                ),
                                items: items
                                    .map((item) => DropdownMenuItem<String>(
                                  value: item,
                                  child: Text(
                                    item,
                                    style: const TextStyle(
                                      fontSize: 14,
                                    ),
                                  ),
                                ))
                                    .toList(),
                                value: selectedValue,
                                onChanged: (value) {
                                  setState(() {
                                    selectedValue = value as String;
                                  });
                                },
                              ),
                            ),
                          ),
                        ])),
                const SizedBox(
                  height: 20,
                ),
                //===== Symptoms =====//
                MyText(
                  mTitle: "Dokter Pengirim",
                  mFontSize: 12,
                  mFontWeight: FontWeight.normal,
                  mFontStyle: FontStyle.normal,
                  mTextAlign: TextAlign.start,
                  mTextColor: textTitleColor,
                ),
                const SizedBox(
                  height: 8,
                ),
                Container(
                    constraints: const BoxConstraints(
                      minHeight: 10,
                    ),
                    padding: const EdgeInsets.only(left: 15, right: 15),
                    decoration: Utility.r10BGWithBorder(),
                    alignment: Alignment.topCenter,
                    child: TextFormField(
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                      ),
                    )),
                const SizedBox(
                  height: 8,
                ),
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
                const SizedBox(
                  height: 8,
                ),
                const SizedBox(
                  height: 26,
                ),
                Align(
                  alignment: Alignment.center,
                ),
                const SizedBox(
                  height: 20,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget Laboratorium() {
    var mAnalyst;
    var mObjective;
    var mSubyektive;
    final List<String> items = [
      'CONVENTIONAL WITHOUT CONTRA',
      'CONVENTIONAL WITH CONTRAST',
      'USG',
    ];
    return Form(
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Container(
          padding: const EdgeInsets.only(left: 10, right: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const SizedBox(
                height: 20,
              ),
              Card(
                elevation: 0,
          child :Row(
              children: [
              MyText(
                mTitle: "Kategori",
                mFontSize: 12,
                mFontWeight: FontWeight.normal,
                mFontStyle: FontStyle.normal,
                mTextAlign: TextAlign.start,
                mTextColor: textTitleColor,
              ),
          Center(
          child: DropdownButtonHideUnderline(
            child: DropdownButton2(
            hint: Text(
            'Select Item',
            style: TextStyle(
              fontSize: 14,
              color: Theme.of(context).hintColor,
            ),
          ),
          items: items
              .map((item) => DropdownMenuItem<String>(
            value: item,
            child: Text(
              item,
              style: const TextStyle(
                fontSize: 14,
              ),
            ),
          ))
              .toList(),
          value: selectedValue,
          onChanged: (value) {
            setState(() {
              selectedValue = value as String;
            });
          },
        ),
      ),
    ),
        ])),
              const SizedBox(
                height: 20,
              ),
              //===== Symptoms =====//
              MyText(
                mTitle: "Dokter Pengirim",
                mFontSize: 12,
                mFontWeight: FontWeight.normal,
                mFontStyle: FontStyle.normal,
                mTextAlign: TextAlign.start,
                mTextColor: textTitleColor,
              ),
              const SizedBox(
                height: 8,
              ),
              Container(
                constraints: const BoxConstraints(
                  minHeight: 10,
                ),
                padding: const EdgeInsets.only(left: 15, right: 15),
                decoration: Utility.r10BGWithBorder(),
                alignment: Alignment.topCenter,
                child: TextFormField(
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                  ),
              )),
              const SizedBox(
                height: 8,
              ),
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
              const SizedBox(
                height: 8,
              ),
              const SizedBox(
                height: 26,
              ),
              Align(
                alignment: Alignment.center,
              ),
              const SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget Radiologi1()  {
    var mAnalyst;
    var mObjective;
    var mSubyektive;
    final List<String> items = [
      'CONVENTIONAL WITHOUT CONTRA',
      'CONVENTIONAL WITH CONTRAST',
      'USG',
    ];
    return Form(
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Container(
          padding: const EdgeInsets.only(left: 10, right: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const SizedBox(
                height: 20,
              ),
              Card(
                  elevation: 0,
                  child :Row(
                      children: [
                        MyText(
                          mTitle: "Kategori",
                          mFontSize: 12,
                          mFontWeight: FontWeight.normal,
                          mFontStyle: FontStyle.normal,
                          mTextAlign: TextAlign.start,
                          mTextColor: textTitleColor,
                        ),
                        Center(
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton2(
                              hint: Text(
                                'Select Item',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Theme.of(context).hintColor,
                                ),
                              ),
                              items: items
                                  .map((item) => DropdownMenuItem<String>(
                                value: item,
                                child: Text(
                                  item,
                                  style: const TextStyle(
                                    fontSize: 14,
                                  ),
                                ),
                              ))
                                  .toList(),
                              value: selectedValue,
                              onChanged: (value) {
                                setState(() {
                                  selectedValue = value as String;
                                });
                              },
                            ),
                          ),
                        ),
                      ])),
              const SizedBox(
                height: 20,
              ),
              //===== Symptoms =====//
              MyText(
                mTitle: "Dokter Pengirim",
                mFontSize: 12,
                mFontWeight: FontWeight.normal,
                mFontStyle: FontStyle.normal,
                mTextAlign: TextAlign.start,
                mTextColor: textTitleColor,
              ),
              const SizedBox(
                height: 8,
              ),
              Container(
                  constraints: const BoxConstraints(
                    minHeight: 10,
                  ),
                  padding: const EdgeInsets.only(left: 15, right: 15),
                  decoration: Utility.r10BGWithBorder(),
                  alignment: Alignment.topCenter,
                  child: TextFormField(
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                    ),
                  )),
              const SizedBox(
                height: 8,
              ),
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
              const SizedBox(
                height: 8,
              ),
              const SizedBox(
                height: 26,
              ),
              Align(
                alignment: Alignment.center,
              ),
              const SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget Fisoterapi2()  {
    var mAnalyst;
    var mObjective;
    var mSubyektive;
    final List<String> items = [
      'CONVENTIONAL WITHOUT CONTRA',
      'CONVENTIONAL WITH CONTRAST',
      'USG',
    ];
    return Form(
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Container(
          padding: const EdgeInsets.only(left: 10, right: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const SizedBox(
                height: 20,
              ),
              Card(
                  elevation: 0,
                  child :Row(
                      children: [
                        MyText(
                          mTitle: "Kategori",
                          mFontSize: 12,
                          mFontWeight: FontWeight.normal,
                          mFontStyle: FontStyle.normal,
                          mTextAlign: TextAlign.start,
                          mTextColor: textTitleColor,
                        ),
                        Center(
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton2(
                              hint: Text(
                                'Select Item',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Theme.of(context).hintColor,
                                ),
                              ),
                              items: items
                                  .map((item) => DropdownMenuItem<String>(
                                value: item,
                                child: Text(
                                  item,
                                  style: const TextStyle(
                                    fontSize: 14,
                                  ),
                                ),
                              ))
                                  .toList(),
                              value: selectedValue,
                              onChanged: (value) {
                                setState(() {
                                  selectedValue = value as String;
                                });
                              },
                            ),
                          ),
                        ),
                      ])),
              const SizedBox(
                height: 20,
              ),
              //===== Symptoms =====//
              MyText(
                mTitle: "Dokter Pengirim",
                mFontSize: 12,
                mFontWeight: FontWeight.normal,
                mFontStyle: FontStyle.normal,
                mTextAlign: TextAlign.start,
                mTextColor: textTitleColor,
              ),
              const SizedBox(
                height: 8,
              ),
              Container(
                  constraints: const BoxConstraints(
                    minHeight: 10,
                  ),
                  padding: const EdgeInsets.only(left: 15, right: 15),
                  decoration: Utility.r10BGWithBorder(),
                  alignment: Alignment.topCenter,
                  child: TextFormField(
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                    ),
                  )),
              const SizedBox(
                height: 8,
              ),
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
              const SizedBox(
                height: 8,
              ),
              const SizedBox(
                height: 26,
              ),
              Align(
                alignment: Alignment.center,
              ),
              const SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }
  Widget Fisoterapi() {
    return Center(
      child: MyText(
        mTitle: 'Coming Soon...',
        mFontSize: 16,
        mFontWeight: FontWeight.bold,
        mFontStyle: FontStyle.normal,
        mTextAlign: TextAlign.start,
        mTextColor: accentColor,
      ),
    );
  }

  Widget prescriptionTab() {
    return SingleChildScrollView(
      physics: const AlwaysScrollableScrollPhysics(),
      scrollDirection: Axis.vertical,
      child: Column(
        children: [
          ListView.builder(
            scrollDirection: Axis.vertical,
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: 3,
            itemBuilder: (BuildContext context, int position) => Container(
              padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
              child: InkWell(
                borderRadius: BorderRadius.circular(8),
                onTap: () {
                  log("$position Item Clicked!");
                },
                child: Container(
                  constraints: const BoxConstraints(
                    minHeight: 44,
                  ),
                  padding: const EdgeInsets.only(left: 15, right: 15),
                  decoration: BoxDecoration(
                    color: white,
                    borderRadius: BorderRadius.circular(10),
                    shape: BoxShape.rectangle,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      SizedBox(
                        height: 44,
                        child: Row(
                          children: <Widget>[
                            Expanded(
                              child: MyText(
                                mTitle: 'Paracetamol (250mg)',
                                mFontSize: 14,
                                mFontStyle: FontStyle.normal,
                                mFontWeight: FontWeight.normal,
                                mTextAlign: TextAlign.start,
                                mMaxLine: 1,
                                mOverflow: TextOverflow.ellipsis,
                                mTextColor: textTitleColor,
                              ),
                            ),
                            MySvgAssetsImg(
                              imageName: "delete.svg",
                              fit: BoxFit.cover,
                              imgHeight: 22,
                              imgWidth: 22,
                            )
                          ],
                        ),
                      ),
                      Container(
                        height: 0.5,
                        color: boxBorderColor,
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      MyText(
                        mTitle: whenToTake,
                        mFontSize: 12,
                        mFontWeight: FontWeight.normal,
                        mFontStyle: FontStyle.normal,
                        mTextAlign: TextAlign.start,
                        mTextColor: otherLightColor,
                      ),
                      const SizedBox(
                        height: 4,
                      ),
                      MyText(
                        mTitle: "Sesudah Makan",
                        mFontSize: 14,
                        mFontWeight: FontWeight.normal,
                        mFontStyle: FontStyle.normal,
                        mTextAlign: TextAlign.start,
                        mTextColor: textTitleColor,
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      MyText(
                        mTitle: duration,
                        mFontSize: 12,
                        mFontWeight: FontWeight.normal,
                        mFontStyle: FontStyle.normal,
                        mTextAlign: TextAlign.start,
                        mTextColor: otherLightColor,
                      ),
                      const SizedBox(
                        height: 4,
                      ),
                      MyText(
                        mTitle: "5 hari",
                        mFontSize: 14,
                        mFontWeight: FontWeight.normal,
                        mFontStyle: FontStyle.normal,
                        mTextAlign: TextAlign.start,
                        mTextColor: textTitleColor,
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      MyText(
                        mTitle: additionalNote,
                        mFontSize: 12,
                        mFontWeight: FontWeight.normal,
                        mFontStyle: FontStyle.normal,
                        mTextAlign: TextAlign.start,
                        mTextColor: otherLightColor,
                      ),
                      const SizedBox(
                        height: 4,
                      ),
                      MyText(
                        mTitle: "Ambil satu tablet 3 kali sehari.",
                        mFontSize: 14,
                        mFontWeight: FontWeight.normal,
                        mFontStyle: FontStyle.normal,
                        mTextAlign: TextAlign.start,
                        mTextColor: textTitleColor,
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 22,
          ),
          addMedicineButton(),
          const SizedBox(
            height: 22,
          ),
        ],
      ),
    );
  }

  Widget addMedicineButton() {
    return InkWell(
      focusColor: primaryColor,
      onTap: () {
        log("Clicked on Add Medicine Button!");
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => const AddMedicine()));
      },
      child: Container(
        width: MediaQuery.of(context).size.width * 0.55,
        height: Constant.buttonHeight,
        decoration: Utility.primaryDarkButton(),
        alignment: Alignment.center,
        child: MyText(
          mTitle: tambahobat,
          mTextColor: white,
          mTextAlign: TextAlign.center,
          mFontSize: 16,
          mFontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  // Widget diagnosisSaveButton() {
  //   return InkWell(
  //     focusColor: primaryColor,
  //     onTap: () => log("Clicked on Diagnosis Save Button!"),
  //     child: Container(
  //       width: MediaQuery.of(context).size.width * 0.45,
  //       height: Constant.buttonHeight,
  //       decoration: Utility.primaryDarkButton(),
  //       alignment: Alignment.center,
  //       child: MyText(
  //         mTitle: save.toUpperCase(),
  //         mTextColor: white,
  //         mTextAlign: TextAlign.center,
  //         mFontSize: 16,
  //         mFontWeight: FontWeight.w600,
  //       ),
  //     ),
  //   );
  // }
}
