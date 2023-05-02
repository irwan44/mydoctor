import 'package:doctorapp/apiservice/serviceapi.dart';
import 'package:doctorapp/model/usermodel.dart';
import 'package:doctorapp/pages/itemantrian.dart';
import 'package:doctorapp/pages/pasien/component/list_antrian_pasiendetail.dart';
import 'package:doctorapp/pages/pasien/component/medrecord_pasien.dart';
import 'package:doctorapp/pages/pasien/component/medrecord_pasien_det.dart';
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
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:doctorapp/pages/pasien/component/itemantrian_pasien.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class ListingCariMRPasienAll extends StatefulWidget {
  const ListingCariMRPasienAll({Key? key}) : super(key: key);

  @override
  State<ListingCariMRPasienAll> createState() => _ListingCariMRPasienAllState();
}

class _ListingCariMRPasienAllState extends State<ListingCariMRPasienAll> {
  var _scrollControllertrans = ScrollController();
  String _hasBeenPressed = '';
  List<AntrianPasienProfile> AntrianPasienList = [];
  late FocusNode myFocusNode;
  bool typesearch = false;
  bool firstsearch = true;
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
    AntrianPasienList = [];
  }

  Future<void> _getSearchInfo() async {
    UserProfile _hUser = new UserProfile();
    final AuthUserData tablesProvider =
    Provider.of<AuthUserData>(context, listen: false);
    final UserProfile _user = tablesProvider.DataUser;
    _hUser = _user;
    firstsearch = false;
    List<AntrianPasienProfile> antrian;
    try {
      await EasyLoading.show(status: 'search data');
      String idDokter = _hUser.userId;

      List<AntrianPasienProfile> antrian = [];
      AntrianPasienList = antrian;

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
  Widget buildss(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      // appBar: AppBar(
      //   //backgroundColor: MyColors.green,
      //   title: tabBar(),
      // ),
      appBar: myAppBar(),
      body: Container(
          width: size.width,
          child: Stack(
            alignment: Alignment.topLeft,
            children: [
              Container(
                width: size.width,
                height: size.height,
                decoration: const BoxDecoration(
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
              ),
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
                            //Spacer(),
                            Expanded(
                              flex: 1,
                              child: GestureDetector(
                                onTap: () async {
                                  await _getSearchInfo();
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(10)),
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
                            padding: const EdgeInsets.fromLTRB(0, 0, 0, 20),
                            child: ListItemSearch(),
                          ))))
            ],
          )),
    );
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
        color: white,
        borderRadius: BorderRadius.circular(15),

      ),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
        child: TextFormField(
          textAlign: TextAlign.start,
          textInputAction: TextInputAction.next,
          autofocus: true,
          style: TextStyle(
              color: Color.fromARGB(255, 19, 1, 1),
              fontSize: 16,
              fontWeight: FontWeight.bold),
          cursorColor: Colors.blue,
          decoration: const InputDecoration(
            suffixIcon: Icon(
              Icons.people_rounded,
              color: Color.fromARGB(255, 14, 13, 13),
            ),
            border: InputBorder.none,
            hintText: "Cari Pasien",
            // filled: true,
            // fillColor: Color.fromARGB(255, 238, 232, 232)
          ),
          onChanged: (data) {
            _hasBeenPressed = data;
            typesearch = true;
            _debouncer.run(() async {
              print('ini yah ' + typesearch.toString());
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
  Widget ListItemSearch() {
    return FutureBuilder<List<AntrianPasienProfile>>(
      //future: _getFirtsInfo,
        builder: (context, _) => Padding(
            padding: EdgeInsets.only(
              top: 70,
            ), //ScreenUtil().setHeight(ScreenUtil().setWidth(10.0))),
            child: Container(
              height: double.infinity * 0.7,
              width: double.infinity, //  displayWidth(context),
              child: LayoutBuilder(builder: (context, constraints) {
                var parentHeight = constraints.maxHeight;
                var parentWidth = constraints.maxWidth;
                final List<AntrianPasienProfile>? items =
                    AntrianPasienList; // listSearchIsi;
                //AntrianPasienList;
                return items!.length == 0 && firstsearch
                    ? Center(
                    child: Column(children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 100.0, right: 50, left:  50),
                        child: Container(
                          height: 140,
                          width: 140,
                          child: SvgPicture.asset(
                            'assets/images/illustration.svg',
                            height: 20.0,
                            width: 20.0,
                            allowDrawingOutsideViewBox: true,
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
                      Text(
                        "Lakukan Pencarian MR",
                        textAlign: TextAlign.center,
                        style: GoogleFonts.poppins(
                            fontSize: 15, fontWeight: FontWeight.w800),
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
                        padding: const EdgeInsets.all(1.0),
                        child: items.length == 0
                            ? Text('tak ada data')
                            : IsiInfoSearchandFilter(
                          action: (() async {
                            Navigator.of(context).push(
                                MaterialPageRoute(
                                    builder: (context) =>
                                        MedicalRecPasienList(
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
                      child: Container(
                          height: 150,
                          child: IntrinsicHeight(
                              child: Card(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15),
                                  ),

                                  elevation: 0,
                                  child: Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: Column(children: <Widget>[
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
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
                                                            height: 100,
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
                                                              margin:
                                                              new EdgeInsetsDirectional
                                                                  .only(
                                                                  start: 1.0, end: 1.0),
                                                              height: 2.0,
                                                              color: const Color.fromARGB(
                                                                  255, 241, 187, 183),
                                                            ),
                                                          ),
                                                        ),
                                                        SizedBox(height: 15),
                                                        Text('Nomor Medical Record',
                                                            style: GoogleFonts.poppins(
                                                                fontSize: 13,
                                                                color: black,
                                                                fontWeight: FontWeight.w800)),
                                                        SizedBox(height: 12),
                                                        Column(
                                                          mainAxisAlignment:
                                                          MainAxisAlignment.start,
                                                          children: [
                                                            Row(
                                                              mainAxisAlignment:
                                                              MainAxisAlignment.start,
                                                              children: [
                                                                Align(
                                                                    alignment:
                                                                    Alignment.centerLeft,
                                                                    child: Padding(
                                                                      padding:
                                                                      const EdgeInsets
                                                                          .only(
                                                                          left: 0.0),
                                                                      child: Text(
                                                                          infoIsi.no_mr,
                                                                          style: GoogleFonts
                                                                              .poppins(
                                                                              fontSize:
                                                                              13,
                                                                              color: blue,
                                                                              fontWeight:
                                                                              FontWeight
                                                                                  .w800)),
                                                                    ))
                                                              ],
                                                            )
                                                          ],
                                                        )
                                                      ]))
                                            ]),
                                      ),
                                    ]),
                                  )))))])));
  }
}
