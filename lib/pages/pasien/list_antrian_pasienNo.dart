import 'package:doctorapp/apiservice/serviceapi.dart';
import 'package:doctorapp/model/usermodel.dart';
import 'package:doctorapp/pages/itemantrian.dart';
import 'package:doctorapp/pages/pasien/component/list_antrian_pasiendetail.dart';
import 'package:doctorapp/provider/auth_user.dart';
import 'package:doctorapp/utils/colors.dart';
import 'package:doctorapp/utils/constant.dart';
import 'package:doctorapp/utils/strings.dart';
import 'package:doctorapp/utils/utility.dart';
import 'package:doctorapp/widgets/mysvgassetsimg.dart';
import 'package:doctorapp/widgets/mytext.dart';
import 'package:flutter/material.dart';
import 'package:doctorapp/provider/pasien_prov.dart';
import 'package:doctorapp/model/pasienmodel.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:doctorapp/pages/pasien/component/itemantrian_pasien.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class ListingAntrianPasien extends StatefulWidget {
  const ListingAntrianPasien({Key? key}) : super(key: key);

  @override
  State<ListingAntrianPasien> createState() => _ListingAntrianPasienState();
}

class _ListingAntrianPasienState extends State<ListingAntrianPasien> {
  var _scrollControllertrans = ScrollController();
  String _hasBeenPressed = '';
  List<AntrianPasienProfile> AntrianPasienList = [];
  late FocusNode myFocusNode;
  bool typesearch = false;
  //late List<AntrianPasienProfile> listSearchIsi = [];

  @override
  void initState() {
    _hasBeenPressed = "";
    _getFirtsInfo();
    super.initState();
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

  Future<void> _getFirtsInfo() async {
    final AuthPasienData tablesProvider =
    Provider.of<AuthPasienData>(context, listen: false);

    List<AntrianPasienProfile> FirtsInfoPasienList = [];
    AntrianPasienList = tablesProvider.DataAntrian;
    //listSearchIsi = AntrianPasienList;

    print(AntrianPasienList.length.toString());
  }

  Future<void> _getSearchInfo() async {
    UserProfile _hUser = new UserProfile();
    final AuthUserData tablesProvider =
    Provider.of<AuthUserData>(context, listen: false);
    final UserProfile _user = tablesProvider.DataUser;
    _hUser = _user;

    try {
      await EasyLoading.show(status: 'search data');

      String idDokter = _hUser.userId;
      await UserApiService.getPasienAntri(_hasBeenPressed, idDokter)
          .then((antrian) {
        setState(() {
          AntrianPasienList = antrian;
        });
      });
    } catch (error) {
      await EasyLoading.dismiss();
      // showAlertDialog(
      //     context: context, title: "Error ", content: error.toString());
      return;
      //throw error;
    } finally {
      await EasyLoading.dismiss();
    }

    print(AntrianPasienList.length.toString());
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: myAppBar(),
      body: Container(
          child: Stack(
            alignment: Alignment.topLeft,
            children: [
              profile(),
              ListItemSearch(),
            ],
          )),
    );
  }
  AppBar myAppBar() {
    return AppBar(
      elevation: 0,
      centerTitle: true,
      backgroundColor: Color.fromARGB(255, 35, 163, 223),
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
        mTitle: 'List Antrian Pasien',
        mFontSize: 18,
        mFontStyle: FontStyle.normal,
        mFontWeight: FontWeight.normal,
        mTextAlign: TextAlign.center,
        mTextColor: white,
      ),
    );
  }

  Future<void> ProfileDetail() async {}
  Widget profile() {
    return FutureBuilder(
        future: ProfileDetail(),
        builder: (context, _) => Padding(
            padding: EdgeInsets.only(top: 0),
            child: Container(
              width: displayWidth(context),
              child: LayoutBuilder(builder: (context, constraints) {
                var parentHeight = constraints.maxHeight;
                var parentWidth = constraints.maxWidth;
                return SingleChildScrollView(
                    child: Column(children: [
                    Container(
                      decoration: const BoxDecoration(
                        color: Color.fromARGB(255, 35, 163, 223),
                        borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(10),
                            bottomRight: Radius.circular(10)),
                        image: DecorationImage(
                            image: AssetImage('assets/images/Design1.png'),
                            fit: BoxFit.cover),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black54,
                            blurRadius: 10,
                            offset: Offset(0,0), // Shadow position
                          ),
                        ],

                      ),
                      child: Column(
                            children: [
                              Container(
                                child: Padding(
                                  padding: const EdgeInsets.only(top: 0),
                                  child: Container(
                                    child: Padding(
                                      //padding: const EdgeInsets.all(5.0),
                                      padding:
                                      const EdgeInsets.fromLTRB(10, 0, 10, 0),
                                      child: Row(
                                          mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                          children: [
                                            Expanded(child: ItemSearch()),
                                          ],
                                        ),
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 15,
                              )//groupCategoryIsi
                            ],
                          ),
                        ),
                    ]));
              }),
            )));
  }

  @override
  Widget ItemSearch() {
    final _debouncer = WaitingType(milliseconds: 1000);
    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15)),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(15, 0, 0, 0),
        child: Center(
          child: TextFormField(
            textAlign: TextAlign.start,
            textInputAction: TextInputAction.next,
            style: TextStyle(
                color: Colors.black54,
                fontSize: 16,
                fontWeight: FontWeight.bold),
            cursorColor: Colors.white,
            decoration: const InputDecoration(
              suffixIcon: Icon(
                Icons.search_rounded,
                color: Colors.black54,
              ),
              border: InputBorder.none,
              hintText: "Cari Pasien",
              hintStyle: TextStyle(fontSize: 14.0, color: Colors.black54),

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
      ),
    );
  }

  @override
  Widget ListItemSearch() {
    return FutureBuilder<List<AntrianPasienProfile>>(
      //future: _getFirtsInfo,
        builder: (context, _) => Padding(
            padding: EdgeInsets.only(top: 70
            ), //ScreenUtil().setHeight(ScreenUtil().setWidth(10.0))),
            child: Container(
              child: LayoutBuilder(builder: (context, constraints) {
                final List<AntrianPasienProfile>? items =
                    AntrianPasienList; // listSearchIsi;
                //AntrianPasienList;
                return items!.length == 0
                    ? Center(
                    child: Column(children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 0.0),
                        child: Container(
                          height: 120,
                          width: 120,
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage(
                                      'assets/images/avatar.png'))),
                        ),
                      ),
                      SizedBox(height: 20),
                      Text(
                        "Tidak Ada Antrian Pasien\nSaat Ini",
                        textAlign: TextAlign.center,
                        style: Utility.textTitleBlack,
                      ),
                    ]))
                    : Scrollbar(
                  child: ListView.builder(
                    physics:
                    const AlwaysScrollableScrollPhysics(), //Even if zero elements to update scroll
                    itemCount: items.length,
                    scrollDirection: Axis.vertical,
                    controller: _scrollControllertrans,
                    itemBuilder: (context, index) {
                      return items[index] == null
                          ? CircularProgressIndicator()
                          : Padding(
                        padding: const EdgeInsets.only(top: 2, left: 10, right: 10),
                        child: items.length == 0
                            ? Text('tak ada data')
                            : IsiInfoSearchandFilter(
                          action: (() async {
                            Navigator.of(context).push(
                                MaterialPageRoute(
                                    builder: (context) =>
                                        DetailAntrianPasien(
                                          detailpasienProfile:
                                          items[index],
                                        )));
                          }),
                          actionhover: () {
                            MyTooltip(
                                child: Text('Oke'),
                                message: 'data');
                          },
                          infoIsi: items[index],
                          myFocusNode: myFocusNode,
                        ),
                      );
                    },
                  ),
                );
              }),
            )));
  }
}

class IsiInfoSearchandFilter extends StatelessWidget {
  final AntrianPasienProfile infoIsi;
  final Widget? prefWidget;
  final VoidCallback action;
  final VoidCallback actionhover;
  final FocusNode myFocusNode;
  const IsiInfoSearchandFilter(
      {Key? key,
        required this.infoIsi,
        required this.action,
        required this.actionhover,
        required this.myFocusNode,
        this.prefWidget})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    String urlfoto = infoIsi.url_foto_px;
    urlfoto = urlfoto.replaceAll('..', '');
    final splitted = infoIsi.jam_daftar.split(' ');

    return AnimationLimiter(
        child : Column(
            children: AnimationConfiguration.toStaggeredList(
              duration: const Duration(milliseconds: 1405),
              childAnimationBuilder: (widget) => SlideAnimation(
                verticalOffset: 90.0,
                child: FadeInAnimation(
                  child: widget,
                ),
              ),
                children: <Widget>[
              InkWell(
            onTap: () => action(),
            onHover: (val) => actionhover(),
            child: Card(
              semanticContainer: true,
              clipBehavior: Clip.antiAlias,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),

              ),
              elevation: 0,
              child:
             Container(
            child: Column(children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                      height: 30,
                      width: 110,
                      //width: MediaQuery.of(context).size.width,
                      decoration: const BoxDecoration(
                          color: Color.fromARGB(255, 35, 163, 223),
                          borderRadius: BorderRadius.only(
                              topRight: Radius.circular(15),
                              bottomLeft: Radius.circular(15))),
                      child: Column(
                        mainAxisAlignment:
                        MainAxisAlignment.spaceAround,
                        children: [
                          Text('Antrian .' + infoIsi.no_antrian,
                              style: GoogleFonts.nunito(
                                  fontSize: 12,
                                  color: white,
                                  fontWeight: FontWeight.w600)),
                        ],
                      ),
                      padding: const EdgeInsets.all(5),
                    )
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                            flex: 3,
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
                                      height: 80,
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
                                      style: GoogleFonts.nunito(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w800)),

                                  SizedBox(height: 10),
                                  Text(' Pendaftaran ',
                                      style: GoogleFonts.nunito(
                                          fontSize: 13,
                                          color: blue,
                                          fontWeight: FontWeight.w800)),
                                  SizedBox(height: 10),
                                  Column(
                                    mainAxisAlignment:
                                    MainAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                        MainAxisAlignment.start,
                                        children: [
                                          Container(
                                            child: Row(
                                              children: [
                                                Container(
                                                  //Text(text),
                                                  child: Icon(
                                                    Icons
                                                        .calendar_month,
                                                    size: 20.0,
                                                    color: blue,
                                                  ),
                                                ),
                                                Text(splitted[0])
                                              ],
                                            ),
                                          ),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          Container(
                                            child: Row(
                                              mainAxisAlignment:
                                              MainAxisAlignment
                                                  .spaceAround,
                                              children: [
                                                Container(
                                                  //Text(text),
                                                  child: Icon(
                                                    Icons
                                                        .watch_later_outlined,
                                                    size: 20.0,
                                                    color: blue,
                                                  ),
                                                ),
                                                Text(splitted[1])
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
                Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 8.0, top: 0, bottom: 10),
                      child: Text(infoIsi.no_mr,
                          style: GoogleFonts.nunito(
                              fontSize: 15,
                              color: blue,
                              fontWeight: FontWeight.w800)),
                    ))
              ]),
            )))],)));
  }
}
