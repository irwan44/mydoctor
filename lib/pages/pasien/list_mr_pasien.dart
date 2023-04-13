import 'package:doctorapp/apiservice/serviceapi.dart';
import 'package:doctorapp/model/usermodel.dart';
import 'package:doctorapp/pages/itemantrian.dart';
import 'package:doctorapp/pages/pasien/component/list_antrian_pasiendetail.dart';
import 'package:doctorapp/pages/pasien/component/medrecord_pasien.dart';
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
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:doctorapp/pages/pasien/component/itemantrian_pasien.dart';
//import 'package:pluto_grid/pluto_grid.dart';

class ListingMRPasien extends StatefulWidget {
  const ListingMRPasien({Key? key}) : super(key: key);

  @override
  State<ListingMRPasien> createState() => _ListingMRPasienState();
}

class _ListingMRPasienState extends State<ListingMRPasien> {
  var _scrollControllertrans = ScrollController();
  String _hasBeenPressed = '';
  List<AntrianPasienProfile> AntrianPasienList = [];
  late List<AntrianPasienProfile> listSearchIsi = [];
  bool searchSts = false;

  @override
  void initState() {
    _hasBeenPressed = "";
    _getFirtsInfo();
    super.initState();
  }

  Future<void> _getFirtsInfo() async {
    final AuthPasienData tablesProvider =
        Provider.of<AuthPasienData>(context, listen: false);

    List<AntrianPasienProfile> FirtsInfoPasienList = [];
    AntrianPasienList = tablesProvider.DataAntrian;
    listSearchIsi = [];
    // AntrianPasienList;
  }

  Future<void> _getSearchInfo() async {
    UserProfile _hUser = new UserProfile();
    final AuthUserData tablesProvider =
        Provider.of<AuthUserData>(context, listen: false);
    final UserProfile _user = tablesProvider.DataUser;
    _hUser = _user;

    String idDokter = _hUser.userId;
    await UserApiService.getPasienAntri(_hasBeenPressed, idDokter)
        .then((antrian) {
      setState(() {
        listSearchIsi = antrian;
      });
    });

    print(listSearchIsi.length.toString());
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    // final AuthPasienData tablesProvider =
    //     Provider.of<AuthPasienData>(context, listen: false);

    // List<AntrianPasienProfile> FirtsInfoPasienList = [];

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
              // Positioned(
              //     top: 20,
              //     child: Container(
              //       height: 100,
              //       child: Text('List Antrian Pasien'),
              //     )),
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
                                  setState(() {
                                    searchSts = true;
                                  });
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
                        padding: const EdgeInsets.fromLTRB(8, 0, 0, 20),
                        child: ListItemSearch(),
                      ))))
            ],
          )),
    );
  }

  @override
  Widget ItemSearch() {
    return Container(
      decoration: BoxDecoration(
        color: white,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: gray),
        boxShadow: [
          BoxShadow(
            color: gray.withOpacity(0.5), //color of shadow
            spreadRadius: 2, //spread radius
            blurRadius: 10, // blur radius
            offset: Offset(0, 1), // changes position of shadow
          ),
        ],
      ),
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
            hintText: "Cari Pasien",
            //filled: true,
            //fillColor: Color.fromARGB(255, 238, 232, 232)
          ),
          onChanged: (data) {
            _hasBeenPressed = data;
            // final UserDataLain tablesProvider =
            //     Provider.of<UserDataLain>(context, listen: false);
            // _hUser.Subtitle = data.toString();
            // tablesProvider.setSearchParam(_hUser);
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
          imgHeight: 15,
          imgWidth: 19,
        ),
      ),
      title: MyText(
        mTitle: 'Pencarian MR Pasien',
        mFontSize: 20,
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
              top: 10, //ScreenUtil().setHeight(ScreenUtil().setHeight(10)),
              left: 10,
            ), //ScreenUtil().setHeight(ScreenUtil().setWidth(10.0))),
            child: Container(
              height: double.infinity * 0.7,
              width: double.infinity, //  displayWidth(context),
              child: LayoutBuilder(builder: (context, constraints) {
                var parentHeight = constraints.maxHeight;
                var parentWidth = constraints.maxWidth;
                final List<AntrianPasienProfile>? items = listSearchIsi;
                //AntrianPasienList;
                return items!.length == 0
                    ? Center(
                        child: searchSts == false
                            ? Container()
                            : Column(children: [
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
                                    padding: const EdgeInsets.all(15.0),
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
                                            infoIsi: items[index],
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
                                            ' Pendaftaran ' +
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

// class IsiGridInfoSearchandFilter extends StatefulWidget {
//   final AntrianPasienProfile infoIsi;
//   final Widget? prefWidget;
//   final VoidCallback action;
//   const IsiGridInfoSearchandFilter(
//       {Key? key, required this.infoIsi, required this.action, this.prefWidget})
//       : super(key: key);

//   @override
//   State<IsiGridInfoSearchandFilter> createState() =>
//       _IsiGridInfoSearchandFilterState();
// }

// class _IsiGridInfoSearchandFilterState
//     extends State<IsiGridInfoSearchandFilter> {
//   final List<PlutoColumn> datacolumns = <PlutoColumn>[
//     PlutoColumn(
//       title: 'No',
//       field: 'No',
//       type: PlutoColumnType.number(),
//     ),
//     PlutoColumn(
//       title: 'Pasien',
//       field: 'column5',
//       type: PlutoColumnType.text(),
//       enableEditingMode: false,
//       renderer: (rendererContext) {
//         return Text('data');
//       },
//     ),
//   ];

//   late final PlutoGridStateManager stateManager;
//   late List<PlutoRow> rowsData = [];

//   @override
//   Widget build(BuildContext context) {
//     return SingleChildScrollView(
//       child: Padding(
//         padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
//         child: Column(
//           children: [
//             const SizedBox(
//               height: 2,
//             ),
//             Container(
//                 height: MediaQuery.of(context).size.height * 0.65,
//                 width: MediaQuery.of(context).size.width,
//                 child: Padding(
//                   padding: const EdgeInsets.all(8.0),
//                   child: PlutoGrid(
//                     columns: datacolumns,
//                     //rows: rowsData == null ? [] : rowsData,
//                     rows: rowsData,
//                     onLoaded: (PlutoGridOnLoadedEvent event) {
//                       stateManager = event.stateManager;

//                       event.stateManager
//                           .setSelectingMode(PlutoGridSelectingMode.cell);

//                       stateManager = event.stateManager;
//                     },
//                     onChanged: (PlutoGridOnChangedEvent event) {
//                       print(event);
//                       stateManager.setAutoEditing(true);
//                     },
//                     configuration: const PlutoGridConfiguration(
//                         //enableColumnBorder: true,

//                         ),
//                     //onRowChecked: ,
//                     // onChanged: (PlutoGridOnChangedEvent event) {
//                     //   print(event);
//                     //}
//                   ),
//                 ))
//           ],
//         ),
//       ),
//     );
//   }

//   Widget isiRenderGrid() {
//     String urlfoto = widget.infoIsi.url_foto_px;
//     urlfoto = urlfoto.replaceAll('..', '');
//     return InkWell(
//         onTap: () => widget.action(),
//         child: Container(
//             height: 100,
//             width: 390,
//             child: IntrinsicHeight(
//                 child: Card(
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(0),
//                     ),
//                     shadowColor: Color.fromARGB(255, 198, 240, 11),
//                     elevation: 4,
//                     child: Padding(
//                       padding: const EdgeInsets.all(8.0),
//                       child: Column(children: <Widget>[
//                         Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                             children: [
//                               Expanded(
//                                   flex: 2,
//                                   child: Column(
//                                       crossAxisAlignment:
//                                           CrossAxisAlignment.start,
//                                       children: [
//                                         ClipRRect(
//                                           borderRadius:
//                                               BorderRadius.circular(6),
//                                           child: FadeInImage.assetNetwork(
//                                             placeholder:
//                                                 'assets/images/avatar.png',
//                                             image:
//                                                 urlfoto, //infoIsi.url_foto_px,
//                                             fit: BoxFit.cover,
//                                             width: 120,
//                                             height: 60,
//                                             imageErrorBuilder:
//                                                 (context, url, error) =>
//                                                     Icon(Icons.error),
//                                           ),
//                                         ),
//                                       ])),
//                               SizedBox(
//                                 width: 20,
//                               ),
//                               Expanded(
//                                   flex: 8,
//                                   child: Column(
//                                       crossAxisAlignment:
//                                           CrossAxisAlignment.start,
//                                       children: [
//                                         Text(widget.infoIsi.nama_px,
//                                             style: GoogleFonts.poppins(
//                                                 fontSize: 16,
//                                                 fontWeight: FontWeight.w800)),
//                                         new SizedBox(
//                                           height: 4,
//                                           child: new Center(
//                                             child: new Container(
//                                               margin: new EdgeInsetsDirectional
//                                                   .only(start: 1.0, end: 1.0),
//                                               height: 2.0,
//                                               color: const Color.fromARGB(
//                                                   255, 241, 187, 183),
//                                             ),
//                                           ),
//                                         ),
//                                         SizedBox(height: 5),
//                                         Text(
//                                             ' No Antrian ' +
//                                                 widget.infoIsi.no_antrian,
//                                             style: GoogleFonts.poppins(
//                                                 fontSize: 14,
//                                                 fontWeight: FontWeight.w600)),
//                                         SizedBox(height: 2),
//                                         Text(
//                                             ' Pendafatran ' +
//                                                 widget.infoIsi.jam_daftar,
//                                             style: GoogleFonts.poppins(
//                                                 fontSize: 12,
//                                                 fontWeight: FontWeight.w400)),
//                                       ]))
//                             ])
//                       ]),
//                     )))));
//   }
// }
