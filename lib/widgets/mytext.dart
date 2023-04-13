import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// ignore: must_be_immutable
class MyText extends StatelessWidget {
  String mTitle;
  double? mFontSize;
  dynamic mFontWeight,
      mFontStyle,
      mTextColor,
      mTextAlign,
      mMaxLine,
      mOverflow,
      mLetterSpacing;

  MyText(
      {Key? key,
      required this.mTitle,
      this.mFontSize,
      this.mFontWeight,
      this.mFontStyle,
      this.mTextColor,
      this.mTextAlign,
      this.mMaxLine,
      this.mOverflow,
      this.mLetterSpacing})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Text(
        mTitle,
        textAlign: mTextAlign,
        maxLines: mMaxLine,
        overflow: mOverflow,
        style: GoogleFonts.roboto(
          textStyle: TextStyle(
            fontSize: mFontSize,
            color: mTextColor,
            fontWeight: mFontWeight,
            fontStyle: mFontStyle,
            letterSpacing: mLetterSpacing,
          ),
        ),
      ),
    );
  }
}
