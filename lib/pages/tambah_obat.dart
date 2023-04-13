import 'dart:developer';

import 'package:doctorapp/utils/colors.dart';
import 'package:doctorapp/utils/constant.dart';
import 'package:doctorapp/utils/strings.dart';
import 'package:doctorapp/utils/utility.dart';
import 'package:doctorapp/widgets/mysvgassetsimg.dart';
import 'package:doctorapp/widgets/mytext.dart';
import 'package:doctorapp/widgets/mytextformfield.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';

class AddMedicine extends StatefulWidget {
  const AddMedicine({Key? key}) : super(key: key);

  @override
  State<AddMedicine> createState() => _AddMedicineState();
}

class _AddMedicineState extends State<AddMedicine> {
  final _formKey = GlobalKey<FormState>();
  final mPillNameController = TextEditingController();
  final mHowManyController = TextEditingController();
  final mDaysController = TextEditingController();
  final mNoteController = TextEditingController();
  late String selectedTime, dropdownValue;

  @override
  void initState() {
    selectedTime = "";
    dropdownValue = "Tablet";
    super.initState();
  }

  @override
  void dispose() {
    mPillNameController.dispose();
    mHowManyController.dispose();
    mDaysController.dispose();
    mNoteController.dispose();
    selectedTime = "";
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: appBgColor,
      appBar: myAppBar(),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              margin: const EdgeInsets.all(20),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    MyText(
                      mTitle: pillname,
                      mFontSize: 14,
                      mFontWeight: FontWeight.bold,
                      mFontStyle: FontStyle.normal,
                      mTextAlign: TextAlign.start,
                      mTextColor: textTitleColor,
                    ),
                    const SizedBox(
                      height: 4,
                    ),
                    Container(
                      height: Constant.textFieldHeight,
                      padding: const EdgeInsets.only(left: 15, right: 15),
                      decoration: Utility.textFieldBGWithBorder(),
                      alignment: Alignment.centerLeft,
                      child: MyTextFormField(
                        mHint: enterPillName,
                        mController: mPillNameController,
                        mObscureText: false,
                        mMaxLine: 1,
                        mHintTextColor: textHintColor,
                        mTextColor: textTitleColor,
                        mkeyboardType: TextInputType.text,
                        mTextInputAction: TextInputAction.next,
                        mInputBorder: InputBorder.none,
                      ),
                    ),
                    const SizedBox(
                      height: 14,
                    ),
                    Row(
                      children: <Widget>[
                        Expanded(
                          flex: 4,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              MyText(
                                mTitle: howMany,
                                mFontSize: 14,
                                mFontWeight: FontWeight.bold,
                                mFontStyle: FontStyle.normal,
                                mTextAlign: TextAlign.start,
                                mTextColor: textTitleColor,
                              ),
                              const SizedBox(
                                height: 4,
                              ),
                              Container(
                                height: Constant.textFieldHeight,
                                padding:
                                    const EdgeInsets.only(left: 15, right: 12),
                                decoration: Utility.textFieldBGWithBorder(),
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: <Widget>[
                                    Expanded(
                                      child: MyTextFormField(
                                        mHint: count,
                                        mController: mHowManyController,
                                        mObscureText: false,
                                        mMaxLine: 1,
                                        mHintTextColor: textHintColor,
                                        mTextColor: textTitleColor,
                                        mkeyboardType: TextInputType.text,
                                        mTextInputAction: TextInputAction.next,
                                        mInputBorder: InputBorder.none,
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 5,
                                    ),
                                    Expanded(
                                      child: DropdownButtonHideUnderline(
                                        child: DropdownButtonFormField2(
                                          isExpanded: true,
                                          dropdownElevation: 3,
                                          decoration: const InputDecoration(
                                            border: InputBorder.none,
                                          ),
                                          icon: MySvgAssetsImg(
                                            imageName: "dropdown.svg",
                                            fit: BoxFit.cover,
                                            imgHeight: 5,
                                            imgWidth: 9,
                                            iconColor: textEdtHintColor,
                                          ),
                                          dropdownDecoration: BoxDecoration(
                                            color: white,
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            shape: BoxShape.rectangle,
                                          ),
                                          value: dropdownValue,
                                          onChanged: (String? newValue) {
                                            setState(() {
                                              dropdownValue = newValue!;
                                            });
                                          },
                                          hint: MyText(
                                            mTitle: medicineType,
                                            mFontSize: 14,
                                            mFontWeight: FontWeight.normal,
                                            mFontStyle: FontStyle.normal,
                                            mTextAlign: TextAlign.start,
                                            mTextColor: textHintColor,
                                          ),
                                          items: <String>[
                                            'Tablet',
                                            'Syrup',
                                            'Tube'
                                          ].map<DropdownMenuItem<String>>(
                                              (String value) {
                                            return DropdownMenuItem<String>(
                                              value: value,
                                              child: MyText(
                                                mTitle: value,
                                                mFontSize: 14,
                                                mFontWeight: FontWeight.normal,
                                                mFontStyle: FontStyle.normal,
                                                mTextAlign: TextAlign.start,
                                                mTextColor: textTitleColor,
                                              ),
                                            );
                                          }).toList(),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          width: 11,
                        ),
                        Expanded(
                          flex: 3,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              MyText(
                                mTitle: howLong,
                                mFontSize: 14,
                                mFontWeight: FontWeight.bold,
                                mFontStyle: FontStyle.normal,
                                mTextAlign: TextAlign.start,
                                mTextColor: textTitleColor,
                              ),
                              const SizedBox(
                                height: 4,
                              ),
                              Container(
                                height: Constant.textFieldHeight,
                                padding:
                                    const EdgeInsets.only(left: 15, right: 15),
                                decoration: Utility.textFieldBGWithBorder(),
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: <Widget>[
                                    Expanded(
                                      child: MyTextFormField(
                                        mHint: enterDays,
                                        mController: mDaysController,
                                        mObscureText: false,
                                        mMaxLine: 1,
                                        mHintTextColor: textHintColor,
                                        mTextColor: textTitleColor,
                                        mkeyboardType: TextInputType.text,
                                        mTextInputAction: TextInputAction.next,
                                        mInputBorder: InputBorder.none,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 14,
                    ),
                    MyText(
                      mTitle: whenToTake,
                      mFontSize: 14,
                      mFontWeight: FontWeight.bold,
                      mFontStyle: FontStyle.normal,
                      mTextAlign: TextAlign.start,
                      mTextColor: textTitleColor,
                    ),
                    const SizedBox(
                      height: 4,
                    ),
                    Row(
                      children: <Widget>[
                        Expanded(
                          child: InkWell(
                            onTap: () {
                              log("Tapped on " + beforeFood);
                              setState(() {
                                selectedTime = beforeFood;
                                log("selectedTime : " + selectedTime);
                              });
                            },
                            child: Container(
                              padding: const EdgeInsets.all(15),
                              decoration: selectedTime == beforeFood
                                  ? Utility.r4DarkBGWithBorder()
                                  : Utility.r4BGWithBorder(),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  MySvgAssetsImg(
                                    imageName: "food_dish.svg",
                                    fit: BoxFit.cover,
                                    imgHeight: 50,
                                    imgWidth: 50,
                                    iconColor: selectedTime == beforeFood
                                        ? white
                                        : other50OpacColor,
                                  ),
                                  const SizedBox(
                                    height: 9,
                                  ),
                                  MyText(
                                    mTitle: beforeFood,
                                    mFontSize: 14,
                                    mFontWeight: FontWeight.w400,
                                    mFontStyle: FontStyle.normal,
                                    mTextAlign: TextAlign.center,
                                    mTextColor: selectedTime == beforeFood
                                        ? white
                                        : other50OpacColor,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 9,
                        ),
                        Expanded(
                          child: InkWell(
                            onTap: () {
                              log("Tapped on " + withFood);
                              setState(() {
                                selectedTime = withFood;
                                log("selectedTime : " + selectedTime);
                              });
                            },
                            child: Container(
                              padding: const EdgeInsets.all(15),
                              decoration: selectedTime == withFood
                                  ? Utility.r4DarkBGWithBorder()
                                  : Utility.r4BGWithBorder(),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  MySvgAssetsImg(
                                    imageName: "food_dish.svg",
                                    fit: BoxFit.cover,
                                    imgHeight: 50,
                                    imgWidth: 50,
                                    iconColor: selectedTime == withFood
                                        ? white
                                        : other50OpacColor,
                                  ),
                                  const SizedBox(
                                    height: 9,
                                  ),
                                  MyText(
                                    mTitle: withFood,
                                    mFontSize: 14,
                                    mFontWeight: FontWeight.w400,
                                    mFontStyle: FontStyle.normal,
                                    mTextAlign: TextAlign.center,
                                    mTextColor: selectedTime == withFood
                                        ? white
                                        : other50OpacColor,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 9,
                        ),
                        Expanded(
                          child: InkWell(
                            onTap: () {
                              log("Tapped on " + afterFood);
                              setState(() {
                                selectedTime = afterFood;
                                log("selectedTime : " + selectedTime);
                              });
                            },
                            child: Container(
                              padding: const EdgeInsets.all(15),
                              decoration: selectedTime == afterFood
                                  ? Utility.r4DarkBGWithBorder()
                                  : Utility.r4BGWithBorder(),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  MySvgAssetsImg(
                                    imageName: "food_dish.svg",
                                    fit: BoxFit.cover,
                                    imgHeight: 50,
                                    imgWidth: 50,
                                    iconColor: selectedTime == afterFood
                                        ? white
                                        : other50OpacColor,
                                  ),
                                  const SizedBox(
                                    height: 9,
                                  ),
                                  MyText(
                                    mTitle: afterFood,
                                    mFontSize: 14,
                                    mFontWeight: FontWeight.w400,
                                    mFontStyle: FontStyle.normal,
                                    mTextAlign: TextAlign.center,
                                    mTextColor: selectedTime == afterFood
                                        ? white
                                        : other50OpacColor,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 14,
                    ),
                    MyText(
                      mTitle: additionalNote,
                      mFontSize: 14,
                      mFontWeight: FontWeight.bold,
                      mFontStyle: FontStyle.normal,
                      mTextAlign: TextAlign.start,
                      mTextColor: textTitleColor,
                    ),
                    const SizedBox(
                      height: 4,
                    ),
                    ConstrainedBox(
                      constraints: BoxConstraints(
                        minHeight: 140,
                        minWidth: MediaQuery.of(context).size.width,
                      ),
                      child: Container(
                        padding: const EdgeInsets.only(left: 15, right: 15),
                        decoration: Utility.r10BGWithBorder(),
                        child: MyTextFormField(
                          mHint: textHere,
                          mController: mNoteController,
                          mObscureText: false,
                          mHintTextColor: textHintColor,
                          mTextColor: textTitleColor,
                          mkeyboardType: TextInputType.multiline,
                          mTextInputAction: TextInputAction.done,
                          mInputBorder: InputBorder.none,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 22,
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: InkWell(
                        borderRadius: BorderRadius.circular(4),
                        onTap: () {
                          log("Tapped on " + save);
                          log("PillName : " + mPillNameController.text);
                          log("How Many : " + mHowManyController.text);
                          log("How Long : " + mDaysController.text);
                          log("Note : " + mNoteController.text);
                          setState(() {
                            selectedTime = "";
                            clearTextFormField();
                          });
                        },
                        child: Container(
                          width: MediaQuery.of(context).size.width * 0.45,
                          height: Constant.buttonHeight,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: blue,
                            borderRadius: BorderRadius.circular(4),
                            shape: BoxShape.rectangle,
                          ),
                          child: MyText(
                            mTitle: save,
                            mFontSize: 16,
                            mFontStyle: FontStyle.normal,
                            mFontWeight: FontWeight.normal,
                            mMaxLine: 1,
                            mTextAlign: TextAlign.center,
                            mTextColor: white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
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
        mTitle: tambahobat,
        mFontSize: 20,
        mFontStyle: FontStyle.normal,
        mFontWeight: FontWeight.normal,
        mTextAlign: TextAlign.center,
        mTextColor: white,
      ),
    );
  }

  void clearTextFormField() {
    mPillNameController.clear();
    mHowManyController.clear();
    mDaysController.clear();
    mNoteController.clear();
  }
}
