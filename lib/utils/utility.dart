import 'dart:async';
import 'dart:developer';
import 'dart:math' as math;
import 'package:doctorapp/model/timeschedule.dart';
import 'package:doctorapp/widgets/mysvgassetsimg.dart';
import 'package:doctorapp/widgets/mytext.dart';
import 'package:flutter/material.dart';

import 'package:doctorapp/utils/colors.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:intl/intl.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

import '../widgets/myappbarwithback.dart';
import 'constant.dart';

class Utility {
  static void showToast(var msg) {
    Fluttertoast.showToast(
        msg: "$msg",
        timeInSecForIosWeb: 2,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: white,
        textColor: black,
        fontSize: 16);
  }

  static PreferredSize appBarCommon(var appBarTitle) {
    return PreferredSize(
      preferredSize: Size.fromHeight(Constant.appBarHeight),
      child: MyAppBarWithBack(
        abTitle: appBarTitle,
        fontSize: Constant.appBarTextSize,
        abBGColor: blue,
        fontColor: white,
      ),
    );
  }

  static AppBar myAppBar(BuildContext context, String appBarTitle) {
    return AppBar(
      elevation: 0,
      backgroundColor: statusBarColor,
      centerTitle: true,
      flexibleSpace: Container(
        decoration: toolbarGradientBG(),
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
        mTitle: appBarTitle,
        mFontSize: 20,
        mFontStyle: FontStyle.normal,
        mFontWeight: FontWeight.normal,
        mTextAlign: TextAlign.center,
        mTextColor: white,
      ),
    );
  }

  static BoxDecoration textFieldBGWithBorder() {
    return BoxDecoration(
      color: white,
      border: Border.all(
        color: Colors.white,
        width: .2,
      ),
      borderRadius: BorderRadius.circular(10),
      shape: BoxShape.rectangle,
    );
  }

  static BoxDecoration r4BGWithBorder() {
    return BoxDecoration(
      color: white,
      border: Border.all(
        color: Colors.white,
        width: .5,
      ),
      borderRadius: BorderRadius.circular(10),
      shape: BoxShape.rectangle,
    );
  }

  static BoxDecoration r4DarkBGWithBorder() {
    return BoxDecoration(
      color: blue,
      border: Border.all(
        color: Colors.white,
        width: .5,
      ),
      borderRadius: BorderRadius.circular(4),
      shape: BoxShape.rectangle,
    );
  }

  static BoxDecoration r10BGWithBorder() {
    return BoxDecoration(
      color: white,
      border: Border.all(
        color: Colors.white,
        width: .5,
      ),
      borderRadius: BorderRadius.circular(10),
      shape: BoxShape.rectangle,
    );
  }

  static BoxDecoration primaryDarkButton() {
    return BoxDecoration(
      color: blue,
      borderRadius: BorderRadius.circular(5),
      shape: BoxShape.rectangle,
    );
  }

  static BoxDecoration toolbarGradientBG() {
    return const BoxDecoration(
      image: DecorationImage(
          image: AssetImage('assets/images/bg22.png'),
          fit: BoxFit.cover),
      borderRadius: BorderRadius.only(
        bottomLeft: Radius.circular(0),
        bottomRight: Radius.circular(0),
      ),
      shape: BoxShape.rectangle,
    );
  }

  static Html htmlTexts(var strText) {
    return Html(
      data: strText,
      onLinkTap: (url) async {
        if (await canLaunchUrl(Uri.parse(url))) {
          await launchUrl(
            Uri.parse(url),
            mode: LaunchMode.platformDefault,
          );
        } else {
          throw 'Could not launch $url';
        }
      },
      shrinkToFit: false,
      linkStyle:
          const TextStyle(decoration: TextDecoration.none, color: linkColor),
      defaultTextStyle: GoogleFonts.roboto(
        textStyle: const TextStyle(
          fontSize: 14,
          color: otherLightColor,
          fontWeight: FontWeight.w500,
          fontStyle: FontStyle.normal,
          letterSpacing: .2,
        ),
      ),
    );
  }

  static Future<void> launchPhoneDialer(String contactNumber) async {
    final Uri phoneUri = Uri(scheme: "tel", path: contactNumber);
    try {
      if (await canLaunchUrl(Uri.parse(phoneUri.toString()))) {
        await launchUrl(Uri.parse(phoneUri.toString()));
      }
    } catch (error) {
      throw ("Cannot dial");
    }
  }

  static List<TimeScheduleModel> getTimeFromSlot(
      String duration, String startTime, String endTime) {
    List<TimeScheduleModel> timeList = [];
    DateFormat hhmmFormatter = DateFormat("HH:mm");
    DateFormat mmFormatter = DateFormat("hh:mm a");

    log('startTime => $startTime');
    log('endTime => $endTime');
    DateTime start = hhmmFormatter.parse(startTime);
    DateTime end = hhmmFormatter.parse(endTime);
    Duration durationGap = Duration(minutes: int.parse(duration));
    log('durationGap => $durationGap');
    log('start => $start');
    log('end => $end');

    log('start Milli => ${start.minute}');
    log('end Milli => ${end.minute}');
    Duration difference = end.difference(start);
    log('(1). difference => $difference');

    if (difference.isNegative) {
      DateTime dateMax = hhmmFormatter.parse("24:00");
      DateTime dateMin = hhmmFormatter.parse("00:00");
      difference = ((dateMax.difference(start)) + (end.difference(dateMin)));
      log('(2). difference => $difference');
    }

    int days = difference.inDays;
    double hours = difference.inHours % 24;
    double minutes = difference.inMinutes % 60;
    double seconds = difference.inSeconds % 60;
    log('==days=> $days');
    log('==hours=> $hours');
    log('==minutes=> $minutes');
    log('==seconds=> $seconds');

    double parts = 0;
    double totalMinutes = 0;

    if (hours > 0 && hours < 24) {
      totalMinutes = hours * 60;
      parts = (totalMinutes / double.parse(duration));
      log('parts : if ==> $parts');
    } else if (minutes > 0 && minutes < 60) {
      totalMinutes = totalMinutes + minutes;
      parts = (totalMinutes / double.parse(duration));
      log('parts : else if ==> $parts');
    }

    if (parts > 0) {
      for (int i = 0; i < parts; i++) {
        TimeScheduleModel scheduleModel = TimeScheduleModel();
        scheduleModel.setTime = mmFormatter.format(start);
        timeList.add(scheduleModel);
        DateTime dateTime = start.add(durationGap);
        start = dateTime;
        log('newTime :==> ${mmFormatter.format(start)}');
      }
    }

    return timeList;
  }

  static TextStyle textTitleBlack = TextStyle(
      color: black,
      fontSize: 13,
      fontFamily: 'Poppins',
      //fontSize:displayWidth(BuildContext: context ) * 0.03),
      fontWeight: FontWeight.w700);
}

Widget roundedRectButton(
    String title, List<Color> gradient, bool isEndIconVisible) {
  return Builder(builder: (BuildContext mContext) {
    return Padding(
      padding: EdgeInsets.only(bottom: 10),
      child: Stack(
        alignment: Alignment(1.0, 0.0),
        children: <Widget>[
          Container(
            alignment: Alignment.center,
            width: MediaQuery.of(mContext).size.width / 1.7,
            decoration: ShapeDecoration(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0)),
              gradient: LinearGradient(
                  colors: gradient,
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight),
            ),
            child: Text(title,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.w500)),
            padding: EdgeInsets.only(top: 2, bottom: 2),
          ),
          Visibility(
            visible: isEndIconVisible,
            child: Padding(
                padding: EdgeInsets.only(right: 10),
                child: ImageIcon(
                  AssetImage("assets/images/ic_forward.png"),
                  size: 30,
                  color: Colors.white,
                )),
          ),
        ],
      ),
    );
  });
}

const List<Color> signInGradients = [
  Color(0xFF0EDED2),
  Color(0xFF03A0FE),
];

const List<Color> signUpGradients = [
  Color(0xFFFF9945),
  Color(0xFFFc6076),
];

Size displaySize(BuildContext context) {
  return MediaQuery.of(context).size;
}

double displayHeight(BuildContext context) {
  return displaySize(context).height;
}

double displayWidth(BuildContext context) {
  return displaySize(context).width;
}

const List<String> HISSModul = [
  'ICD X & Diagnosa',
  'Simtom & Gejala Klinik',
  'Penyebab',
  'Pemeriksaan Lab/Penunjang Diagnostic',
  'Pengobatan',
  'Komplikasi & Prognosis',
  'Differensial',
  'Catatan',
  'Pre Existing',
];

class WaitingType {
  final int? milliseconds;
  VoidCallback? action;
  Timer? _timer;

  WaitingType({
    this.milliseconds = 0,
  });

  run(VoidCallback action) {
    if (null != _timer) {
      _timer?.cancel();
    }
    _timer = Timer(Duration(milliseconds: milliseconds!), action);
  }
}

class DrawClip extends CustomClipper<Path> {
  double move = 0;
  double slice = math.pi;

  DrawClip(double value);
  //DrawClip(this.move);
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.lineTo(0, size.height * 0.8);
    double xCenter =
        size.width * 0.5 + (size.width * 0.6 + 1) * math.sin(move * slice);
    double yCenter = size.height * 0.8 + 69 * math.cos(move * slice);
    path.quadraticBezierTo(xCenter, yCenter, size.width, size.height * 0.8);

    path.lineTo(size.width, 0);
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return true;
  }
}
