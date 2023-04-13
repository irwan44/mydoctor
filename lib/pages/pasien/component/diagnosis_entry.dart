import 'dart:developer';

import 'package:doctorapp/apiservice/serviceapi.dart';
import 'package:doctorapp/pages/pemeriksaan.dart';
import 'package:doctorapp/utils/colors.dart';
import 'package:doctorapp/utils/constant.dart';
import 'package:doctorapp/utils/strings.dart';
import 'package:doctorapp/utils/utility.dart';
import 'package:doctorapp/widgets/mynetworkimg.dart';
import 'package:doctorapp/widgets/mysvgassetsimg.dart';
import 'package:doctorapp/widgets/mytext.dart';
import 'package:doctorapp/widgets/mytextformfield.dart';
import 'package:flutter/material.dart';
import 'package:doctorapp/model/periksamodel.dart';
import 'package:doctorapp/model/pasienmodel.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:doctorapp/provider/pasien_prov.dart';
import 'package:provider/provider.dart';

class DiagnosisUpdate extends StatefulWidget {
  const DiagnosisUpdate({Key? key}) : super(key: key);

  @override
  State<DiagnosisUpdate> createState() => _DiagnosisUpdateState();
}

class _DiagnosisUpdateState extends State<DiagnosisUpdate> {
  PeriksaPasienProfile vitalsignData = new PeriksaPasienProfile();
  var _scrollControllerdet = ScrollController();
  final _formKey = GlobalKey<FormState>();

  TextEditingController signSubyektif = TextEditingController();
  TextEditingController signObyektif = TextEditingController();
  TextEditingController signAnamnese = TextEditingController();

  @override
  void initState() {
    _getUserProvider();
    super.initState();
  }

  _getUserProvider() async {
    final AuthPasienData tablesProvider =
        Provider.of<AuthPasienData>(context, listen: false);
    vitalsignData = tablesProvider.DataPeriksa;

    signSubyektif.text = "";

    signObyektif.text = vitalsignData.objektif;
    signAnamnese.text = vitalsignData.assesment;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: white,
        body: Stack(children: [
          Padding(
            padding: const EdgeInsets.only(top: 18),
            child: Form(
                key: _formKey,
                child: Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20),
                  child: ListView(children: <Widget>[
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 170.0),
                      child: Container(
                        decoration: BoxDecoration(
                            color: Color.fromARGB(255, 238, 236, 236),
                            borderRadius: BorderRadius.circular(200),
                            border: Border.all(
                                width: 1,
                                color: Color.fromARGB(255, 34, 33, 33))),
                        height: 10.0,
                        width: 20.0,
                        //color: Colors.grey,
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: RichText(
                        text: TextSpan(
                            text: 'Diagnosa ',
                            style: TextStyle(
                              fontSize: 25,
                              letterSpacing: 2,
                              color: Colors.yellow[700],
                            ),
                            children: [
                              TextSpan(
                                text: 'Pasien ',
                                style: TextStyle(
                                  fontSize: 25,
                                  fontWeight: FontWeight.bold,
                                  color: Color.fromARGB(255, 39, 28, 1),
                                ),
                              )
                            ]),
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Text('Hasil Diagnosa',
                        //     style: GoogleFonts.poppins(
                        //         fontSize: 16, fontWeight: FontWeight.w800)),

                        MyTextFormFieldEntry(
                          mController: signSubyektif, //mEmailController,
                          mObscureText: false,
                          mMaxLine: 10,
                          mHintTextColor: textHintColor,
                          mTextColor: otherColor,
                          mkeyboardType: TextInputType.text,
                          mTextInputAction: TextInputAction.next,
                          mWidth: 500,
                          mHeight: 200,
                          //mInputBorder: InputBorder.,
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          Container(
                              child: SizedBox(
                            width: 100,
                            height: 40,
                            child: FittedBox(
                                child: FloatingActionButton.extended(
                              onPressed: () async {},
                              icon: const Icon(Icons.edit),
                              label: const Text('Submit'),
                              backgroundColor: Colors.redAccent,
                            )),
                          )),
                        ],
                      ),
                    )
                  ]),
                )),
          )
        ]));
  }
}
