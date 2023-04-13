import 'dart:async';

import 'package:doctorapp/apiservice/serviceapi.dart';
import 'package:doctorapp/model/usermodel.dart';
import 'package:doctorapp/pages/login.dart';
import 'package:doctorapp/pages/menu_drawer.dart';
import 'package:doctorapp/provider/auth_user.dart';
import 'package:doctorapp/widgets/myassetsimg.dart';
import 'package:flutter/material.dart';
import 'package:doctorapp/pages/dashboard/loginscreen.dart';
import 'package:flutter/services.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Splash extends StatefulWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  String? lastID;
  String? username;
  String? password;

  @override
  void initState() {
    super.initState();
    _loadUserEmailPassword();
    // navigateToNext(context, lastID);
  }

  void _loadUserEmailPassword() async {
    try {
      SharedPreferences _prefs = await SharedPreferences.getInstance();
      var _id = _prefs.getString("id") ?? "";
      var _password = _prefs.getString("password") ?? "";
      lastID = _id;
      username = _id;
      password = _password;
      if (lastID == "") {
        lastID = null;
      }
    } catch (e) {
      print(e);
    }
    navigateToNext(context, lastID);
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent, // transparent status bar
    ));
    // return SizedBox(
    //   height: MediaQuery.of(context).size.height,
    //   width: MediaQuery.of(context).size.width,
    //   child: MyAssetsImg(
    //     imageName: "splash.png",
    //     fit: BoxFit.fill,
    //     imgHeight: MediaQuery.of(context).size.height,
    //     imgWidth: MediaQuery.of(context).size.width,
    //   ),
    // );

    return Scaffold(
        body: Stack(
      children: [
        Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          decoration: const BoxDecoration(
            color: Color.fromARGB(255, 35, 163, 223),
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(10),
                bottomRight: Radius.circular(10)),
            image: DecorationImage(
                image: AssetImage('assets/images/splash.png'),
                fit: BoxFit.cover),
          ),
        ),
        SizedBox(height: 160),
        // SizedBox(
        //     height: 200.h,
        //     width: 200.w,
        //     child: Lottie.asset('assets/images/splash-loader.json')),

        // Positioned(
        //   top: 390,
        //   left: 0,
        //   right: 0,
        //   child: SizedBox(
        //       height: 125,
        //       width: 125,
        //       child: Lottie.asset('assets/images/splash-loader.json')),
        // )
      ],
    ));
  }

  void navigateToNext(BuildContext context, String? lastID) {
    print(lastID);

    Timer(
        const Duration(seconds: 3),
        () =>
            // Navigator.of(context).pushReplacement(
            //     MaterialPageRoute(builder: (context) => LoginSignupScreen()))
            lastID == null ? nextLogin() : nextDashBoar()
        // Navigator.of(context).pushReplacement(lastID == null
        //     ? MaterialPageRoute(builder: (context) => LoginSignupScreen())
        //     : MaterialPageRoute(builder: (context) => LoginSignupScreen()))

        );
  }

  void nextLogin() {
    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => LoginSignupScreen()));
  }

  void nextDashBoar() async {
    UserProfile? _usr = await UserApiService.getUser(username!, password!);

    if (_usr != null) {
      //print(_usr.userName);

      if (_usr.userName == "No") {
        nextLogin();

        return;
      } else {
        SharedPreferences.getInstance().then(
          (prefs) {
            prefs.setString('id', username!);
            prefs.setString('password', password!);
          },
        );

        Provider.of<AuthUserData>(context, listen: false).setDataUser(_usr);

        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => const MySideDrawer()));
      }
    }
  }
}

// void navigateToNext(BuildContext context, String? lastID) {
//   Timer(
//       const Duration(seconds: 8),
//       () => Navigator.of(context).pushReplacement(lastID == null
//           ? MaterialPageRoute(builder: (context) => LoginSignupScreen())
//           : MaterialPageRoute(builder: (context) => LoginSignupScreen())));
// }

