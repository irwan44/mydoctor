import 'dart:developer';

import 'package:awesome_drawer_bar/awesome_drawer_bar.dart';
import 'package:doctorapp/pages/dashboard/loginscreen.dart';
import 'package:doctorapp/pages/tentang_ketentuan_privasi.dart';
import 'package:doctorapp/pages/dashboard/home.dart';
import 'package:doctorapp/pages/login.dart';
import 'package:doctorapp/pages/qrcodescanner.dart';
import 'package:doctorapp/utils/colors.dart';
import 'package:doctorapp/utils/strings.dart';
import 'package:doctorapp/widgets/mysvgassetsimg.dart';
import 'package:doctorapp/widgets/mytext.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MySideDrawer extends StatefulWidget {
  const MySideDrawer({Key? key}) : super(key: key);

  @override
  State<MySideDrawer> createState() => _MySideDrawerState();
}

class _MySideDrawerState extends State<MySideDrawer> {
  final _drawerBarController = AwesomeDrawerBarController();
  late int selectedMenuItemId;

  @override
  void initState() {
    super.initState();
    selectedMenuItemId = 0;
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AwesomeDrawerBar(
      type: StyleState.scaleRight,
      controller: _drawerBarController,
      menuScreen: mySideNavDrawer(),
      mainScreen: const Home(),
      borderRadius: 20.0,
      showShadow: false,
      angle: 0.0,
      slideWidth: MediaQuery.of(context).size.width * .8,
      openCurve: Curves.fastOutSlowIn,
      closeCurve: Curves.bounceIn,
      backgroundColor: drawerStartColor,
    );
  }

  Widget mySideNavDrawer() {
    return Container(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          const SizedBox(
            height: 70,
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                InkWell(
                  borderRadius: BorderRadius.circular(6),
                  onTap: () {
                    log("Tapped on $gantipassword");
                    toggleDrawer();
                    setState(() {
                      selectedMenuItemId = 0;
                      log("selectedMenuItemId => $selectedMenuItemId");
                    });
                  },
                  child: Container(
                    decoration: selectedMenuItemId == 0
                        ? BoxDecoration(
                      color: other50OpacColor,
                      borderRadius: BorderRadius.circular(6),
                      shape: BoxShape.rectangle,
                    )
                        : null,
                    width: MediaQuery.of(context).size.width * 0.55,
                    height: 60,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        const SizedBox(
                          width: 10,
                        ),
                        MySvgAssetsImg(
                          imageName: "reset_pw.svg",
                          fit: BoxFit.cover,
                          imgHeight: 24,
                          iconColor: white,
                          imgWidth: 24,
                        ),
                        const SizedBox(
                          width: 15,
                        ),
                        Expanded(
                          child: MyText(
                            mTitle: gantipassword,
                            mFontSize: 16,
                            mFontStyle: FontStyle.normal,
                            mFontWeight: FontWeight.normal,
                            mTextColor: white,
                            mOverflow: TextOverflow.ellipsis,
                            mMaxLine: 2,
                            mTextAlign: TextAlign.start,
                          ),
                        ),
                        const SizedBox(
                          width: 15,
                        ),
                        MySvgAssetsImg(
                          imageName: "view_more.svg",
                          fit: BoxFit.cover,
                          imgHeight: 13,
                          imgWidth: 7,
                          iconColor: white,
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                      ],
                    ),
                  ),
                ),
                InkWell(
                  borderRadius: BorderRadius.circular(6),
                  onTap: () {
                    log("Tapped on $scanQRCode");
                    toggleDrawer();
                    setState(() {
                      selectedMenuItemId = 1;
                      log("selectedMenuItemId => $selectedMenuItemId");
                    });
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const QRCodeScanner()));
                  },
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.55,
                    decoration: selectedMenuItemId == 1
                        ? BoxDecoration(
                      color: other50OpacColor,
                      borderRadius: BorderRadius.circular(6),
                      shape: BoxShape.rectangle,
                    )
                        : null,
                    height: 60,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        const SizedBox(
                          width: 10,
                        ),
                        MySvgAssetsImg(
                          imageName: "scanner.svg",
                          fit: BoxFit.cover,
                          imgHeight: 24,
                          imgWidth: 24,
                          iconColor: white,
                        ),
                        const SizedBox(
                          width: 15,
                        ),
                        Expanded(
                          child: MyText(
                            mTitle: scanQRCode,
                            mFontSize: 16,
                            mFontStyle: FontStyle.normal,
                            mFontWeight: FontWeight.normal,
                            mTextColor: white,
                            mOverflow: TextOverflow.ellipsis,
                            mMaxLine: 2,
                            mTextAlign: TextAlign.start,
                          ),
                        ),
                        const SizedBox(
                          width: 15,
                        ),
                        MySvgAssetsImg(
                          imageName: "view_more.svg",
                          fit: BoxFit.cover,
                          imgHeight: 13,
                          imgWidth: 7,
                          iconColor: white,
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                      ],
                    ),
                  ),
                ),
                InkWell(
                  borderRadius: BorderRadius.circular(6),
                  onTap: () {
                    log("Tapped on $aboutUs");
                    toggleDrawer();
                    setState(() {
                      selectedMenuItemId = 2;
                      log("selectedMenuItemId => $selectedMenuItemId");
                    });
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const AboutPrivacyTerms(
                          appBarTitle: aboutUs,
                        )));
                  },
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.55,
                    decoration: selectedMenuItemId == 2
                        ? BoxDecoration(
                      color: other50OpacColor,
                      borderRadius: BorderRadius.circular(6),
                      shape: BoxShape.rectangle,
                    )
                        : null,
                    height: 60,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        const SizedBox(
                          width: 10,
                        ),
                        MySvgAssetsImg(
                          imageName: "about_us.svg",
                          fit: BoxFit.cover,
                          iconColor: white,
                          imgHeight: 24,
                          imgWidth: 24,
                        ),
                        const SizedBox(
                          width: 15,
                        ),
                        Expanded(
                          child: MyText(
                            mTitle: aboutUs,
                            mFontSize: 16,
                            mFontStyle: FontStyle.normal,
                            mFontWeight: FontWeight.normal,
                            mTextColor: white,
                            mOverflow: TextOverflow.ellipsis,
                            mMaxLine: 2,
                            mTextAlign: TextAlign.start,
                          ),
                        ),
                        const SizedBox(
                          width: 15,
                        ),
                        MySvgAssetsImg(
                          imageName: "view_more.svg",
                          fit: BoxFit.cover,
                          imgHeight: 13,
                          imgWidth: 7,
                          iconColor: white,
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                      ],
                    ),
                  ),
                ),
                InkWell(
                  borderRadius: BorderRadius.circular(6),
                  onTap: () {
                    log("Tapped on $termConditions");
                    toggleDrawer();
                    setState(() {
                      selectedMenuItemId = 3;
                      log("selectedMenuItemId => $selectedMenuItemId");
                    });
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const AboutPrivacyTerms(
                          appBarTitle: termConditions,
                        )));
                  },
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.55,
                    decoration: selectedMenuItemId == 3
                        ? BoxDecoration(
                      color: other50OpacColor,
                      borderRadius: BorderRadius.circular(6),
                      shape: BoxShape.rectangle,
                    )
                        : null,
                    height: 60,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        const SizedBox(
                          width: 10,
                        ),
                        MySvgAssetsImg(
                          imageName: "t_and_c.svg",
                          fit: BoxFit.cover,
                          imgHeight: 24,
                          iconColor: white,
                          imgWidth: 24,
                        ),
                        const SizedBox(
                          width: 15,
                        ),
                        Expanded(
                          child: MyText(
                            mTitle: termConditions,
                            mFontSize: 16,
                            mFontStyle: FontStyle.normal,
                            mFontWeight: FontWeight.normal,
                            mTextColor: white,
                            mOverflow: TextOverflow.ellipsis,
                            mMaxLine: 2,
                            mTextAlign: TextAlign.start,
                          ),
                        ),
                        const SizedBox(
                          width: 15,
                        ),
                        MySvgAssetsImg(
                          imageName: "view_more.svg",
                          fit: BoxFit.cover,
                          imgHeight: 13,
                          imgWidth: 7,
                          iconColor: white,
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                      ],
                    ),
                  ),
                ),
                InkWell(
                  borderRadius: BorderRadius.circular(6),
                  onTap: () {
                    log("Tapped on $reportIssues");
                    toggleDrawer();
                    setState(() {
                      selectedMenuItemId = 4;
                      log("selectedMenuItemId => $selectedMenuItemId");
                    });
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const AboutPrivacyTerms(
                          appBarTitle: reportIssues,
                        )));
                  },
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.55,
                    decoration: selectedMenuItemId == 4
                        ? BoxDecoration(
                      color: other50OpacColor,
                      borderRadius: BorderRadius.circular(6),
                      shape: BoxShape.rectangle,
                    )
                        : null,
                    height: 60,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        const SizedBox(
                          width: 10,
                        ),
                        MySvgAssetsImg(
                          imageName: "report_issue.svg",
                          fit: BoxFit.cover,
                          imgHeight: 24,
                          iconColor: white,
                          imgWidth: 24,
                        ),
                        const SizedBox(
                          width: 15,
                        ),
                        Expanded(
                          child: MyText(
                            mTitle: reportIssues,
                            mFontSize: 16,
                            mFontStyle: FontStyle.normal,
                            mFontWeight: FontWeight.normal,
                            mTextColor: white,
                            mOverflow: TextOverflow.ellipsis,
                            mMaxLine: 2,
                            mTextAlign: TextAlign.start,
                          ),
                        ),
                        const SizedBox(
                          width: 15,
                        ),
                        MySvgAssetsImg(
                          imageName: "view_more.svg",
                          fit: BoxFit.cover,
                          imgHeight: 13,
                          imgWidth: 7,
                          iconColor: white,
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                      ],
                    ),
                  ),
                ),
                InkWell(
                  borderRadius: BorderRadius.circular(6),
                  onTap: () {
                    log("Tapped on $helpCenter");
                    toggleDrawer();
                    setState(() {
                      selectedMenuItemId = 5;
                      log("selectedMenuItemId => $selectedMenuItemId");
                    });
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const AboutPrivacyTerms(
                          appBarTitle: helpCenter,
                        )));
                  },
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.55,
                    decoration: selectedMenuItemId == 5
                        ? BoxDecoration(
                      color: other50OpacColor,
                      borderRadius: BorderRadius.circular(6),
                      shape: BoxShape.rectangle,
                    )
                        : null,
                    height: 60,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        const SizedBox(
                          width: 10,
                        ),
                        MySvgAssetsImg(
                          imageName: "help_center.svg",
                          fit: BoxFit.cover,
                          imgHeight: 24,
                          imgWidth: 24,
                          iconColor: white,
                        ),
                        const SizedBox(
                          width: 15,
                        ),
                        Expanded(
                          child: MyText(
                            mTitle: helpCenter,
                            mFontSize: 16,
                            mFontStyle: FontStyle.normal,
                            mFontWeight: FontWeight.normal,
                            mTextColor: white,
                            mOverflow: TextOverflow.ellipsis,
                            mMaxLine: 2,
                            mTextAlign: TextAlign.start,
                          ),
                        ),
                        const SizedBox(
                          width: 15,
                        ),
                        MySvgAssetsImg(
                          imageName: "view_more.svg",
                          fit: BoxFit.cover,
                          imgHeight: 13,
                          imgWidth: 7,
                          iconColor: white,
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          InkWell(
            borderRadius: BorderRadius.circular(6),
            onTap: () {
              log("Tapped on $logout");

              SharedPreferences.getInstance().then(
                    (prefs) {
                  prefs.setString('id', "");
                  prefs.setString('password', "");
                },
              );
              toggleDrawer();
              setState(() {
                selectedMenuItemId = 6;
                log("selectedMenuItemId => $selectedMenuItemId");
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => LoginSignupScreen()));
              });
            },
            child: Container(
              padding: const EdgeInsets.only(left: 10, right: 10),
              decoration: selectedMenuItemId == 6
                  ? BoxDecoration(
                color: other50OpacColor,
                borderRadius: BorderRadius.circular(6),
                shape: BoxShape.rectangle,
              )
                  : null,
              width: MediaQuery.of(context).size.width * 0.55,
              height: 60,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  MySvgAssetsImg(
                    imageName: "logout.svg",
                    fit: BoxFit.cover,
                    imgHeight: 24,
                    iconColor: white,
                    imgWidth: 24,
                  ),
                  const SizedBox(
                    width: 15,
                  ),
                  Expanded(
                    child: MyText(
                      mTitle: login,
                      mFontSize: 16,
                      mFontStyle: FontStyle.normal,
                      mFontWeight: FontWeight.normal,
                      mTextColor: white,
                      mOverflow: TextOverflow.ellipsis,
                      mMaxLine: 2,
                      mTextAlign: TextAlign.start,
                    ),
                  ),
                  const SizedBox(
                    width: 15,
                  ),
                  MySvgAssetsImg(
                    imageName: "view_more.svg",
                    fit: BoxFit.cover,
                    imgHeight: 13,
                    imgWidth: 7,
                    iconColor: white,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  toggleDrawer() {
    _drawerBarController.toggle!();
  }
}
