import 'dart:developer';

import 'package:doctorapp/pages/menu_drawer.dart';
import 'package:doctorapp/pages/lupa_password.dart';
import 'package:doctorapp/utils/colors.dart';
import 'package:doctorapp/utils/strings.dart';
import 'package:doctorapp/widgets/myassetsimg.dart';
import 'package:doctorapp/widgets/mytext.dart';
import 'package:doctorapp/widgets/mytextformfield.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../utils/constant.dart';
import '../utils/utility.dart';
import 'package:doctorapp/model/usermodel.dart';
import 'package:doctorapp/apiservice/serviceapi.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:doctorapp/provider/auth_user.dart';
import 'package:provider/provider.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _formKey = GlobalKey<FormState>();
  late bool isPrivacyChecked, _passwordVisible;
  final mEmailController = TextEditingController();
  final mPasswordController = TextEditingController();

  TextEditingController username = TextEditingController();
  TextEditingController password = TextEditingController();

  @override
  void initState() {
    isPrivacyChecked = false;
    _passwordVisible = false;
    super.initState();
  }

  @override
  void dispose() {
    mEmailController.dispose();
    mPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Column(
        children: <Widget>[
          Expanded(
            flex: 4,
            child: SizedBox(
              width: MediaQuery.of(context).size.width,
              child: MyAssetsImg(
                imageName: "login_bg.png",
                fit: BoxFit.fill,
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.only(left: 20, top: 15, right: 20),
            alignment: Alignment.centerLeft,
            child: MyText(
              mTitle: signIn,
              mTextColor: textTitleColor,
              mTextAlign: TextAlign.start,
              mFontWeight: FontWeight.w800,
              mFontSize: 32,
            ),
          ),
          Container(
            padding: const EdgeInsets.only(left: 20, right: 20),
            alignment: Alignment.centerLeft,
            child: MyText(
              mTitle: Selamatdatang,
              mTextColor: otherColor,
              mTextAlign: TextAlign.start,
              mFontWeight: FontWeight.w500,
              mFontSize: 18,
            ),
          ),
          Expanded(
            flex: 9,
            child: Container(
              padding: const EdgeInsets.all(20),
              child: Form(
                key: _formKey,
                child: Column(
                  children: <Widget>[
                    // Container(
                    //   height: Constant.textFieldHeight,
                    //   padding: const EdgeInsets.only(left: 10),
                    //   decoration: Utility.textFieldBGWithBorder(),
                    //   child: Row(
                    //     children: <Widget>[
                    //       Expanded(
                    //         flex: 5,
                    //         child: MyTextFormField(
                    //           mHint: kode,
                    //           mController: mEmailController,
                    //           mObscureText: false,
                    //           mMaxLine: 1,
                    //           mHintTextColor: textHintColor,
                    //           mTextColor: otherColor,
                    //           mkeyboardType: TextInputType.emailAddress,
                    //           mTextInputAction: TextInputAction.next,
                    //           mInputBorder: InputBorder.none,
                    //         ),
                    //       ),
                    //       Expanded(
                    //         flex: 1,
                    //         child: Container(
                    //           alignment: Alignment.center,
                    //         ),
                    //       ),
                    //     ],
                    //   ),
                    // ),
                    // const SizedBox(
                    //   height: 10,
                    // ),
                    Container(
                      height: Constant.textFieldHeight,
                      padding: const EdgeInsets.only(left: 10),
                      decoration: Utility.textFieldBGWithBorder(),
                      child: Row(
                        children: <Widget>[
                          Expanded(
                            flex: 5,
                            child: MyTextFormField(
                              mHint: emailAddressReq,
                              mController: username, //mEmailController,
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
                    const SizedBox(
                      height: 10,
                    ),
                    Container(
                      height: Constant.textFieldHeight,
                      padding: const EdgeInsets.only(left: 10),
                      decoration: Utility.textFieldBGWithBorder(),
                      child: Row(
                        children: <Widget>[
                          Expanded(
                            flex: 5,
                            child: MyTextFormField(
                              mHint: passwordReq,
                              mObscureText: _passwordVisible,
                              mController: password, //mPasswordController,
                              mHintTextColor: textHintColor,
                              mMaxLine: 1,
                              mTextColor: otherColor,
                              mInputBorder: InputBorder.none,
                              mkeyboardType: TextInputType.visiblePassword,
                              mTextInputAction: TextInputAction.done,
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: Container(
                              alignment: Alignment.center,
                              child: IconButton(
                                onPressed: () {
                                  setState(
                                    () {
                                      _passwordVisible = !_passwordVisible;
                                    },
                                  );
                                },
                                icon: Icon(
                                  _passwordVisible
                                      ? Icons.visibility
                                      : Icons.visibility_off,
                                  color: otherColor,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    privacyCheckBox(),
                    loginButton(context),
                    const SizedBox(
                      height: 20,
                    ),
                    forgotPassClick(),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void clearTextFormField() {
    mEmailController.clear();
    mPasswordController.clear();
  }

  Widget privacyCheckBox() {
    return Container(
      padding: const EdgeInsets.only(top: 5, bottom: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Transform.scale(
            scale: 1.1,
            child: Checkbox(
              checkColor: white,
              activeColor: accentColor,
              splashRadius: 20,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(3),
              ),
              value: isPrivacyChecked,
              onChanged: (bool? value) {
                print(value);
                setState(
                  () {
                    isPrivacyChecked = value!;
                  },
                );
              },
            ),
          ),
          Expanded(
            child: Utility.htmlTexts(privacyPolicyCheckBoxText),
          ),
        ],
      ),
    );
  }

  Widget loginButton(BuildContext context) {
    return InkWell(
      focusColor: primaryColor,
      onTap: () async {
        // Navigator.of(context).pushReplacement(
        //     MaterialPageRoute(builder: (context) => const MySideDrawer()));
        await loginaplk();
        // UserProfile? _usr =
        //     await UserApiService.getUser(enterEmail, enterPassword);

        // if (_usr != null) {
        //   print(_usr.userName);
        //   if (_usr.userName == "No") {
        //     await AwesomeDialog(
        //       context: context,
        //       dialogType: DialogType.INFO,
        //       animType: AnimType.SCALE,
        //       title: 'Data Tidak Valid',
        //       desc: 'Cek ID dan Password Anda',
        //       autoHide: const Duration(seconds: 5),
        //     ).show();
        //     return;
        //   } else {
        //     // final AuthUserData? tablesProvider =
        //     //     Provider.of<AuthUserData>(context, listen: false);
        //     // tablesProvider!.setDataUser(_usr);

        //     //Provider.of<AuthUserData>(context, listen: false).setDataUser(_usr);

        //     Navigator.of(context).pushReplacement(
        //         MaterialPageRoute(builder: (context) => const MySideDrawer()));
        // }
        // }
      },
      child: Container(
        width: MediaQuery.of(context).size.width * 0.55,
        height: Constant.buttonHeight,
        decoration: Utility.primaryDarkButton(),
        alignment: Alignment.center,
        child: MyText(
          mTitle: login.toUpperCase(),
          mTextColor: white,
          mTextAlign: TextAlign.center,
          mFontSize: 16,
          mFontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  Widget forgotPassClick() {
    return InkWell(
      borderRadius: BorderRadius.circular(5),
      onTap: () {
        log(LupaPassword + " tapped!");
        Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => const ForgotPassword()));
      },
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: MyText(
            mTitle: LupaPassword,
            mTextColor: otherLightColor,
            mTextAlign: TextAlign.start,
            mFontWeight: FontWeight.w500,
            mFontSize: 16),
      ),
    );
  }

  bool validatePassword(String? value) {
    if (value == null || value.isEmpty || (value.length < 5)) {
      return true;
    } else {
      return false;
    }
  }

  void validateFormDatas() async {
    final isValidForm = _formKey.currentState!.validate();
    log("isValidForm => $isValidForm");
    // Validate returns true if the form is valid, or false otherwise.
    if (isValidForm) {
      log("Email => " + mEmailController.text);
      log("Password => " + mPasswordController.text);
      log("isPrivacyChecked => $isPrivacyChecked");

      if (mEmailController.text.isEmpty) {
        Utility.showToast(enterEmail);
        return;
      }
      if (mPasswordController.text.isEmpty) {
        Utility.showToast(enterPassword);
        return;
      }
      if (!EmailValidator.validate(mEmailController.text)) {
        Utility.showToast(enterValidEmail);
        return;
      }
      if (mPasswordController.text.length < 6) {
        //Utility.showToast(enterMinimumCharacters + " in " + password);
        return;
      }
      if (!isPrivacyChecked) {
        Utility.showToast(acceptPrivacyPolicyMsg);
        return;
      }
      // If the form is valid, display a snackbar. In the real world,
      // you'd often call a server or save the information in a database.
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Login Successfull!')),
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
          title: const Text('Login Details'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                MyText(
                  mTitle: "Email : " +
                      mEmailController.text +
                      "\nPassword : " +
                      mPasswordController.text,
                  mTextColor: black,
                  mFontSize: 16,
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: MyText(
                mTitle: next,
                mTextColor: blue,
                mFontSize: 20,
                mFontStyle: FontStyle.normal,
                mFontWeight: FontWeight.w600,
                mTextAlign: TextAlign.center,
              ),
              onPressed: () {
                clearTextFormField();
                Navigator.pop(context);
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => const MySideDrawer()),
                );
              },
            ),
          ],
        );
      },
    );
  }

  Future loginaplk() async {
    //username = mEmailController;
    //password = mPasswordController;

    //UserProfile? _usr = await UserApiService.getUser(enterEmail, enterPassword);
    UserProfile? _usr =
        await UserApiService.getUser(username.text, password.text);

    if (_usr != null) {
      //print(_usr.userName);

      if (_usr.userName == "No") {
        await AwesomeDialog(
          context: context,
          dialogType: DialogType.INFO,
          animType: AnimType.SCALE,
          title: 'Data Tidak Valid',
          desc: _usr.userTitle, // 'Cek ID dan Password Anda',
          autoHide: const Duration(seconds: 5),
        ).show();
        return;
      } else {
        // final AuthUserData? tablesProvider =
        //     Provider.of<AuthUserData>(context, listen: false);
        // tablesProvider!.setDataUser(_usr);

        Provider.of<AuthUserData>(context, listen: false).setDataUser(_usr);

        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => const MySideDrawer()));
      }
    }
  }
}
