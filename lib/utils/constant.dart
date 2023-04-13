import 'package:doctorapp/model/dummyDataModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Constant {
  static String appName = "";

  static const googleApikey = "AIzaSyBYJbjMnqYFSQ1lssqHH4A52HWD1H13FtI";

  // Dimentions START
  static double appBarHeight = 60.0;
  static double appBarTextSize = 20.0;
  static double textFieldHeight = 60.0;
  static double buttonHeight = 45.0;
  static double backBtnHeight = 15.0;
  static double backBtnWidth = 19.0;
  // Dimentions END

  static List<kesadaranDataModel> kesadaranDataList = [
    kesadaranDataModel(kode: "1", keterangan: ""),
  ];

  static List<DummyDataModel> dummyDataList = [
    DummyDataModel(
      title: 'Irwam',
      subTitle: '578435662349',
      imageUrl:
          'https://images.unsplash.com/photo-1494790108377-be9c29b29330?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=387&q=80',
      mobileNumber: '1234567890',
      date: 'February 12, 2022 at 10:30 am - 11:00 am',
      status: 'Nomer Antrian 90',
    ),
    DummyDataModel(
      title: 'Irwam',
      subTitle: '578435662349',
      imageUrl:
          'https://images.unsplash.com/photo-1438761681033-6461ffad8d80?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=870&q=80',
      mobileNumber: '1234567890',
      date: 'February 12, 2022 at 10:30 am - 11:00 am',
      status: 'Nomer Antrian 91',
    ),
    DummyDataModel(
      title: 'Irwam',
      subTitle: '578435662349',
      imageUrl:
          'https://images.unsplash.com/photo-1570295999919-56ceb5ecca61?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=580&q=80',
      mobileNumber: '1234567890',
      date: 'February 12, 2022 at 10:30 am - 11:00 am',
      status: 'Nomer Antrian 92',
    ),
    DummyDataModel(
      title: 'Irwam',
      subTitle: '578435662349',
      imageUrl:
          'https://images.unsplash.com/photo-1506794778202-cad84cf45f1d?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=387&q=80',
      mobileNumber: '1234567890',
      date: 'February 12, 2022 at 10:30 am - 11:00 am',
      status: 'Nomer Antrian 93',
    ),
    DummyDataModel(
      title: 'Irwam',
      subTitle: '578435662349',
      imageUrl:
          'https://images.unsplash.com/photo-1531727991582-cfd25ce79613?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=387&q=80',
      mobileNumber: '1234567890',
      date: 'February 12, 2022 at 10:30 am - 11:00 am',
      status: 'Nomer Antrian 94',
    ),
    DummyDataModel(
      title: 'Irwam',
      subTitle: '578435662349',
      imageUrl:
          'https://images.unsplash.com/photo-1609010697446-11f2155278f0?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=870&q=80',
      mobileNumber: '1234567890',
      date: 'February 12, 2022 at 10:30 am - 11:00 am',
      status: 'Nomer Antrian 95',
    ),
  ];
}

class URLS {
  static const String BASE_URL = 'https://c00001.sirs.co.id/'; //server js
  static const String BASE_URLjs = 'https://c00001.sirs.co.id/'; //server js
}

class MyTooltip extends StatelessWidget {
  final Widget child;
  final String message;

  MyTooltip({required this.message, required this.child});

  @override
  Widget build(BuildContext context) {
    final key = GlobalKey<State<Tooltip>>();
    return Tooltip(
      key: key,
      message: message,
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () => _onTap(key),
        child: child,
      ),
    );
  }

  void _onTap(GlobalKey key) {
    final dynamic tooltip = key.currentState;
    tooltip?.ensureTooltipVisible();
  }
}
