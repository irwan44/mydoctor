// @dart=2.9
import 'package:doctorapp/apiservice/serviceapi.dart';
import 'package:doctorapp/pages/splash.dart';
import 'package:doctorapp/utils/constant.dart';
import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:provider/provider.dart';
import 'package:doctorapp/provider/auth_user.dart';
import 'package:doctorapp/provider/pasien_prov.dart';
import 'utils/colors.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

void main() async {
  // runApp(const MyApp());
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (context) => AuthUserData()),
    ChangeNotifierProvider(create: (context) => AuthPasienData()),
    ChangeNotifierProvider(create: (context) => TindakanList()),
  ], child: const MyApp()));
  configLoading();

}

void configLoading() {
  EasyLoading.instance
    ..displayDuration = const Duration(milliseconds: 2000)
    ..indicatorType = EasyLoadingIndicatorType.fadingCircle
    ..loadingStyle = EasyLoadingStyle.dark
    ..indicatorSize = 45.0
    ..radius = 10.0
    ..progressColor = Colors.yellow
    ..backgroundColor = Colors.green
    ..indicatorColor = Colors.yellow
    ..textColor = Colors.yellow
    ..maskColor = Colors.blue.withOpacity(0.5)
    ..userInteractions = true
    ..dismissOnTap = false
    ..customAnimation = CustomAnimation();
}

EasyLoadingAnimation CustomAnimation() {}

class MyApp extends StatefulWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  PackageInfo packageInfo;
  @override
  void initState() {
    super.initState();
    getPackage();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      builder: EasyLoading.init(),
      theme: ThemeData(
        primaryColor: primaryColor,
        primaryColorDark: blue,
        primaryColorLight: primaryLightColor,
        scaffoldBackgroundColor: appBgColor,
      ).copyWith(
        pageTransitionsTheme: const PageTransitionsTheme(
          builders: <TargetPlatform, PageTransitionsBuilder>{
            TargetPlatform.android: ZoomPageTransitionsBuilder(),
          },
        ),
      ),
      home: Splash(),
      title: Constant.appName.isNotEmpty ? Constant.appName : "My Doctor-SIRs",
    );
  }

  void getPackage() async {
    packageInfo = await PackageInfo.fromPlatform();
    String appName = packageInfo.appName;
    String packageName = packageInfo.packageName;
    String version = packageInfo.version;
    String buildNumber = packageInfo.buildNumber;

    Constant.appName = appName;
    // print(Constant.appName);

    // print(
    //     "App Name : ${appName}, App Package Name : ${packageName}, App Version : ${version}, App build Number : ${buildNumber}");
  }
}
