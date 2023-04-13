import 'dart:convert';

import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:dio/dio.dart';
import 'package:doctorapp/pages/pasien/list_cari_mr_allpasien.dart';
import 'package:doctorapp/utils/colors.dart';
import 'package:doctorapp/utils/utility.dart';
import 'package:doctorapp/widgets/my_colors.dart';
import 'package:doctorapp/widgets/my_font_size.dart';
import 'package:doctorapp/widgets/mytext.dart';
import 'package:flutter/material.dart';
import 'package:doctorapp/widgets/custom_card.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:doctorapp/provider/auth_user.dart';
import 'package:doctorapp/model/usermodel.dart';
import 'package:doctorapp/model/pasienmodel.dart';
import 'package:doctorapp/apiservice/serviceapi.dart';
import 'package:doctorapp/provider/pasien_prov.dart';
import 'package:provider/provider.dart';
import 'package:doctorapp/pages/pasien/list_antrian_pasienNo.dart';
import 'package:text_scroll/text_scroll.dart';
import '../../model/dataHomePageModel.dart';
import '../../widgets/mysvgassetsimg.dart';
import '../dictionaryhiss.dart';
import 'package:http/http.dart' as http;

import '../pendapatan_dokter.dart';


class HomeF extends StatefulWidget {
  final UserProfile detailpasienProfile;
  const HomeF({Key? key, required this.detailpasienProfile}) : super(key: key);

  @override
  State<HomeF> createState() => _HomeFState();
}

class _HomeFState extends State<HomeF> {
  bool _slowAnimations = false;
  UserProfile _hUser = new UserProfile();
  List<AntrianPasienProfile> _hAntrian = [];

  @override
  void initState() {
    _getUserProvider();
    super.initState();
  }

  _getUserProvider() async {
    final AuthUserData tablesProvider =
    Provider.of<AuthUserData>(context, listen: false);
    final UserProfile _user = tablesProvider.DataUser;
    _hUser = _user;

    String idDokter = _hUser.userId;
    _hAntrian = await UserApiService.getPasienAntri('', idDokter);
    Provider.of<AuthPasienData>(context, listen: false)
        .setDataAntrian(_hAntrian);
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: myHomePage(),
    );
  }

  Widget myHomePage() {
    return Container(
        child : Column(
          children: AnimationConfiguration.toStaggeredList(
            duration: const Duration(milliseconds: 1000),
            childAnimationBuilder: (widget) => ScaleAnimation(
              child: FadeInAnimation(
                child: widget,
              ),
            ),
            children: <Widget>[
              Column(
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  doctorDetails(),
                  const SizedBox(
                    height: 0,
                  ),
                  FutureBuilder<GetHomePage>(
                      future: UserApiService.getHomePage(bulan: '02', idDokter: '74'),
                      builder: (context, snapshot) {
                        if (snapshot.hasData && snapshot.data != null &&
                            snapshot.connectionState != ConnectionState.waiting) {
                          GetHomePage data = snapshot.data!;
                          return Container(
                              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 35),
                              width: MediaQuery
                                  .of(context)
                                  .size
                                  .width * 1,
                              height: 140,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(.05),
                                      blurRadius: 8,
                                      spreadRadius: 3,
                                      offset: Offset(0, 10),
                                    ),
                                  ],
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(10),
                                    bottomLeft: Radius.circular(50),
                                  )),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            children: [
                                              Text(
                                                "Pendapatan Bulan " + data.list![0].periode!,
                                                style: TextStyle(
                                                    color: Colors.grey,
                                                    fontWeight: FontWeight.bold),
                                              ),
                                              SizedBox(
                                                width: 10,
                                                height: 5,
                                              ),
                                              // Icon(
                                              //   Icons.arrow_upward,
                                              //   color: Color(0XFF00838F),
                                              // )
                                            ],
                                          ),
                                          SizedBox(
                                            height: 5,
                                          ),
                                          Text(
                                            "Rp. " + data.list![0].pendapatan.toString(),
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 18.0,
                                                color: Colors.black87),
                                          )
                                        ],
                                      ),
                                      // Container(width: 1, height: 50, color: Colors.grey),
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            children: [
                                              // Text(
                                              //   "Pendapatan",
                                              //   style: TextStyle(
                                              //       color: Colors.grey,
                                              //       fontWeight: FontWeight.bold),
                                              // ),
                                              SizedBox(
                                                width: 10,
                                              ),
                                              // Icon(
                                              //   Icons.arrow_downward,
                                              //   color: Color(0XFF00838F),
                                              // )
                                            ],
                                          ),
                                          SizedBox(
                                            height: 5,
                                          ),
                                          // Text(
                                          //   "Rp. " + data.list![0].pendapatan.toString(),
                                          //   style: TextStyle(
                                          //       fontWeight: FontWeight.bold,
                                          //       fontSize: 18.0,
                                          //       color: Colors.black87),
                                          // )
                                        ],
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  TextScroll(
                                    "Anda mendapatkan Rp." + data.list![0].pendapatan.toString() + " pada bulan " +  data.list![0].periode! +  " lihat statistik biaya untuk periode ini",
                                    intervalSpaces: 10,
                                    velocity: Velocity(pixelsPerSecond: Offset(5, 0)),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Container(
                                    height: 1,
                                    width: double.maxFinite,
                                    color: Colors.grey.withOpacity(0.5),
                                  ),
                                  SizedBox(
                                    height: 15,
                                  ),
                            InkWell(
                              child:  Container(
                                alignment: Alignment.centerRight,
                                child: Text(
                                  "Lihat Pendapatan",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Color(0XFF00B686)),
                                ),
                              ),
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => HomeScreen()));
                              },
                            ),
                                  // Container(
                                  //   alignment: Alignment.centerRight,
                                  //   child: Text(
                                  //     "Lihat Pendapatan",
                                  //     style: TextStyle(
                                  //         fontWeight: FontWeight.bold,
                                  //         color: Color(0XFF00B686)),
                                  //   ),
                                  // )
                                ],
                              ),
                            );
                        }else {
                          return Center(child: CircularProgressIndicator(),);
                        }
                      }
                  ),
                  const SizedBox(height: 10,),
                  FutureBuilder<GetHomePage>(
                      future: UserApiService.getHomePage(bulan: '02', idDokter: '74'),
                      builder: (context, snapshot) {
                        if (snapshot.hasData && snapshot.data != null &&
                            snapshot.connectionState != ConnectionState.waiting) {
                          GetHomePage data = snapshot.data!;
                          return
                            CustomCard(
                                shadow: false,
                                bgColor: Colors.white,
                                borderRadius: BorderRadius.circular(0),
                                child : Column(
                                    children: [
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Text(
                                        'Appointment Doctor',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                            Padding(
                                padding: const EdgeInsets.fromLTRB(16, 10, 16, 10),
                                child: StaggeredGrid.count(
                                  crossAxisCount: 3,
                                  mainAxisSpacing: 20,
                                  crossAxisSpacing: 10,
                                  children: [
                                    CustomCard(
                                      shadow: false,
                                      width: double.infinity,
                                      bgColor: MyColors.white,
                                      borderRadius: BorderRadius.circular(15),
                                      padding: EdgeInsets.only(bottom: 10, top: 5,left: 6),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                          Row(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              mainAxisSize: MainAxisSize.max,
                                              children: <Widget>[
                                                CustomCard(
                                                    shadow: false,
                                                    height: 50,
                                                    width: 40,
                                                    bgColor: blue,
                                                    borderRadius: BorderRadius.circular(10),
                                                    child: Center(
                                                      child:   MyText(
                                                        mTitle: data.list![0].jmlKunjungan! ,
                                                        mTextAlign: TextAlign.start,
                                                        mTextColor: Colors.white,
                                                        mFontSize: 22,
                                                        mFontStyle: FontStyle.normal,
                                                        mFontWeight: FontWeight.bold,
                                                      ),)
                                                ),
                                                SizedBox(
                                                  width: 15,
                                                ),
                                                Container(
                                                  padding: const EdgeInsets.only(top: 10),
                                                ),
                                              ]
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          TextScroll(
                                            'Jumlah Kunjungan Hari ini',
                                            intervalSpaces: 10,
                                            velocity: Velocity(pixelsPerSecond: Offset(5, 0)),
                                          ),
                                          SizedBox(
                                            height: 5,
                                          ),
                                        ],
                                      ),
                                    ),
                                    CustomCard(
                                      shadow: false,
                                      width: double.infinity,
                                      bgColor: MyColors.white,
                                      borderRadius: BorderRadius.circular(15),
                                      padding: EdgeInsets.only(bottom: 10, top: 5, left: 6),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                          Row(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              mainAxisSize: MainAxisSize.max,
                                              children: <Widget>[
                                                CustomCard(
                                                    shadow: false,
                                                    height: 50,
                                                    width: 40,
                                                    bgColor: blue,
                                                    borderRadius: BorderRadius.circular(10),
                                                    child: Center(
                                                      child:  MyText(
                                                        mTitle: data.list![0].jmlResep! ,
                                                        mTextAlign: TextAlign.start,
                                                        mTextColor: Colors.white,
                                                        mFontSize: 22,
                                                        mFontStyle: FontStyle.normal,
                                                        mFontWeight: FontWeight.bold,
                                                      ),)
                                                ),
                                                SizedBox(
                                                  width: 15,
                                                ),
                                                Container(
                                                  padding: const EdgeInsets.only(top: 10),
                                                ),
                                              ]
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          TextScroll(
                                            'Jumlah Resep',
                                            intervalSpaces: 10,
                                            velocity: Velocity(pixelsPerSecond: Offset(5, 0)),
                                          ),
                                          SizedBox(
                                            height: 5,
                                          ),
                                        ],
                                      ),
                                    ),
                                    CustomCard(
                                      shadow: false,
                                      width: double.infinity,
                                      bgColor: MyColors.white,
                                      borderRadius: BorderRadius.circular(15),
                                      padding: EdgeInsets.only(bottom: 10, top: 5, left: 6),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              mainAxisSize: MainAxisSize.max,
                                              children: <Widget>[
                                                CustomCard(
                                                    shadow: false,
                                                    height: 50,
                                                    width: 40,
                                                    bgColor: blue,
                                                    borderRadius: BorderRadius.circular(10),
                                                    child: Center(
                                                      child:  MyText(
                                                        mTitle: data.list![0].jmlRujuk! ,
                                                        mTextAlign: TextAlign.start,
                                                        mTextColor: Colors.white,
                                                        mFontSize: 22,
                                                        mFontStyle: FontStyle.normal,
                                                        mFontWeight: FontWeight.bold,
                                                      ),)
                                                ),
                                                SizedBox(
                                                  width: 15,
                                                ),
                                                Container(
                                                  padding: const EdgeInsets.only(top: 15),
                                                ),
                                              ]
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          TextScroll(
                                            'Jumlah Rujukan Hari ini',
                                            intervalSpaces: 10,
                                            velocity: Velocity(pixelsPerSecond: Offset(5, 0)),
                                          ),
                                          SizedBox(
                                            height: 5,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ))]));
                        }else {
                          return Center(child: CircularProgressIndicator(),);
                        }
                      }
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  CustomCard(
                    shadow: false,
                    bgColor: Colors.white,
                    borderRadius: BorderRadius.circular(0),
                    child : Column(
                      children: [
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          'Menu Dokter',
                          style: TextStyle(
                              fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                  Padding(
                      padding: const EdgeInsets.fromLTRB(16, 10, 16, 0),
                      child: StaggeredGrid.count(
                        crossAxisCount: 2,
                        mainAxisSpacing: 20,
                        crossAxisSpacing: 10,
                        children: [
                          CustomCard(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => ListingCariMRPasienAll()));
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
                                    child: Center(
                                      child: MySvgAssetsImg(
                                        imageName: "medicalrecord.svg",
                                        fit: BoxFit.contain,
                                        imgHeight: 25,
                                        imgWidth: 19,
                                      ),)
                                ),
                                SizedBox(
                                  height: 15,
                                ),
                                Text(
                                  "History Medical Record",
                                  style: TextStyle(
                                      color: MyColors.blackText,
                                      fontSize: 11,
                                      fontWeight: FontWeight.bold),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  "Menunjukan Data Medical Record Pasien",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: MyColors.blackText.withOpacity(.8),
                                    fontSize: MyFontSize.small3,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          CustomCard(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => ListingAntrianPasien()));
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
                                    child: Center(
                                      child: MySvgAssetsImg(
                                        imageName: "antrian.svg",
                                        fit: BoxFit.contain,
                                        imgHeight: 30,
                                        imgWidth: 19,
                                      ),)
                                ),
                                SizedBox(
                                  height: 15,
                                ),
                                Text(
                                  "Tindakan Dokter",
                                  style: TextStyle(
                                      color: MyColors.blackText,
                                      fontSize: 11,
                                      fontWeight: FontWeight.bold),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  "Menunjukan Data Antrian Pasien",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: MyColors.blackText.withOpacity(.8),
                                    fontSize: MyFontSize.small3,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      )),
                  Padding(
                      padding: const EdgeInsets.fromLTRB(16, 10, 16, 0),
                      child: StaggeredGrid.count(
                        crossAxisCount: 2,
                        mainAxisSpacing: 20,
                        crossAxisSpacing: 10,
                        children: [
                          CustomCard(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => HomeScreen()));
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
                                    child: Center(
                                      child: MySvgAssetsImg(
                                        imageName: "pendapatan.svg",
                                        fit: BoxFit.contain,
                                        imgHeight: 30,
                                        imgWidth: 19,
                                      ),)),
                                SizedBox(
                                  height: 15,
                                ),
                                Text(
                                  "Pendapatan",
                                  style: TextStyle(
                                      color: MyColors.blackText,
                                      fontSize: MyFontSize.medium1,
                                      fontWeight: FontWeight.bold),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  "Menunjukan Pendapatan Dokter",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: MyColors.blackText.withOpacity(.8),
                                    fontSize: MyFontSize.small3,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          CustomCard(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => HISS()));
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
                                    child: Center(
                                      child: MySvgAssetsImg(
                                        imageName: "hissicon.svg",
                                        fit: BoxFit.contain,
                                        imgHeight: 30,
                                        imgWidth: 19,
                                      ),)),
                                SizedBox(
                                  height: 15,
                                ),
                                Text(
                                  "Dictionary HISS",
                                  style: TextStyle(
                                      color: MyColors.blackText,
                                      fontSize: MyFontSize.medium1,
                                      fontWeight: FontWeight.bold),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  "Menunjukan Catatan Dokter",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: MyColors.blackText.withOpacity(.8),
                                    fontSize: MyFontSize.small3,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      )),
                  Container(
                    padding: const EdgeInsets.only(
                      left: 20,
                      right: 20,
                      top: 10,
                    ),
                  ),
                ],
              ),
                  )],
                  ),
              const SizedBox(height: 10),
              CustomCard(
              shadow: false,
              bgColor: Colors.white,
              borderRadius: BorderRadius.circular(0),
              child : Column(
              children: [
                const SizedBox(height: 10),
                Text(
                  'Produck Averin',textAlign: TextAlign.start,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,),
                ),
              SizedBox(
                height: 200,
                width: double.infinity,
                child: CarouselSlider(
                  items: [
                    Container(
                      margin: EdgeInsets.all(6.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8.0),
                        image: DecorationImage(
                          image: NetworkImage("https://averin.co.id/images/it_service/post-02.jpg"),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),

                    //2nd Image of Slider
                    Container(
                      margin: EdgeInsets.all(6.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8.0),
                        image: DecorationImage(
                          image: NetworkImage("https://averin.co.id/images/it_service/post-01.jpg"),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),

                    //3rd Image of Slider
                    Container(
                      margin: EdgeInsets.all(6.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8.0),
                        image: DecorationImage(
                          image: NetworkImage("https://averin.co.id/images/it_service/post-08.jpg"),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),

                    //4th Image of Slider
                    Container(
                      margin: EdgeInsets.all(6.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8.0),
                        image: DecorationImage(
                          image: NetworkImage("https://averin.co.id/images/it_service/post-09.jpg"),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),

                    //5th Image of Slider
                    Container(
                      margin: EdgeInsets.all(6.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8.0),
                        image: DecorationImage(
                          image: NetworkImage("https://averin.co.id/images/it_service/post-05.jpg"),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ],
                  options: CarouselOptions(
                    height: 180.0,
                    enlargeCenterPage: true,
                    autoPlay: true,
                    aspectRatio: 16 / 9,
                    autoPlayCurve: Curves.fastOutSlowIn,
                    enableInfiniteScroll: true,
                    autoPlayAnimationDuration: Duration(milliseconds: 800),
                    viewportFraction: 0.8,
                  ),
                ),
              )
              ])),
            const SizedBox(height: 10,),
              Text('Design By Averin'),
            ],
          ),
        ));
  }

  String greetings(){
    final hour = TimeOfDay.now().hour;

    if(hour <= 12){
      return 'Selamat Pagi.';
    } else if (hour <= 17){
      return 'Selamat Siang';
    }
    return 'Selamat Malam';
  }

  Widget doctorDetails() {
    String urlfoto =  _hUser.url_foto_karyawan;
    urlfoto = urlfoto.replaceAll('..', '');
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 8, 20, 20),
      decoration: Utility.toolbarGradientBG(),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          Container(
            width: 80.0,
            height: 80.0,
            decoration: BoxDecoration(
              color: Colors.blue,
              boxShadow: [
                BoxShadow(
                    color: Colors.black.withOpacity(.1),
                    blurRadius: 8,
                    spreadRadius: 3)
              ],
              border: Border.all(
                width: 1.5,
                color: Colors.white,
              ),
              borderRadius: BorderRadius.circular(40.0),
            ),
            padding: EdgeInsets.all(5),
            child: CircleAvatar(
              backgroundImage: NetworkImage(
                  urlfoto),
            ),
          ),
          Expanded(
            child: Container(
              padding: const EdgeInsets.only(left: 15),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  MyText(
                    mTitle: greetings(),
                    mTextAlign: TextAlign.start,
                    mTextColor: white,
                    mFontSize: 15,
                    mFontStyle: FontStyle.normal,
                    mFontWeight: FontWeight.bold,
                  ),
                  MyText(
                    mTitle: _hUser.userName,
                    mTextAlign: TextAlign.start,
                    mTextColor: white,
                    mFontSize: 22,
                    mFontStyle: FontStyle.normal,
                    mFontWeight: FontWeight.bold,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  MyText(
                    mTitle: "Klinik . " + _hUser.userTitle,
                    mTextAlign: TextAlign.start,
                    mTextColor: text70OpacColor,
                    mFontSize: 16,
                    mFontStyle: FontStyle.normal,
                    mFontWeight: FontWeight.w400,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}



