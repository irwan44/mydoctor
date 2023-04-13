import 'dart:developer';

import 'package:doctorapp/utils/colors.dart';
import 'package:doctorapp/utils/strings.dart';
import 'package:doctorapp/utils/utility.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../utils/constant.dart';
import '../widgets/myassetsimg.dart';
import '../widgets/mytext.dart';
import '../widgets/mytextformfield.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({Key? key}) : super(key: key);

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  final _formKey = GlobalKey<FormState>();
  final mEmailController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    mEmailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: Utility.myAppBar(context, lupapassword),
      body: Container(
        padding: const EdgeInsets.fromLTRB(20.0, 0, 20.0, 0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            SizedBox(
              child: MyAssetsImg(
                imgHeight: MediaQuery.of(context).size.height * 0.2,
                imageName: "app_icon.png",
                fit: BoxFit.contain,
              ),
            ),
            Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.all(30.0),
                      child: MyText(
                        mTitle: lupaNote,
                        mFontSize: 16.0,
                        mFontStyle: FontStyle.normal,
                        mFontWeight: FontWeight.normal,
                        mTextAlign: TextAlign.center,
                        mTextColor: otherColor,
                      ),
                    ),
                  ),
                  Container(
                    height: Constant.textFieldHeight,
                    padding: const EdgeInsets.only(left: 10.0),
                    decoration: Utility.textFieldBGWithBorder(),
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          flex: 5,
                          child: MyTextFormField(
                            mHint: emailAddressReq,
                            mController: mEmailController,
                            mObscureText: false,
                            mMaxLine: 1,
                            mHintTextColor: textHintColor,
                            mTextColor: otherColor,
                            mkeyboardType: TextInputType.emailAddress,
                            mTextInputAction: TextInputAction.next,
                            mInputBorder: InputBorder.none,
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Container(
                            alignment: Alignment.center,
                            child: const Icon(
                              Icons.email,
                              color: otherColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 30.0, bottom: 30.0),
                    child: sendButton(),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget sendButton() {
    return InkWell(
      focusColor: primaryColor,
      onTap: () => validateFormData(),
      child: Container(
        width: MediaQuery.of(context).size.width * 0.55,
        height: Constant.buttonHeight,
        decoration: Utility.primaryDarkButton(),
        alignment: Alignment.center,
        child: MyText(
          mTitle: Kirim.toUpperCase(),
          mTextColor: white,
          mTextAlign: TextAlign.center,
          mFontSize: 16.0,
          mFontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  void validateFormData() async {
    final isValidForm = _formKey.currentState!.validate();
    log("isValidForm => $isValidForm");
    // Validate returns true if the form is valid, or false otherwise.
    if (isValidForm) {
      log("Email => " + mEmailController.text);

      if (mEmailController.text.isEmpty) {
        Utility.showToast(enterEmail);
        return;
      }
      if (!EmailValidator.validate(mEmailController.text)) {
        Utility.showToast(enterValidEmail);
        return;
      }
      // If the form is valid, display a snackbar. In the real world,
      // you'd often call a server or save the information in a database.
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Password has been send Successfully!')),
      );

      await showMyDialog();
    }
  }

  Future<void> showMyDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Lupa Password Details'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                MyText(
                  mTitle: "Email : " + mEmailController.text,
                  mTextColor: black,
                  mFontSize: 16.0,
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: MyText(
                mTitle: okay,
                mTextColor: blue,
                mFontSize: 20.0,
                mFontStyle: FontStyle.normal,
                mFontWeight: FontWeight.w600,
                mTextAlign: TextAlign.center,
              ),
              onPressed: () {
                log(okay + " tapped!");
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
