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
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body:  Container(
        child : Home(),
      ),
    );
  }



}