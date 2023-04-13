import 'package:doctorapp/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// ignore: must_be_immutable
class MyTextFormField extends StatelessWidget {
  dynamic mHint,
      mObscureText,
      mController,
      mkeyboardType,
      mTextInputAction,
      mInputBorder,
      mTextColor,
      mHintTextColor,
      mTextAlign,
      mMaxLine,
      mMaxLength,
      mReadOnly;

  MyTextFormField({
    Key? key,
    required this.mHint,
    this.mObscureText,
    this.mController,
    this.mkeyboardType,
    this.mTextInputAction,
    this.mInputBorder,
    this.mHintTextColor,
    this.mTextColor,
    this.mTextAlign,
    this.mMaxLine,
    this.mReadOnly,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: mController,
      keyboardType: mkeyboardType,
      textInputAction: mTextInputAction,
      obscureText: mObscureText,
      maxLength: mMaxLength,
      maxLines: mMaxLine,
      readOnly: mReadOnly ?? false,
      decoration: InputDecoration(
        hintText: mHint,
        hintStyle: GoogleFonts.roboto(
          fontSize: 16,
          color: mHintTextColor,
          fontWeight: FontWeight.normal,
          fontStyle: FontStyle.normal,
        ),
        border: mInputBorder,
      ),
      style: GoogleFonts.roboto(
        textStyle: TextStyle(
          fontSize: 16,
          color: mTextColor,
          fontWeight: FontWeight.normal,
          fontStyle: FontStyle.normal,
        ),
      ),
    );
  }
}

class MyTextFormFieldEntry extends StatelessWidget {
  dynamic mHint,
      mObscureText,
      mController,
      mkeyboardType,
      mTextInputAction,
      mInputBorder,
      mTextColor,
      mHintTextColor,
      mTextAlign,
      mMaxLine,
      mMaxLength,
      mReadOnly;
  double mHeight;
  double mWidth;

  MyTextFormFieldEntry({
    Key? key,
    this.mHint,
    this.mObscureText,
    this.mController,
    this.mkeyboardType,
    this.mTextInputAction,
    this.mInputBorder,
    this.mHintTextColor,
    this.mTextColor,
    this.mTextAlign,
    this.mMaxLine,
    this.mReadOnly,
    this.mWidth = 0,
    this.mHeight = 0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: mWidth,
      height: mHeight,

      margin: EdgeInsets.all(5),
      child: TextFormField(
        style: TextStyle(
            color: Color.fromARGB(255, 19, 1, 1),
            fontSize: 14,
            fontWeight: FontWeight.bold),
        controller: mController,
        maxLines: mMaxLine,
        decoration: const InputDecoration(
          fillColor: Colors.white,
          filled: true,
          //labelText: "Rate Pinjaman",
          labelStyle: TextStyle(
            fontSize: 16,
            color: Color.fromARGB(255, 26, 22, 22),
            fontFamily: 'RobotoMono',
            //fontStyle: fontFamily: 'RobotoMono'),
          ),
          //suffix: Text('%'),
        ),
        keyboardType: mkeyboardType,
        autocorrect: false,
        obscureText: false,
        onSaved: (data) {},
      ),
    );
    // return TextFormField(
    //   controller: mController,
    //   keyboardType: mkeyboardType,
    //   textInputAction: mTextInputAction,
    //   obscureText: mObscureText,
    //   maxLength: mMaxLength,
    //   maxLines: mMaxLine,
    //   readOnly: mReadOnly ?? false,
    //   decoration: InputDecoration(
    //     hintText: mHint,
    //     hintStyle: GoogleFonts.roboto(
    //       fontSize: 16,
    //       color: mHintTextColor,
    //       fontWeight: FontWeight.normal,
    //       fontStyle: FontStyle.normal,
    //     ),
    //     border: mInputBorder,
    //   ),
    //   style: GoogleFonts.roboto(
    //     textStyle: TextStyle(
    //       fontSize: 16,
    //       color: mTextColor,
    //       fontWeight: FontWeight.normal,
    //       fontStyle: FontStyle.normal,
    //     ),
    //   ),
    // );
  }
}
