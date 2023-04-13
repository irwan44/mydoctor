import 'dart:developer';

import 'package:awesome_drawer_bar/awesome_drawer_bar.dart';
import 'package:badges/badges.dart';
import 'package:doctorapp/model/periksamodel.dart';
//import 'package:doctorapp/pages/pasien/list_antrianf.dart';
import 'package:doctorapp/pages/editprofilef.dart';
import 'package:doctorapp/pages/dashboard/homef.dart';
import 'package:doctorapp/pages/notifications.dart';
import 'package:doctorapp/pages/medical_record.dart';
import 'package:doctorapp/utils/colors.dart';
import 'package:doctorapp/utils/constant.dart';
import 'package:doctorapp/utils/strings.dart';
import 'package:doctorapp/utils/utility.dart';
import 'package:doctorapp/widgets/myassetsimg.dart';
import 'package:doctorapp/widgets/mysvgassetsimg.dart';
import 'package:doctorapp/widgets/mytext.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';

import '../login.dart';
import '../splash.dart';
import 'loginscreen.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int currentIndex = 0;
  late String appBarTitle;
  late bool isHomePage, isRoundCorner;

  get detailpasienProfile => null;


  // final navigationPages  = [
  //   const HomeF(),
  //   //const AllAppointmentF(),,
  // ];

  @override
  initState() {
    super.initState();
    appBarTitle = Constant.appName;
    isHomePage = true;
    isRoundCorner = true;
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent, // transparent status bar
    ));
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Image.asset('images/bg.png').color,
      appBar: appBarTitle == "Resep" ? null : homeAppBar(),
      body: HomeF(detailpasienProfile: detailpasienProfile),
    );
  }

  AppBar homeAppBar() {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent, // transparent status bar
    ));
    return AppBar(
      elevation: 0,
      centerTitle: true,
      backgroundColor: statusBarColor,
      flexibleSpace: Visibility(
        visible: isRoundCorner,
        replacement: Container(
          decoration: Utility.toolbarGradientBG(),
        ),
        child: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              colors: [
                blue,
                blue,
              ],
            ),
          ),
        ),
      ),
      leading: IconButton(
        onPressed : () {
        QuickAlert.show(
        context: context,
        type: QuickAlertType.warning,
        text: 'Anda yakin ingin LOGOUT',
        confirmBtnText: 'LOGOUT' ,
        cancelBtnText: 'No',
          onConfirmBtnTap : () => Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => LoginSignupScreen()),
                (Route<dynamic> route) => false,),
        confirmBtnColor: Colors.white,
        backgroundColor: Colors.blueAccent,
        confirmBtnTextStyle: const TextStyle(
        color: Colors.redAccent,
        fontWeight: FontWeight.bold,
        ),
        barrierColor: Colors.white,
        titleColor: Colors.white,
        textColor: Colors.white,
        );
        return;
        },

        icon: MySvgAssetsImg(
          imageName: "logout.svg",
          fit: BoxFit.contain,
          imgHeight: 23,
          imgWidth: 22,
        ),
      ),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Visibility(
            visible: isHomePage,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                MyAssetsImg(
                  imageName: "app_icon.png",
                  fit: BoxFit.contain,
                  imgHeight: 22,
                  imgWidth: 22,
                ),
                const SizedBox(
                  width: 5,
                ),
              ],
            ),
          ),
          MyText(
            mTitle: appBarTitle,
            mFontSize: 20,
            mFontStyle: FontStyle.normal,
            mFontWeight: FontWeight.normal,
            mTextAlign: TextAlign.center,
            mTextColor: white,
          )
        ],
      ),
      actions: <Widget>[
        Visibility(
          visible: isHomePage,
          maintainSize: appBarTitle == resep ? false : true,
          maintainAnimation: true,
          maintainState: true,
          child: IconButton(
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => const NotifAntrianPasien()));
            },
            icon: Badge(
              position: BadgePosition.bottomStart(bottom: 8, start: 8),
              badgeColor: white,
              badgeContent: MyText(
                mTitle: '5',
                mFontSize: 8,
                mFontStyle: FontStyle.normal,
                mFontWeight: FontWeight.normal,
                mTextAlign: TextAlign.center,
                mTextColor: primaryColor,
              ),
              child: MySvgAssetsImg(
                imageName: "notification.svg",
                fit: BoxFit.contain,
              ),
            ),
          ),
        ),
        Visibility(
          visible: appBarTitle == resep,
          maintainSize: false,
          maintainAnimation: true,
          maintainState: true,
          child: IconButton(
            onPressed: () {},
            icon: MySvgAssetsImg(
              imageName: "search.svg",
              fit: BoxFit.contain,
            ),
          ),
        )
      ],
    );
  }

  void onNavigationClick(int value) {
    log('$value');
    // Respond to item press.
    setState(() {
      currentIndex = value;
      switch (value) {
        case 0:
          {
            appBarTitle = Constant.appName;
            isHomePage = true;
            isRoundCorner = true;
          }
          break;
        case 1:
          {
            appBarTitle = anterian;
            isHomePage = false;
            isRoundCorner = false;
          }
          break;
        case 2:
          {
            appBarTitle = resep;
            isHomePage = false;
            isRoundCorner = true;
          }
          break;
        case 3:
          {
            appBarTitle = editProfile;
            isHomePage = false;
            isRoundCorner = true;
          }
          break;
      }
    });
  }
}
