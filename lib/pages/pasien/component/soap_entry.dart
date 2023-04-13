import 'dart:developer';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:doctorapp/apiservice/serviceapi.dart';
import 'package:doctorapp/model/usermodel.dart';
import 'package:doctorapp/pages/pasien/component/list_antrian_pasiendetail.dart';
import 'package:doctorapp/pages/pemeriksaan.dart';
import 'package:doctorapp/provider/auth_user.dart';
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
import 'package:flutter_tts/flutter_tts.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:doctorapp/provider/pasien_prov.dart';
import 'package:provider/provider.dart';
import 'package:highlight_text/highlight_text.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;

import '../list_hiss.dart';

class SOAPDokterUpdate extends StatefulWidget {
  const SOAPDokterUpdate({Key? key}) : super(key: key);

  @override
  State<SOAPDokterUpdate> createState() => _SOAPDokterUpdateState();
}
enum TtsState { playing, stopped }
class _SOAPDokterUpdateState extends State<SOAPDokterUpdate> {
  PeriksaPasienProfile vitalsignData = new PeriksaPasienProfile();
  var _scrollControllerdet = ScrollController();
  final _formKey = GlobalKey<FormState>();

  FlutterTts flutterTts = FlutterTts();
  TextEditingController controller = TextEditingController();
  String _dropDownValue = 'id-ID';
  speech(String input) async {
    await flutterTts.setLanguage(_dropDownValue);
    await flutterTts.stop();
    await flutterTts.speak(input);

  }

  TextEditingController signSubyektif = TextEditingController();
  TextEditingController signObyektif = TextEditingController();
  TextEditingController signAnamnese = TextEditingController();


  late stt.SpeechToText _speech;
  FlutterTts tts = FlutterTts();
  String _platformVersion = 'Unknown';
  bool _isListening = false;
  bool _preparationProcess = false;
  String _text = '';
  double _confidence = 1.0;

  void _listen() async {
    if (!_isListening) {
      bool available = await _speech.initialize(
        onStatus: (val) {
          print('onStatus: $val');

          if (val == 'listening') {
            setState(() {
              _isListening = false;
              _preparationProcess = false;
            });
          } else {
            setState(() {
              _isListening = false;
            });
          }
        },
        onError: (val) {
          print('onError: $val');
          setState(() {
            _isListening = false;
            _preparationProcess = false;
          });
        },
      );


      if (available) {
        _speech.listen(
          onResult: (val) => setState(() {
            _text = val.recognizedWords;
            if (val.hasConfidenceRating && val.confidence > 0) {
              _confidence = val.confidence;
            }
            if (!_isListening && _preparationProcess) {
              _speech.stop();
              _speak();
              setState(() {
                _preparationProcess = false;
              });
            }
          }),
          localeId: "id-ID",
        );
      }
    }
  }



  void _speak() async {
    if (!mounted) return;

    tts.setLanguage('id-ID');
    await tts.speak(_text);
    print(_text);
  }

  TtsState ttsState = TtsState.stopped;

  get isPlaying => ttsState == TtsState.playing;

  get isStopped => ttsState == TtsState.stopped;

  @override
  void initState() {
    _getUserProvider();
    super.initState();
    _speech = stt.SpeechToText();
    initTts();
  }
  initTts() {
    flutterTts = FlutterTts();
    flutterTts.setStartHandler(() {
      setState(() {
        print("playing");
        ttsState = TtsState.playing;
      });
    });

    flutterTts.setCompletionHandler(() {
      setState(() {
        print("Complete");
        ttsState = TtsState.stopped;
      });
    });

    flutterTts.setErrorHandler((msg) {
      setState(() {
        print("error: $msg");
        ttsState = TtsState.stopped;
      });
    });
  }

  Future _stop() async {
    var result = await flutterTts.stop();
    if (result == 1) setState(() => ttsState = TtsState.stopped);
  }
  @override
  void dispose() {
    super.dispose();
    flutterTts.stop();
  }
  _getUserProvider() async {
    final AuthPasienData tablesProvider =
    Provider.of<AuthPasienData>(context, listen: false);
    vitalsignData = tablesProvider.DataPeriksa;

    signSubyektif.text = vitalsignData.subjektif;
    signObyektif.text = vitalsignData.objektif;
    signAnamnese.text = vitalsignData.assesment;
  }



  void _onChange(String text) {
    setState(() {
      _text = text;
    });
  }

  @override
  Widget build(BuildContext context) {
    print("BUILD STATE");
    print("_isListening $_isListening");
    print("_preparationProcess $_preparationProcess");

    return Container(
      child: Stack(children: [
        Positioned(
          top: 5,
          right: 10,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 150.0),
            child: Container(
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 238, 236, 236),
                borderRadius: BorderRadius.circular(200),
              ),
              height: 8.0,
              width: 60.0,
              //color: Colors.grey,
            ),
          ),
        ),
        Padding(
            padding: const EdgeInsets.only(top: 10),
            child: Form(
                key: _formKey,
                child: Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20),
                  child: ListView(children: <Widget>[
                    SizedBox(
                      height: 20,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children :[
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: RichText(
                            text: TextSpan(
                                text: 'Update ',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Color.fromARGB(255, 39, 28, 1),
                                ),
                                children: [
                                  TextSpan(
                                    text: 'SOAP',
                                    style: TextStyle(
                                      fontSize: 20,
                                      letterSpacing: 2,
                                      color: Colors.blue,
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
                            Padding(
                              padding: const EdgeInsets.only(bottom: 15.0),
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [

                                    ],
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Row(
                                    children: [
                                      Expanded(
                                        child: TextField(
                                          controller: signSubyektif,
                                          maxLines: 6,
                                          decoration: InputDecoration(
                                            border: OutlineInputBorder(),
                                            labelText: 'Subyektif',
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(left: 15.0),
                                        child: Column(
                                        children: [
                                          FloatingActionButton(
                                            onPressed:_listen,
                                            child: Icon(_isListening ? Icons.mic : Icons.mic_none),
                                            backgroundColor: _isListening ? Colors.blue : Colors.green,
                                          ),
                                          const SizedBox(
                                            height: 20,
                                          ),
                                          FloatingActionButton(
                                            onPressed: () {
                                              setState(() {
                                                speech(signSubyektif.text);
                                              });
                                            },
                                            child: Icon(_isListening ? Icons.volume_off_rounded : Icons.volume_up_rounded),
                                            backgroundColor: _isListening ?  Colors.red : Colors.blue,
                                          ),
                                        ],
                                      ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),

                          ],),],),
                    Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [

                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(bottom: 15.0),
                                child: Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [

                                      ],
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Row(
                                      children: [
                                        Expanded(
                                          child: TextField(
                                            onChanged: (String value) {
                                              _onChange(value);
                                            },
                                            controller: signObyektif,
                                            maxLines: 6,
                                            decoration: InputDecoration(
                                              border: OutlineInputBorder(),
                                              labelText: 'Obyektif',
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(left: 15.0),
                                          child: Column(
                                          children: [
                                            FloatingActionButton(
                                              onPressed:_listen,
                                              child: Icon(_isListening ? Icons.mic : Icons.mic_none),
                                              backgroundColor: _isListening ? Colors.blue : Colors.green,
                                            ),
                                            const SizedBox(
                                              height: 20,
                                            ),
                                            FloatingActionButton(
                                              onPressed: () {
                                                setState(() {
                                                  speech(signObyektif.text);
                                                });
                                              },
                                              child: Icon(_isListening ? Icons.volume_off_rounded : Icons.volume_up_rounded),
                                              backgroundColor: _isListening ?  Colors.red : Colors.blue,
                                            ),
                                          ],
                                        ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),


                            ],),
                          //batas
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(bottom: 405.0),
                                child: Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                      ],
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Row(
                                      children: [
                                        Expanded(
                                          child: TextField(
                                            controller: signAnamnese,
                                            maxLines: 6,
                                            decoration: InputDecoration(
                                              border: OutlineInputBorder(),
                                              labelText: 'Anamnese',
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(left: 15.0),
                                          child: Column(
                                          children: [
                                            FloatingActionButton(
                                              onPressed:_listen,
                                              child: Icon(_isListening ? Icons.mic : Icons.mic_none),
                                              backgroundColor: _isListening ? Colors.blue : Colors.green,
                                            ),
                                            const SizedBox(
                                              height: 20,
                                            ),
                                            FloatingActionButton(
                                              onPressed: () {
                                                setState(() {
                                                  speech(signAnamnese.text);
                                                });
                                              },
                                              child: Icon(_isListening ? Icons.volume_off_rounded : Icons.volume_up_rounded),
                                              backgroundColor: _isListening ?  Colors.red : Colors.blue,
                                            ),

                                          ],
                                        ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 40,
                                    ),
                                    ElevatedButton(
                                      child: MyText(
                                        mTitle: 'Submit',
                                        mFontSize: 16,
                                        mOverflow: TextOverflow.ellipsis,
                                        mMaxLine: 1,
                                        mFontWeight: FontWeight.bold,
                                        mTextAlign: TextAlign.start,
                                        mTextColor: white,
                                      ),
                                      onPressed: () async {
                                        await updateData();
                                      },
                                      style: ElevatedButton.styleFrom(
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                            BorderRadius.circular(
                                                10.0),
                                          ),
                                          primary: Color.fromRGBO(
                                              38, 153, 249, 1),
                                          textStyle: TextStyle(
                                              fontSize: 17,
                                              fontWeight:
                                              FontWeight.w700)),
                                    ),
                                  ],
                                ),
                              ),
                            ],),

                        ]),



                  ],
                  ),
                ))),
        Padding(
          padding: const EdgeInsets.only(top:567.0, right: 30, left: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[


            ],
          ),
        )
      ]),
    );

  }

  Future updateData() async {
    final AuthPasienData tablesProvider =
    Provider.of<AuthPasienData>(context, listen: false);
    vitalsignData = tablesProvider.DataPeriksa;

    final AuthUserData dokterProvider =
    Provider.of<AuthUserData>(context, listen: false);
    UserProfile dokter = dokterProvider.DataUser;
    AntrianPasienProfile vitalsignDataProfile =
        tablesProvider.DataPeriksaProfile;


    vitalsignDataProfile.dokterid = dokter.userId;
    vitalsignData.subjektif = signSubyektif.text;
    vitalsignData.objektif = signObyektif.text;
    vitalsignData.assesment = signAnamnese.text;

    //update to APi
    //if success set to provider

    bool ok = await UserApiService.postvitalSOAPPasienAntri(
        vitalsignData, vitalsignDataProfile);

    tablesProvider.setDataPeriksa(vitalsignData);

    if (ok) {
      Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => DetailAntrianPasien(
            detailpasienProfile: vitalsignDataProfile,
          )));
    } else {
      await AwesomeDialog(
        context: context,
        dialogType: DialogType.INFO,
        animType: AnimType.SCALE,
        title: 'Data Tidak Valid',
        desc: 'cek data entry kembali',
        autoHide: const Duration(seconds: 5),
      ).show();
      return;
    }
  }
}

class _highlights {
}
