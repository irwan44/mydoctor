import 'dart:developer';

import 'package:doctorapp/pages/pemeriksaan.dart';
import 'package:doctorapp/utils/colors.dart';
import 'package:doctorapp/utils/constant.dart';
import 'package:doctorapp/utils/strings.dart';
import 'package:doctorapp/utils/utility.dart';
import 'package:doctorapp/widgets/mynetworkimg.dart';
import 'package:doctorapp/widgets/mysvgassetsimg.dart';
import 'package:doctorapp/widgets/mytext.dart';
import 'package:doctorapp/widgets/mytextformfield.dart';
import 'package:flutter/material.dart';

class AppointmentDetails extends StatefulWidget {
  const AppointmentDetails({Key? key}) : super(key: key);

  @override
  State<AppointmentDetails> createState() => _AppointmentDetailsState();
}

class _AppointmentDetailsState extends State<AppointmentDetails> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var mSubyektive;
    var mObjective;
    var mAnalyst;
    var container = Container(
      width: MediaQuery.of(context).size.width,
      alignment: Alignment.centerLeft,
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: white,
        borderRadius: BorderRadius.circular(8),
        shape: BoxShape.rectangle,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          MyText(
            mTitle: vitasign,
            mFontSize: 12,
            mFontWeight: FontWeight.bold,
            mFontStyle: FontStyle.normal,
            mTextAlign: TextAlign.start,
          ),
          const SizedBox(
            height: 4,
          ),
          const SizedBox(
            height: 15,
          ),
          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    MyText(
                      mTitle: keadaanumum,
                      mFontSize: 12,
                      mFontWeight: FontWeight.normal,
                      mFontStyle: FontStyle.normal,
                      mTextAlign: TextAlign.start,
                      mTextColor: otherLightColor,
                    ),
                    const SizedBox(
                      height: 4,
                    ),
                    MyText(
                      mTitle: "......",
                      mFontSize: 14,
                      mFontWeight: FontWeight.normal,
                      mMaxLine: 1,
                      mOverflow: TextOverflow.ellipsis,
                      mFontStyle: FontStyle.normal,
                      mTextAlign: TextAlign.start,
                      mTextColor: textTitleColor,
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    MyText(
                      mTitle: tekanandarah,
                      mFontSize: 12,
                      mFontWeight: FontWeight.normal,
                      mFontStyle: FontStyle.normal,
                      mTextAlign: TextAlign.start,
                      mTextColor: otherLightColor,
                    ),
                    const SizedBox(
                      height: 4,
                    ),
                    MyText(
                      mTitle: "......",
                      mFontSize: 14,
                      mMaxLine: 1,
                      mOverflow: TextOverflow.ellipsis,
                      mFontWeight: FontWeight.normal,
                      mFontStyle: FontStyle.normal,
                      mTextAlign: TextAlign.start,
                      mTextColor: textTitleColor,
                    ),
                  ],
                ),
              ),
            ],
          ),
          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    MyText(
                      mTitle: suhu,
                      mFontSize: 12,
                      mFontWeight: FontWeight.normal,
                      mFontStyle: FontStyle.normal,
                      mTextAlign: TextAlign.start,
                      mTextColor: otherLightColor,
                    ),
                    const SizedBox(
                      height: 4,
                    ),
                    MyText(
                      mTitle: "......",
                      mFontSize: 14,
                      mFontWeight: FontWeight.normal,
                      mMaxLine: 1,
                      mOverflow: TextOverflow.ellipsis,
                      mFontStyle: FontStyle.normal,
                      mTextAlign: TextAlign.start,
                      mTextColor: textTitleColor,
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    MyText(
                      mTitle: tinggibadan,
                      mFontSize: 12,
                      mFontWeight: FontWeight.normal,
                      mFontStyle: FontStyle.normal,
                      mTextAlign: TextAlign.start,
                      mTextColor: otherLightColor,
                    ),
                    const SizedBox(
                      height: 4,
                    ),
                    MyText(
                      mTitle: "......",
                      mFontSize: 14,
                      mMaxLine: 1,
                      mOverflow: TextOverflow.ellipsis,
                      mFontWeight: FontWeight.normal,
                      mFontStyle: FontStyle.normal,
                      mTextAlign: TextAlign.start,
                      mTextColor: textTitleColor,
                    ),
                  ],
                ),
              ),
            ],
          ),
          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    MyText(
                      mTitle: heartrate,
                      mFontSize: 12,
                      mFontWeight: FontWeight.normal,
                      mFontStyle: FontStyle.normal,
                      mTextAlign: TextAlign.start,
                      mTextColor: otherLightColor,
                    ),
                    const SizedBox(
                      height: 4,
                    ),
                    MyText(
                      mTitle: "......",
                      mFontSize: 14,
                      mFontWeight: FontWeight.normal,
                      mMaxLine: 1,
                      mOverflow: TextOverflow.ellipsis,
                      mFontStyle: FontStyle.normal,
                      mTextAlign: TextAlign.start,
                      mTextColor: textTitleColor,
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    MyText(
                      mTitle: kesadaranpasien,
                      mFontSize: 12,
                      mFontWeight: FontWeight.normal,
                      mFontStyle: FontStyle.normal,
                      mTextAlign: TextAlign.start,
                      mTextColor: otherLightColor,
                    ),
                    const SizedBox(
                      height: 4,
                    ),
                    MyText(
                      mTitle: "......",
                      mFontSize: 14,
                      mMaxLine: 1,
                      mOverflow: TextOverflow.ellipsis,
                      mFontWeight: FontWeight.normal,
                      mFontStyle: FontStyle.normal,
                      mTextAlign: TextAlign.start,
                      mTextColor: textTitleColor,
                    ),
                  ],
                ),
              ),
            ],
          ),
          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    MyText(
                      mTitle: nadi,
                      mFontSize: 12,
                      mFontWeight: FontWeight.normal,
                      mFontStyle: FontStyle.normal,
                      mTextAlign: TextAlign.start,
                      mTextColor: otherLightColor,
                    ),
                    const SizedBox(
                      height: 4,
                    ),
                    MyText(
                      mTitle: "......",
                      mFontSize: 14,
                      mFontWeight: FontWeight.normal,
                      mMaxLine: 1,
                      mOverflow: TextOverflow.ellipsis,
                      mFontStyle: FontStyle.normal,
                      mTextAlign: TextAlign.start,
                      mTextColor: textTitleColor,
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    MyText(
                      mTitle: pernafasan,
                      mFontSize: 12,
                      mFontWeight: FontWeight.normal,
                      mFontStyle: FontStyle.normal,
                      mTextAlign: TextAlign.start,
                      mTextColor: otherLightColor,
                    ),
                    const SizedBox(
                      height: 4,
                    ),
                    MyText(
                      mTitle: "......",
                      mFontSize: 14,
                      mMaxLine: 1,
                      mOverflow: TextOverflow.ellipsis,
                      mFontWeight: FontWeight.normal,
                      mFontStyle: FontStyle.normal,
                      mTextAlign: TextAlign.start,
                      mTextColor: textTitleColor,
                    ),
                  ],
                ),
              ),
            ],
          ),
          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    MyText(
                      mTitle: beratbadan,
                      mFontSize: 12,
                      mFontWeight: FontWeight.normal,
                      mFontStyle: FontStyle.normal,
                      mTextAlign: TextAlign.start,
                      mTextColor: otherLightColor,
                    ),
                    const SizedBox(
                      height: 4,
                    ),
                    MyText(
                      mTitle: "......",
                      mFontSize: 14,
                      mFontWeight: FontWeight.normal,
                      mMaxLine: 1,
                      mOverflow: TextOverflow.ellipsis,
                      mFontStyle: FontStyle.normal,
                      mTextAlign: TextAlign.start,
                      mTextColor: textTitleColor,
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    MyText(
                      mTitle: lingkarperut,
                      mFontSize: 12,
                      mFontWeight: FontWeight.normal,
                      mFontStyle: FontStyle.normal,
                      mTextAlign: TextAlign.start,
                      mTextColor: otherLightColor,
                    ),
                    const SizedBox(
                      height: 4,
                    ),
                    MyText(
                      mTitle: "......",
                      mFontSize: 14,
                      mMaxLine: 1,
                      mOverflow: TextOverflow.ellipsis,
                      mFontWeight: FontWeight.normal,
                      mFontStyle: FontStyle.normal,
                      mTextAlign: TextAlign.start,
                      mTextColor: textTitleColor,
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 15,
          ),
          Container(
            height: 0.5,
            width: MediaQuery.of(context).size.width,
            color: otherLightColor,
          ),
          const SizedBox(
            height: 15,
          ),
          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              InkWell(
                borderRadius: BorderRadius.circular(4),
                onTap: () {
                  log("Tapped on " + accept);
                },
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [],
                ),
              ),
              Visibility(
                visible: false,
                child: InkWell(
                  borderRadius: BorderRadius.circular(4),
                  onTap: () {
                    log("Tapped on " + complete);
                  },
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      MySvgAssetsImg(
                        imageName: "tick_green.svg",
                        fit: BoxFit.cover,
                        imgHeight: 42,
                        imgWidth: 42,
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      MyText(
                        mTitle: complete,
                        mFontSize: 14,
                        mFontWeight: FontWeight.normal,
                        mMaxLine: 1,
                        mOverflow: TextOverflow.ellipsis,
                        mFontStyle: FontStyle.normal,
                        mTextAlign: TextAlign.start,
                        mTextColor: textTitleColor,
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                width: 50,
              ),
              InkWell(
                borderRadius: BorderRadius.circular(4),
                onTap: () {
                  log("Tapped on " + reject);
                },
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [],
                ),
              ),
              Visibility(
                visible: false,
                child: InkWell(
                  borderRadius: BorderRadius.circular(4),
                  onTap: () {
                    log("Tapped on " + absent);
                  },
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      MySvgAssetsImg(
                        imageName: "cross_red.svg",
                        fit: BoxFit.cover,
                        imgHeight: 42,
                        imgWidth: 42,
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      MyText(
                        mTitle: absent,
                        mFontSize: 14,
                        mFontWeight: FontWeight.normal,
                        mMaxLine: 1,
                        mOverflow: TextOverflow.ellipsis,
                        mFontStyle: FontStyle.normal,
                        mTextAlign: TextAlign.start,
                        mTextColor: textTitleColor,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 2,
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            alignment: Alignment.centerLeft,
            padding: const EdgeInsets.all(0),
            decoration: BoxDecoration(
              color: white,
              borderRadius: BorderRadius.circular(8),
              shape: BoxShape.rectangle,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                MyText(
                  mTitle: pemeriksaan,
                  mFontSize: 14,
                  mFontWeight: FontWeight.bold,
                  mFontStyle: FontStyle.normal,
                  mTextAlign: TextAlign.start,
                ),
                const SizedBox(
                  height: 4,
                ),
                const SizedBox(
                  height: 15,
                ),
                MyText(
                  mTitle: subjektive,
                  mFontSize: 12,
                  mFontWeight: FontWeight.normal,
                  mFontStyle: FontStyle.normal,
                  mTextAlign: TextAlign.start,
                  mTextColor: textTitleColor,
                ),
                const SizedBox(
                  height: 8,
                ),
                Container(
                  constraints: const BoxConstraints(
                    minHeight: 140,
                  ),
                  padding: const EdgeInsets.only(left: 15, right: 15),
                  decoration: Utility.r10BGWithBorder(),
                  alignment: Alignment.topCenter,
                  child: MyTextFormField(
                    mHint: textHere,
                    mController: mSubyektive,
                    mObscureText: false,
                    mMaxLine: 1,
                    mReadOnly: true,
                    mHintTextColor: textHintColor,
                    mTextColor: textTitleColor,
                    mkeyboardType: TextInputType.text,
                    mTextInputAction: TextInputAction.next,
                    mInputBorder: InputBorder.none,
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
                MyText(
                  mTitle: objective,
                  mFontSize: 12,
                  mFontWeight: FontWeight.normal,
                  mFontStyle: FontStyle.normal,
                  mTextAlign: TextAlign.start,
                  mTextColor: textTitleColor,
                ),
                const SizedBox(
                  height: 8,
                ),
                Container(
                  constraints: const BoxConstraints(
                    minHeight: 140,
                  ),
                  padding: const EdgeInsets.only(left: 15, right: 15),
                  decoration: Utility.r10BGWithBorder(),
                  alignment: Alignment.topCenter,
                  child: MyTextFormField(
                    mHint: textHere,
                    mController: mObjective,
                    mObscureText: false,
                    mMaxLine: 1,
                    mReadOnly: true,
                    mHintTextColor: textHintColor,
                    mTextColor: textTitleColor,
                    mkeyboardType: TextInputType.text,
                    mTextInputAction: TextInputAction.next,
                    mInputBorder: InputBorder.none,
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
                MyText(
                  mTitle: analyst,
                  mFontSize: 12,
                  mFontWeight: FontWeight.normal,
                  mFontStyle: FontStyle.normal,
                  mTextAlign: TextAlign.start,
                  mTextColor: textTitleColor,
                ),
                const SizedBox(
                  height: 8,
                ),
                Container(
                  constraints: const BoxConstraints(
                    minHeight: 140,
                  ),
                  padding: const EdgeInsets.only(left: 15, right: 15),
                  decoration: Utility.r10BGWithBorder(),
                  alignment: Alignment.topCenter,
                  child: MyTextFormField(
                    mHint: textHere,
                    mController: mAnalyst,
                    mObscureText: false,
                    mMaxLine: 1,
                    mReadOnly: true,
                    mHintTextColor: textHintColor,
                    mTextColor: textTitleColor,
                    mkeyboardType: TextInputType.text,
                    mTextInputAction: TextInputAction.next,
                    mInputBorder: InputBorder.none,
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                const SizedBox(
                  height: 15,
                ),
                Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    InkWell(
                      borderRadius: BorderRadius.circular(4),
                      onTap: () {
                        log("Tapped on " + accept);
                      },
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [],
                      ),
                    ),
                    Visibility(
                      visible: false,
                      child: InkWell(
                        borderRadius: BorderRadius.circular(4),
                        onTap: () {
                          log("Tapped on " + complete);
                        },
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            MySvgAssetsImg(
                              imageName: "tick_green.svg",
                              fit: BoxFit.cover,
                              imgHeight: 42,
                              imgWidth: 42,
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            MyText(
                              mTitle: complete,
                              mFontSize: 14,
                              mFontWeight: FontWeight.normal,
                              mMaxLine: 1,
                              mOverflow: TextOverflow.ellipsis,
                              mFontStyle: FontStyle.normal,
                              mTextAlign: TextAlign.start,
                              mTextColor: textTitleColor,
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 50,
                    ),
                    InkWell(
                      borderRadius: BorderRadius.circular(4),
                      onTap: () {
                        log("Tapped on " + reject);
                      },
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [],
                      ),
                    ),
                    Visibility(
                      visible: false,
                      child: InkWell(
                        borderRadius: BorderRadius.circular(4),
                        onTap: () {
                          log("Tapped on " + absent);
                        },
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            MySvgAssetsImg(
                              imageName: "cross_red.svg",
                              fit: BoxFit.cover,
                              imgHeight: 42,
                              imgWidth: 42,
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            MyText(
                              mTitle: absent,
                              mFontSize: 14,
                              mFontWeight: FontWeight.normal,
                              mMaxLine: 1,
                              mOverflow: TextOverflow.ellipsis,
                              mFontStyle: FontStyle.normal,
                              mTextAlign: TextAlign.start,
                              mTextColor: textTitleColor,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );

    var visibility = Visibility(
      visible: true,
      child: InkWell(
        borderRadius: BorderRadius.circular(4),
        onTap: () {
          log("Tapped on " + pemeriksaan);
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => const WritePrescription()));
        },
        child: Container(
          width: MediaQuery.of(context).size.width * 0.6,
          height: Constant.buttonHeight,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: white,
            borderRadius: BorderRadius.circular(4),
            shape: BoxShape.rectangle,
          ),
          child: MyText(
            mTitle: pemeriksaan,
            mFontSize: 16,
            mFontStyle: FontStyle.normal,
            mFontWeight: FontWeight.normal,
            mMaxLine: 1,
            mTextAlign: TextAlign.center,
            mTextColor: buttonTextColor,
          ),
        ),
      ),
    );
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: blue,
      appBar: myAppBar(),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Container(
          margin: const EdgeInsets.fromLTRB(20, 8, 20, 20),
          child: Column(
            children: <Widget>[
              Container(
                padding: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                  color: white,
                  borderRadius: BorderRadius.circular(8),
                  shape: BoxShape.rectangle,
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    ClipRRect(
                      borderRadius: BorderRadius.circular(5),
                      clipBehavior: Clip.antiAlias,
                      child: MyNetworkImage(
                        imageUrl:
                            "https://images.unsplash.com/photo-1494790108377-be9c29b29330?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=387&q=80",
                        fit: BoxFit.fill,
                        imgHeight: 66,
                        imgWidth: 66,
                      ),
                    ),
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.only(left: 13, right: 13),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            MyText(
                              mTitle: "Tonya Burns",
                              mTextAlign: TextAlign.start,
                              mTextColor: textTitleColor,
                              mFontSize: 14,
                              mFontStyle: FontStyle.normal,
                              mFontWeight: FontWeight.bold,
                            ),
                            const SizedBox(
                              height: 1,
                            ),
                            MyText(
                              mTitle: "Nomer Antrian 95",
                              mTextAlign: TextAlign.start,
                              mTextColor: pendingStatus,
                              mFontSize: 12,
                              mFontStyle: FontStyle.normal,
                              mFontWeight: FontWeight.w400,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 2,
              ),
              container,
              const SizedBox(
                height: 65,
              ),
              visibility,
            ],
          ),
        ),
      ),
    );
  }

  AppBar myAppBar() {
    return AppBar(
      elevation: 0,
      centerTitle: true,
      backgroundColor: statusBarColor,
      leading: IconButton(
        onPressed: () {
          Navigator.of(context).pop();
        },
        icon: MySvgAssetsImg(
          imageName: "back.svg",
          fit: BoxFit.contain,
          imgHeight: Constant.backBtnHeight,
          imgWidth: Constant.backBtnWidth,
        ),
      ),
      title: MyText(
        mTitle: appointment,
        mFontSize: 20,
        mFontStyle: FontStyle.normal,
        mFontWeight: FontWeight.normal,
        mTextAlign: TextAlign.center,
        mTextColor: white,
      ),
    );
  }
}
