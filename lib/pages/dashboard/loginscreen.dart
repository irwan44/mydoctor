import 'dart:convert';

import 'package:doctorapp/pages/lupa_password.dart';
import 'package:doctorapp/widgets/mytext.dart';
import 'package:flutter/material.dart';
import 'package:doctorapp/utils/strings.dart';
import 'package:flutter_icons_null_safety/flutter_icons_null_safety.dart';
import 'package:doctorapp/utils/colors.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:doctorapp/model/usermodel.dart';
import 'package:doctorapp/apiservice/serviceapi.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:doctorapp/provider/auth_user.dart';
import 'package:provider/provider.dart';
import 'package:doctorapp/pages/menu_drawer.dart';
import 'package:doctorapp/utils/utility.dart';

class LoginSignupScreen extends StatefulWidget {
  @override
  _LoginSignupScreenState createState() => _LoginSignupScreenState();
}

class _LoginSignupScreenState extends State<LoginSignupScreen> {
  bool isSignupScreen = false;
  bool isMale = true;
  bool isRememberMe = false;
  String username = "";
  String password = "";
  var _formkey = GlobalKey<FormState>();
  bool _keyfound = true;
  bool _isLoading = false;
  bool isPrivacyChecked = false;
  bool _passwordVisible = false;
  late bool _obscured = true;
  final textFieldFocusNode = FocusNode();
  TextEditingController _defuser = new TextEditingController();
  TextEditingController _defpass = new TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadUserEmailPassword();
    _obscured = true;
  }

  void _toggleObscured() {
    setState(() {
      _obscured = !_obscured;
      if (textFieldFocusNode.hasPrimaryFocus)
        return; // If focus is on text field, dont unfocus
      textFieldFocusNode.canRequestFocus =
          false; // Prevents focus if tap on eye
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Palette.backgroundColor,
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : Stack(
              children: [
                Positioned(
                  top: 0,
                  right: 0,
                  left: 0,
                  child: Container(
                    height: 350,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage("assets/images/login_bg.png"),
                            fit: BoxFit.fill)),
                    child: Container(
                      padding: EdgeInsets.only(top: 60, left: 20),
                      color: Color(0xFF3b5999).withOpacity(.75),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          RichText(
                            text: TextSpan(
                              text: Selamatdatang,
                              style: TextStyle(
                                fontSize: 25,
                                letterSpacing: 2,
                                color: Colors.yellow[700],
                              ),
                              // children: [
                              //   TextSpan(
                              //     text: signIn,
                              //     style: TextStyle(
                              //       fontSize: 25,
                              //       fontWeight: FontWeight.bold,
                              //       color: Colors.yellow[700],
                              //     ),
                              //   )
                              // ]
                            ),
                          ),
                          RichText(
                            text: TextSpan(
                              text: 'App SOAP Doctor',
                              style: TextStyle(
                                fontSize: 19,
                                letterSpacing: 2,
                                color: Colors.yellow[700],
                              ),
                              // children: [
                              //   TextSpan(
                              //     text: signIn,
                              //     style: TextStyle(
                              //       fontSize: 25,
                              //       fontWeight: FontWeight.bold,
                              //       color: Colors.yellow[700],
                              //     ),
                              //   )
                              // ]
                            ),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            "Signin to Continue",
                            style: TextStyle(
                              letterSpacing: 1,
                              color: Colors.white,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                // Trick to add the shadow for the submit button
                buildBottomHalfContainer(true),
                //Main Contianer for Login and Signup
                AnimatedPositioned(
                  duration: Duration(milliseconds: 700),
                  curve: Curves.bounceInOut,
                  top: 270, //isSignupScreen ? 270 : 230,
                  child: AnimatedContainer(
                    duration: Duration(milliseconds: 700),
                    curve: Curves.bounceInOut,
                    height: isSignupScreen ? 380 : 250,
                    padding: EdgeInsets.all(20),
                    width: MediaQuery.of(context).size.width - 40,
                    margin: EdgeInsets.symmetric(horizontal: 20),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15),
                        boxShadow: [
                          BoxShadow(
                              color: Colors.black.withOpacity(0.3),
                              blurRadius: 15,
                              spreadRadius: 5),
                        ]),
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          buildSigninSection(),
                        ],
                      ),
                    ),
                  ),
                ),

                buildBottomHalfExec(context, false),
              ],
            ),
    );
  }

  void _loadUserEmailPassword() async {
    try {
      SharedPreferences _prefs = await SharedPreferences.getInstance();
      var _id = _prefs.getString("id") ?? "";
      var _password = _prefs.getString("password") ?? "";
      _defuser.text = _id;
      _defpass.text = _password;

      //print('temp' + _id);
    } catch (e) {
      print(e);
    }
  }

  Future loginaplk() async {
    print({username, password});

    UserProfile? _usr = await UserApiService.getUser(username, password);

    if (_usr != null) {
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
        SharedPreferences.getInstance().then(
          (prefs) {
            prefs.setString('id', username);
            prefs.setString('password', password);
          },
        );

        Provider.of<AuthUserData>(context, listen: false).setDataUser(_usr);

        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => const MySideDrawer()));
      }
    }
  }

  Container buildSigninSection() {
    return Container(
      margin: EdgeInsets.only(top: 20),
      child: Column(
        children: [
          //buildTextField(Icons.mail_outline, "info@caleg.com", false, true),
          // buildTextField(
          //     MaterialCommunityIcons.lock_outline, "**********", true, false),

          CustomTextField(
            icon: Icons.mail_outline,
            //text: "Description: ",
            hintText: "info@averin.com ...",
            isEmail: true,
            isPassword: false,
            mdefaultText: _defuser,
            onSubmit: (value) {
              //here is the value for this widget with textfield
              setState(() {
                username = value.toString();
              });
            },
          ),
          CustomTextField(
            icon: Icons.lock_outline,
            //text: "Description: ",
            hintText: "**********",
            isEmail: false,
            isPassword: true,
            mdefaultText: _defpass,
            onSubmit: (value) {
              //here is the value for this widget with textfield
              //print(value);
              setState(() {
                password = value.toString();
              });
            },
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Checkbox(
                    value: isRememberMe,
                    activeColor: Palette.textColor2,
                    onChanged: (value) {
                      setState(() {
                        isRememberMe = !isRememberMe;
                      });
                    },
                  ),
                  Text("Remember me",
                      style: TextStyle(fontSize: 12, color: Palette.textColor1))
                ],
              ),
              // TextButton(
              //   onPressed: () {},
              //   child: Text("Forgot Password?",
              //       style: TextStyle(fontSize: 12, color: Palette.textColor1)),
              // )
              forgotPassClick(),
            ],
          ),
        ],
      ),
    );
  }

  Container buildSignupSection() {
    return Container(
      margin: EdgeInsets.only(top: 20),
      child: Column(
        children: [
          buildTextField(MaterialCommunityIcons.account_outline, "User Name",
              false, false),
          buildTextField(
              MaterialCommunityIcons.email_outline, "email", false, true),
          buildTextField(
              MaterialCommunityIcons.lock_outline, "password", true, false),
          Padding(
            padding: const EdgeInsets.only(top: 10, left: 10),
            child: Row(
              children: [
                GestureDetector(
                  onTap: () {
                    setState(() {
                      isMale = true;
                    });
                  },
                  child: Row(
                    children: [
                      Container(
                        width: 30,
                        height: 30,
                        margin: EdgeInsets.only(right: 8),
                        decoration: BoxDecoration(
                            color: isMale
                                ? Palette.textColor2
                                : Colors.transparent,
                            border: Border.all(
                                width: 1,
                                color: isMale
                                    ? Colors.transparent
                                    : Palette.textColor1),
                            borderRadius: BorderRadius.circular(15)),
                        child: Icon(
                          MaterialCommunityIcons.account_outline,
                          color: isMale ? Colors.white : Palette.iconColor,
                        ),
                      ),
                      Text(
                        "Male",
                        style: TextStyle(color: Palette.textColor1),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  width: 30,
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      isMale = false;
                    });
                  },
                  child: Row(
                    children: [
                      Container(
                        width: 30,
                        height: 30,
                        margin: EdgeInsets.only(right: 8),
                        decoration: BoxDecoration(
                            color: isMale
                                ? Colors.transparent
                                : Palette.textColor2,
                            border: Border.all(
                                width: 1,
                                color: isMale
                                    ? Palette.textColor1
                                    : Colors.transparent),
                            borderRadius: BorderRadius.circular(15)),
                        child: Icon(
                          MaterialCommunityIcons.account_outline,
                          color: isMale ? Palette.iconColor : Colors.white,
                        ),
                      ),
                      Text(
                        "Female",
                        style: TextStyle(color: Palette.textColor1),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
          Container(
            width: 200,
            margin: EdgeInsets.only(top: 20),
            child: RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                  text: "By pressing 'Submit' you agree to our ",
                  style: TextStyle(color: Palette.textColor2),
                  children: [
                    TextSpan(
                      //recognizer: ,
                      text: "term & conditions",
                      style: TextStyle(color: Colors.orange),
                    ),
                  ]),
            ),
          ),
        ],
      ),
    );
  }

  TextButton buildTextButton(
      IconData icon, String title, Color backgroundColor) {
    return TextButton(
      onPressed: () {},
      style: TextButton.styleFrom(
          side: BorderSide(width: 1, color: Colors.grey),
          minimumSize: Size(145, 40),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          primary: Colors.white,
          backgroundColor: backgroundColor),
      child: Row(
        children: [
          Icon(
            icon,
          ),
          SizedBox(
            width: 5,
          ),
          Text(
            title,
          )
        ],
      ),
    );
  }

  Widget forgotPassClick() {
    return InkWell(
      borderRadius: BorderRadius.circular(5),
      onTap: () {
        //log(LupaPassword + " tapped!");
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
            mFontSize: 14),
      ),
    );
  }

  Widget buildBottomHalfContainer(bool showShadow) {
    return AnimatedPositioned(
      duration: Duration(milliseconds: 700),
      curve: Curves.bounceInOut,
      top: isSignupScreen ? 535 : 430,
      right: 0,
      left: 0,
      child: Center(
        child: Container(
          height: 90,
          width: 90,
          padding: EdgeInsets.all(15),
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(50),
              boxShadow: [
                if (showShadow)
                  BoxShadow(
                    color: Colors.black.withOpacity(.3),
                    spreadRadius: 1.5,
                    blurRadius: 10,
                  )
              ]),
          child: !showShadow
              ? Container(
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                          colors: [Colors.orange, Colors.red],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight),
                      borderRadius: BorderRadius.circular(30),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.black.withOpacity(.3),
                            spreadRadius: 1,
                            blurRadius: 2,
                            offset: Offset(0, 1))
                      ]),
                  child: Icon(
                    Icons.arrow_forward,
                    color: Colors.white,
                  ),
                )
              : Center(),
        ),
      ),
    );
  }

  Widget privacyCheckBox() {
    return Container(
      //height: 100,
      padding: const EdgeInsets.only(top: 200, bottom: 10),
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

  Widget buildBottomHalfExec(BuildContext context, bool showShadow) {
    //) {
    return AnimatedPositioned(
      duration: Duration(milliseconds: 700),
      curve: Curves.bounceInOut,
      top: 475, // isSignupScreen ? 535 : 430,
      right: 0,
      left: 0,
      child: Center(
          child: GestureDetector(
        onTap: () async {
          await loginaplk();
          _isLoading = true;
        },
        child: Container(
          height: 90,
          width: 90,
          padding: EdgeInsets.all(15),
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(50),
              boxShadow: [
                if (showShadow)
                  BoxShadow(
                    color: Colors.black.withOpacity(.3),
                    spreadRadius: 1.5,
                    blurRadius: 10,
                  )
              ]),
          child: !showShadow
              ? Container(
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                          colors: [Colors.orange, Colors.red],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight),
                      borderRadius: BorderRadius.circular(30),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.black.withOpacity(.3),
                            spreadRadius: 1,
                            blurRadius: 2,
                            offset: Offset(0, 1))
                      ]),
                  child: Icon(
                    Icons.arrow_forward,
                    color: Colors.white,
                  ),
                )
              : Center(),
        ),
      )),
    );
  }

  Widget buildTextField(
      IconData icon, String hintText, bool isPassword, bool isEmail) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: TextField(
        obscureText: isPassword,
        keyboardType: isEmail ? TextInputType.emailAddress : TextInputType.text,
        decoration: InputDecoration(
          prefixIcon: Icon(
            icon,
            color: Palette.iconColor,
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Palette.textColor1),
            borderRadius: BorderRadius.all(Radius.circular(35.0)),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Palette.textColor1),
            borderRadius: BorderRadius.all(Radius.circular(35.0)),
          ),
          contentPadding: EdgeInsets.all(10),
          hintText: hintText,
          hintStyle: TextStyle(fontSize: 14, color: Palette.textColor1),
        ),
      ),
    );
  }

  Widget buildTextFieldWctl(IconData icon, String hintText, bool isPassword,
      bool isEmail, TextEditingController txt) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: TextField(
        obscureText: isPassword,
        controller: txt,
        keyboardType: isEmail ? TextInputType.emailAddress : TextInputType.text,
        decoration: InputDecoration(
          prefixIcon: Icon(
            icon,
            color: Palette.iconColor,
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Palette.textColor1),
            borderRadius: BorderRadius.all(Radius.circular(35.0)),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Palette.textColor1),
            borderRadius: BorderRadius.all(Radius.circular(35.0)),
          ),
          contentPadding: EdgeInsets.all(10),
          hintText: hintText,
          hintStyle: TextStyle(fontSize: 14, color: Palette.textColor1),
        ),
      ),
    );
  }
}

class CustomTextField extends StatelessWidget {
  IconData icon;
  bool isPassword;
  bool isEmail;
  //String text;
  String hintText;
  //textFieldFocusNode focusNode ,
  dynamic mObscureText;
  dynamic mdefaultText;
  Function(String) onSubmit;

  CustomTextField(
      {required this.icon,
      //required this.text,
      required this.hintText,
      required this.isEmail,
      required this.isPassword,
      this.mObscureText,
      this.mdefaultText,
      required this.onSubmit});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: TextField(
        obscureText: isPassword,
        onChanged: onSubmit,
        controller: mdefaultText,
        //focusNode: ,
        //onSaved: onSubmit(),
        keyboardType: isEmail ? TextInputType.emailAddress : TextInputType.text,
        decoration: InputDecoration(
          prefixIcon: Icon(
            icon,
            color: Palette.iconColor,
          ),
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Palette.textColor1),
            borderRadius: BorderRadius.all(Radius.circular(35.0)),
          ),
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Palette.textColor1),
            borderRadius: BorderRadius.all(Radius.circular(35.0)),
          ),
          contentPadding: EdgeInsets.all(10),
          hintText: hintText,
          hintStyle: TextStyle(fontSize: 14, color: Palette.textColor1),
        ),
      ),
    );
  }
}
