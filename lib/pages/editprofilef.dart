import 'dart:developer';
import 'dart:io';

import 'package:doctorapp/pages/tambahkan_slot.dart';
import 'package:doctorapp/utils/colors.dart';
import 'package:doctorapp/utils/constant.dart';
import 'package:doctorapp/utils/strings.dart';
import 'package:doctorapp/utils/utility.dart';
import 'package:doctorapp/widgets/mynetworkimg.dart';
import 'package:doctorapp/widgets/mysvgassetsimg.dart';
import 'package:doctorapp/widgets/mytext.dart';
import 'package:doctorapp/widgets/mytextformfield.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
//import 'package:flutter_google_places/flutter_google_places.dart';
import 'package:google_api_headers/google_api_headers.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
//import 'package:google_maps_webservice/places.dart';
import 'package:im_stepper/stepper.dart';
import 'package:image_picker/image_picker.dart';

class EditProfileF extends StatefulWidget {
  const EditProfileF({Key? key}) : super(key: key);

  @override
  State<EditProfileF> createState() => _EditProfileFState();
}

class _EditProfileFState extends State<EditProfileF> {
  File? pickedImageFile;
  final ImagePicker imagePicker = ImagePicker();
  List<String> weekDays = [
    'Monday',
    'Tuesday',
    'Wednesday',
    'Thursday',
    'Friday',
    'Saturday',
    'Sunday',
  ];

  String specialityValue = "Cardiologist";
  bool _passwordVisible = false, visiblePrev = false;
  // THE FOLLOWING TWO VARIABLES ARE REQUIRED TO CONTROL THE STEPPER.
  int activeStep = 0; // Initial step set to 0.
  int upperBound = 2; // upperBound = (total number of Step) - 1.

  List<String> serviceChipList = [], healthCareChipList = [];
  final _formKey = GlobalKey<FormState>();
  final mFirstNameController = TextEditingController();
  final mLastNameController = TextEditingController();
  final mEmailController = TextEditingController();
  final mPasswordController = TextEditingController();
  final mMobileController = TextEditingController();
  final mAddressController = TextEditingController();
  final mAboutUsController = TextEditingController();
  final mServiceController = TextEditingController();
  final mHealthCareController = TextEditingController();
  final mInstaController = TextEditingController();
  final mFacebookController = TextEditingController();
  final mTwitterController = TextEditingController();

  GoogleMapController? mapController; //contrller for Google map
  final mSearchController = TextEditingController();
  CameraPosition? cameraPosition;
  LatLng startLocation = const LatLng(23.1784359726, 72.6385116577);
  String location = "Search Location";
  MapType currentMapType = MapType.normal;
  final Map<String, Marker> _markers = {};

  Future<void> _onMapCreated(GoogleMapController controller) async {
    setState(() {
      mapController = controller;
    });
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    mFirstNameController.dispose();
    mLastNameController.dispose();
    mEmailController.dispose();
    mPasswordController.dispose();
    mMobileController.dispose();
    mAddressController.dispose();
    mAboutUsController.dispose();
    mServiceController.dispose();
    mHealthCareController.dispose();
    mInstaController.dispose();
    mFacebookController.dispose();
    mTwitterController.dispose();
    specialityValue = "Cardiologist";

    mSearchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: <Widget>[
        Column(
          children: [
            Container(
              padding: const EdgeInsets.fromLTRB(20, 8, 20, 20),
              decoration: Utility.toolbarGradientBG(),
              child: buildStepper(),
            ),
            Expanded(
              child: createPageOnClick(),
            ),
          ],
        ),
        Positioned(
          bottom: 35,
          child: nextPreviousButton(),
        ),
      ],
    );
  }

  Widget createPageOnClick() {
    if (activeStep == 0) {
      return doctorDetailsEditPage();
    } else if (activeStep == 1) {
      return locationEditPage();
    } else if (activeStep == 2) {
      return workHourEditPage();
    } else {
      return doctorDetailsEditPage();
    }
  }

  Widget buildStepper() {
    return NumberStepper(
      stepColor: inActiveColor,
      lineColor: inActiveColor,
      activeStepColor: accentColor,
      numberStyle: const TextStyle(
        color: white,
      ),
      enableNextPreviousButtons: false,
      numbers: const [
        1,
        2,
        3,
      ],
      // activeStep property set to activeStep variable defined above.
      activeStep: activeStep,
      // This ensures step-tapping updates the activeStep.
      onStepReached: (index) {
        setState(() {
          activeStep = index;
        });
      },
    );
  }

  Widget nextPreviousButton() {
    return SizedBox(
      height: Constant.buttonHeight,
      width: MediaQuery.of(context).size.width,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(
            width: 20,
          ),
          Visibility(
            visible: activeStep == 0 ? false : true,
            child: Expanded(
              child: InkWell(
                onTap: () {
                  print('Tapped on ' + previous);
                  log('activeStep :=> $activeStep');
                  log('upperBound :=> $upperBound');
                  // Decrement activeStep, when the previous button is tapped. However, check for lower bound i.e., must be greater than 0.
                  if (activeStep > 0) {
                    setState(() {
                      activeStep--;
                    });
                  }
                },
                child: Container(
                  margin: const EdgeInsets.only(left: 5, right: 5),
                  alignment: Alignment.center,
                  decoration: Utility.primaryDarkButton(),
                  child: MyText(
                    mTitle: previous.toUpperCase(),
                    mFontSize: 16,
                    mFontStyle: FontStyle.normal,
                    mFontWeight: FontWeight.normal,
                    mTextAlign: TextAlign.center,
                    mTextColor: white,
                  ),
                ),
              ),
            ),
          ),
          Visibility(
            visible: true,
            child: Expanded(
              child: InkWell(
                onTap: () {
                  print('Tapped on ' + next);
                  log('activeStep :=> $activeStep');
                  log('upperBound :=> $upperBound');
                  // Increment activeStep, when the next button is tapped. However, check for upper bound.
                  if (activeStep < upperBound) {
                    setState(() {
                      activeStep++;
                    });
                  }
                },
                child: Container(
                  margin: const EdgeInsets.only(left: 5, right: 5),
                  alignment: Alignment.center,
                  decoration: Utility.primaryDarkButton(),
                  child: MyText(
                    mTitle: activeStep == 2
                        ? finish.toUpperCase()
                        : next.toUpperCase(),
                    mFontSize: 16,
                    mFontStyle: FontStyle.normal,
                    mFontWeight: FontWeight.normal,
                    mTextAlign: TextAlign.center,
                    mTextColor: white,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(
            width: 20,
          ),
        ],
      ),
    );
  }

// ====== Doctor Details Edit layout START ====== //
  Widget doctorDetailsEditPage() {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          const SizedBox(
            height: 20,
          ),
          Stack(
            alignment: Alignment.center,
            clipBehavior: Clip.antiAlias,
            children: <Widget>[
              ClipRRect(
                borderRadius: BorderRadius.circular(40),
                clipBehavior: Clip.antiAlias,
                child: pickedImageFile != null
                    ? Image.file(
                        pickedImageFile!,
                        fit: BoxFit.cover,
                        height: 80,
                        width: 80,
                      )
                    : MyNetworkImage(
                        imageUrl:
                            "https://images.unsplash.com/photo-1494790108377-be9c29b29330?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=387&q=80",
                        fit: BoxFit.cover,
                        imgHeight: 80,
                        imgWidth: 80,
                      ),
              ),
              Positioned(
                child: InkWell(
                  onTap: () {
                    imagePickDialog();
                  },
                  borderRadius: BorderRadius.circular(40),
                  child: Container(
                    alignment: Alignment.center,
                    height: 80,
                    width: 80,
                    decoration: const BoxDecoration(
                      color: black70,
                      shape: BoxShape.circle,
                    ),
                    child: MySvgAssetsImg(
                      imageName: 'edit_camera.svg',
                      fit: BoxFit.fill,
                      imgHeight: 27,
                      imgWidth: 27,
                    ),
                  ),
                ),
              ),
            ],
          ),
          Container(
            padding: const EdgeInsets.all(20),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  //===== FirstName =====//
                  Container(
                    height: Constant.textFieldHeight,
                    padding: const EdgeInsets.only(left: 15, right: 15),
                    decoration: Utility.textFieldBGWithBorder(),
                    alignment: Alignment.centerLeft,
                    child: MyTextFormField(
                      mHint: namapertama,
                      mController: mFirstNameController,
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
                  //===== LastName =====//
                  Container(
                    height: Constant.textFieldHeight,
                    padding: const EdgeInsets.only(left: 15, right: 15),
                    decoration: Utility.textFieldBGWithBorder(),
                    alignment: Alignment.centerLeft,
                    child: MyTextFormField(
                      mHint: terakhirdiperiksa,
                      mController: mLastNameController,
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
                  //===== Email =====//
                  Container(
                    height: Constant.textFieldHeight,
                    padding: const EdgeInsets.only(left: 15, right: 15),
                    decoration: Utility.textFieldBGWithBorder(),
                    alignment: Alignment.centerLeft,
                    child: MyTextFormField(
                      mHint: emailAddressReq,
                      mController: mEmailController,
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
                  //===== Password =====//
                  Container(
                    height: Constant.textFieldHeight,
                    padding: const EdgeInsets.only(left: 15, right: 15),
                    decoration: Utility.textFieldBGWithBorder(),
                    alignment: Alignment.centerLeft,
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          child: MyTextFormField(
                            mHint: password,
                            mController: mPasswordController,
                            mObscureText: _passwordVisible,
                            mMaxLine: 1,
                            mHintTextColor: textHintColor,
                            mTextColor: textTitleColor,
                            mkeyboardType: TextInputType.text,
                            mTextInputAction: TextInputAction.next,
                            mInputBorder: InputBorder.none,
                          ),
                        ),
                        Container(
                          alignment: Alignment.center,
                          child: IconButton(
                            onPressed: () {
                              setState(() {
                                _passwordVisible = !_passwordVisible;
                              });
                            },
                            icon: Icon(
                              _passwordVisible
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                              color: otherColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 14,
                  ),
                  //===== Phone Number =====//
                  Container(
                    height: Constant.textFieldHeight,
                    padding: const EdgeInsets.only(left: 15, right: 15),
                    decoration: Utility.textFieldBGWithBorder(),
                    alignment: Alignment.centerLeft,
                    child: MyTextFormField(
                      mHint: phoneNumberReq,
                      mController: mMobileController,
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
                  //===== Address =====//
                  MyText(
                    mTitle: address,
                    mFontSize: 18,
                    mFontWeight: FontWeight.bold,
                    mFontStyle: FontStyle.normal,
                    mTextAlign: TextAlign.start,
                    mTextColor: textTitleColor,
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Container(
                    height: Constant.textFieldHeight,
                    padding: const EdgeInsets.only(left: 15, right: 15),
                    decoration: Utility.textFieldBGWithBorder(),
                    alignment: Alignment.centerLeft,
                    child: MyTextFormField(
                      mHint: address,
                      mController: mAddressController,
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
                  //===== Speciality =====//
                  MyText(
                    mTitle: speciality,
                    mFontSize: 18,
                    mFontWeight: FontWeight.bold,
                    mFontStyle: FontStyle.normal,
                    mTextAlign: TextAlign.start,
                    mTextColor: textTitleColor,
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Container(
                    height: Constant.textFieldHeight,
                    padding: const EdgeInsets.only(left: 15, right: 15),
                    decoration: Utility.textFieldBGWithBorder(),
                    alignment: Alignment.centerLeft,
                    child: DropdownButtonHideUnderline(
                      child: DropdownButtonFormField2(
                        isExpanded: true,
                        dropdownElevation: 3,
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                        ),
                        dropdownDecoration: BoxDecoration(
                          color: white,
                          borderRadius: BorderRadius.circular(10),
                          shape: BoxShape.rectangle,
                        ),
                        value: specialityValue,
                        onChanged: (String? newValue) {
                          log('$newValue');
                          setState(() {
                            specialityValue = newValue!;
                          });
                        },
                        hint: MyText(
                          mTitle: speciality,
                          mFontSize: 16,
                          mFontWeight: FontWeight.normal,
                          mFontStyle: FontStyle.normal,
                          mTextAlign: TextAlign.start,
                          mTextColor: textHintColor,
                        ),
                        items: <String>['Cardiologist', 'Nurologist', 'Dentist']
                            .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: MyText(
                              mTitle: value,
                              mFontSize: 15,
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
                  const SizedBox(
                    height: 14,
                  ),
                  //===== About Us =====//
                  MyText(
                    mTitle: aboutUs,
                    mFontSize: 18,
                    mFontWeight: FontWeight.bold,
                    mFontStyle: FontStyle.normal,
                    mTextAlign: TextAlign.start,
                    mTextColor: textTitleColor,
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Container(
                    height: Constant.textFieldHeight,
                    padding: const EdgeInsets.only(left: 15, right: 15),
                    decoration: Utility.textFieldBGWithBorder(),
                    alignment: Alignment.centerLeft,
                    child: MyTextFormField(
                      mHint: aboutUs,
                      mController: mAboutUsController,
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
                    height: 20,
                  ),
                  //===== Services =====//
                  MyText(
                    mTitle: services,
                    mFontSize: 18,
                    mFontWeight: FontWeight.bold,
                    mFontStyle: FontStyle.normal,
                    mTextAlign: TextAlign.start,
                    mTextColor: textTitleColor,
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  ConstrainedBox(
                    constraints: BoxConstraints(
                      minHeight: Constant.textFieldHeight,
                      minWidth: MediaQuery.of(context).size.width,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          height: Constant.textFieldHeight,
                          padding: const EdgeInsets.only(left: 15, right: 15),
                          decoration: Utility.textFieldBGWithBorder(),
                          alignment: Alignment.centerLeft,
                          child: TextFormField(
                            controller: mServiceController,
                            keyboardType: TextInputType.text,
                            textInputAction: TextInputAction.done,
                            obscureText: false,
                            maxLines: 1,
                            onEditingComplete: () {
                              print(mServiceController.text);
                            },
                            onFieldSubmitted: (vService) {
                              print(vService);
                              if (vService.isNotEmpty) {
                                serviceChipList.add(vService);
                                print(serviceChipList.length);
                                mServiceController.clear();
                                setState(() {
                                  addServiceChips();
                                });
                              }
                            },
                            decoration: InputDecoration(
                              hintText: servicesHint,
                              hintStyle: GoogleFonts.roboto(
                                fontSize: 16,
                                color: textHintColor,
                                fontWeight: FontWeight.normal,
                                fontStyle: FontStyle.normal,
                              ),
                              border: InputBorder.none,
                            ),
                            style: GoogleFonts.roboto(
                              textStyle: const TextStyle(
                                fontSize: 16,
                                color: textTitleColor,
                                fontWeight: FontWeight.normal,
                                fontStyle: FontStyle.normal,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 3,
                        ),
                        addServiceChips(),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 14,
                  ),
                  //===== Health Care =====//
                  MyText(
                    mTitle: healthCare,
                    mFontSize: 18,
                    mFontWeight: FontWeight.bold,
                    mFontStyle: FontStyle.normal,
                    mTextAlign: TextAlign.start,
                    mTextColor: textTitleColor,
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  ConstrainedBox(
                    constraints: BoxConstraints(
                      minHeight: 55,
                      minWidth: MediaQuery.of(context).size.width,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          height: Constant.textFieldHeight,
                          padding: const EdgeInsets.only(left: 15, right: 15),
                          decoration: Utility.textFieldBGWithBorder(),
                          alignment: Alignment.centerLeft,
                          child: TextFormField(
                            controller: mHealthCareController,
                            keyboardType: TextInputType.text,
                            textInputAction: TextInputAction.done,
                            obscureText: false,
                            maxLines: 1,
                            onEditingComplete: () {
                              print('onEditingComplete :=> ' +
                                  mHealthCareController.text);
                            },
                            onFieldSubmitted: (vHealthCare) {
                              print('vService :=> ' + vHealthCare);
                              if (vHealthCare.isNotEmpty) {
                                healthCareChipList.add(vHealthCare);
                                print(healthCareChipList.length);
                                mHealthCareController.clear();
                                setState(() {
                                  addHealthCareChips();
                                });
                              }
                            },
                            decoration: InputDecoration(
                              hintText: healthCareHint,
                              hintStyle: GoogleFonts.roboto(
                                fontSize: 16,
                                color: textHintColor,
                                fontWeight: FontWeight.normal,
                                fontStyle: FontStyle.normal,
                              ),
                              border: InputBorder.none,
                            ),
                            style: GoogleFonts.roboto(
                              textStyle: const TextStyle(
                                fontSize: 16,
                                color: textTitleColor,
                                fontWeight: FontWeight.normal,
                                fontStyle: FontStyle.normal,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        addHealthCareChips(),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 14,
                  ),
                  //===== Social Info =====//
                  // Insta URL //
                  MyText(
                    mTitle: socialInfo,
                    mFontSize: 18,
                    mFontWeight: FontWeight.bold,
                    mFontStyle: FontStyle.normal,
                    mTextAlign: TextAlign.start,
                    mTextColor: textTitleColor,
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Container(
                    height: Constant.textFieldHeight,
                    padding: const EdgeInsets.only(left: 15, right: 15),
                    decoration: Utility.textFieldBGWithBorder(),
                    alignment: Alignment.centerLeft,
                    child: MyTextFormField(
                      mHint: instagramURL,
                      mController: mInstaController,
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
                  // Fb URL //
                  Container(
                    height: Constant.textFieldHeight,
                    padding: const EdgeInsets.only(left: 15, right: 15),
                    decoration: Utility.textFieldBGWithBorder(),
                    alignment: Alignment.centerLeft,
                    child: MyTextFormField(
                      mHint: facebookURL,
                      mController: mFacebookController,
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
                  // Twitter URL //
                  Container(
                    height: Constant.textFieldHeight,
                    padding: const EdgeInsets.only(left: 15, right: 15),
                    decoration: Utility.textFieldBGWithBorder(),
                    alignment: Alignment.centerLeft,
                    child: MyTextFormField(
                      mHint: twitterURL,
                      mController: mTwitterController,
                      mObscureText: false,
                      mMaxLine: 1,
                      mHintTextColor: textHintColor,
                      mTextColor: textTitleColor,
                      mkeyboardType: TextInputType.text,
                      mTextInputAction: TextInputAction.done,
                      mInputBorder: InputBorder.none,
                    ),
                  ),
                  const SizedBox(
                    height: 100,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget addServiceChips() {
    return Container(
      constraints: const BoxConstraints(
        minHeight: 0,
        maxHeight: 50,
      ),
      child: serviceChipList.isNotEmpty
          ? ListView.builder(
              scrollDirection: Axis.horizontal,
              shrinkWrap: true,
              itemCount: serviceChipList.length,
              itemBuilder: (BuildContext context, int position) {
                return buildChips(
                  serviceChipList.elementAt(position),
                  position,
                );
              },
            )
          : Container(),
    );
  }

  Widget addHealthCareChips() {
    return Container(
      constraints: const BoxConstraints(
        minHeight: 0,
        maxHeight: 50,
      ),
      child: healthCareChipList.isNotEmpty
          ? ListView.builder(
              scrollDirection: Axis.horizontal,
              shrinkWrap: true,
              itemCount: healthCareChipList.length,
              itemBuilder: (BuildContext context, int position) {
                return buildChips(
                  healthCareChipList.elementAt(position),
                  position,
                );
              },
            )
          : Container(),
    );
  }

  Widget buildChips(String chipTitle, int index) {
    return Padding(
      padding: const EdgeInsets.only(right: 8),
      child: InputChip(
        padding: const EdgeInsets.all(2),
        backgroundColor: chipColor,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(4))),
        deleteIcon: MySvgAssetsImg(
          imageName: 'remove.svg',
          fit: BoxFit.cover,
          imgHeight: 15,
          imgWidth: 15,
        ),
        label: MyText(
          mTitle: chipTitle,
          mFontSize: 11,
          mFontWeight: FontWeight.w400,
          mFontStyle: FontStyle.normal,
          mTextAlign: TextAlign.center,
          mMaxLine: 1,
          mOverflow: TextOverflow.ellipsis,
          mTextColor: textTitleColor,
        ),
        onDeleted: () {
          print(chipTitle);
          print(index);

          if (serviceChipList.contains(chipTitle)) {
            serviceChipList.removeAt(index);
          } else if (healthCareChipList.contains(chipTitle)) {
            healthCareChipList.removeAt(index);
          }
          setState(() {});
        },
      ),
    );
  }

  Future<void> imagePickDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                MyText(
                  mTitle: pickImageNote,
                  mTextColor: black,
                  mFontSize: 18,
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: MyText(
                mTitle: pickFromGallery,
                mTextColor: blue,
                mFontSize: 18,
                mFontStyle: FontStyle.normal,
                mFontWeight: FontWeight.bold,
                mTextAlign: TextAlign.center,
              ),
              onPressed: () {
                Navigator.of(context).pop();
                getFromGallery();
              },
            ),
            TextButton(
              child: MyText(
                mTitle: captureByCamera,
                mTextColor: blue,
                mFontSize: 18,
                mFontStyle: FontStyle.normal,
                mFontWeight: FontWeight.bold,
                mTextAlign: TextAlign.center,
              ),
              onPressed: () {
                Navigator.of(context).pop();
                getFromCamera();
              },
            ),
            TextButton(
              child: MyText(
                mTitle: cancel,
                mTextColor: black,
                mFontSize: 18,
                mFontStyle: FontStyle.normal,
                mFontWeight: FontWeight.normal,
                mTextAlign: TextAlign.center,
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  /// Get from gallery
  getFromGallery() async {
    final XFile? pickedFile = await imagePicker.pickImage(
      source: ImageSource.gallery,
      maxWidth: 1000,
      maxHeight: 1000,
      imageQuality: 100,
    );
    if (pickedFile != null) {
      setState(() {
        pickedImageFile = File(pickedFile.path);
        log("Gallery ImageFile ==> " + pickedImageFile!.path);
      });
    }
  }

  /// Get from Camera
  getFromCamera() async {
    final XFile? pickedFile = await imagePicker.pickImage(
      source: ImageSource.camera,
      maxWidth: 1000,
      maxHeight: 1000,
      imageQuality: 100,
    );
    if (pickedFile != null) {
      setState(() {
        pickedImageFile = File(pickedFile.path);
        log("Camera ImageFile ==> " + pickedImageFile!.path);
      });
    }
  }

// ====== Doctor Details Edit layout END ====== //

// ====== Clinic Location layout START ====== //
  Widget locationEditPage() {
    return Stack(
      children: [
        GoogleMap(
          zoomGesturesEnabled: true,
          onMapCreated: _onMapCreated,
          mapType: currentMapType,
          initialCameraPosition: CameraPosition(
            target: startLocation,
            zoom: 14,
          ),
          markers: _markers.values.toSet(),
        ),
        Align(
          alignment: Alignment.topRight,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const SizedBox(
                height: 15,
              ),
              InkWell(
                onTap: () async {
                  // var place = await
                  // PlacesAutocomplete.show(
                  //     context: context,
                  //     apiKey: Constant.googleApikey,
                  //     mode: Mode.overlay,
                  //     types: [],
                  //     strictbounds: false,
                  //     components: [
                  //       Component(Component.country, 'np'),
                  //       Component(Component.country, 'ind'),
                  //       Component(Component.country, 'us'),
                  //       Component(Component.country, 'fr'),
                  //     ],
                  //     //google_map_webservice package
                  //     onError: (err) {
                  //       log('Google map Autocomplete error ==>> $err');
                  //     });

                  // if (place != null) {
                  //   setState(() {
                  //     location = place.description.toString();
                  //     log('location ==>> $location');
                  //   });

                  //   //form google_maps_webservice package
                  //   // final plist = GoogleMapsPlaces(
                  //   //   apiKey: Constant.googleApikey,
                  //   //   apiHeaders: await const GoogleApiHeaders().getHeaders(),
                  //   //   //from google_api_headers package
                  //   // );
                  //   // String placeid = place.placeId ?? "0";
                  //   // log('Google map Placeid ==>> $placeid');
                  //   // final detail = await plist.getDetailsByPlaceId(placeid);
                  //   // final geometry = detail.result.geometry!;
                  //   // final lat = geometry.location.lat;
                  //   // final lang = geometry.location.lng;
                  //   // var newlatlang = LatLng(lat, lang);
                  //   // log('New latlang ==>> $newlatlang');

                  //   //move map camera to selected place with animation
                  //   // mapController?.animateCamera(
                  //   //   CameraUpdate.newCameraPosition(
                  //   //     CameraPosition(target: newlatlang, zoom: 17),
                  //   //   ),
                  //   // );
                  // }
                },
                child: Container(
                  width: 50,
                  height: 50,
                  margin: const EdgeInsets.only(right: 20),
                  alignment: Alignment.center,
                  decoration: const BoxDecoration(
                    color: primaryColor,
                    shape: BoxShape.circle,
                  ),
                  child: MySvgAssetsImg(
                    imageName: 'search.svg',
                    imgHeight: 18,
                    imgWidth: 18,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              Container(
                width: 50,
                height: 50,
                margin: const EdgeInsets.only(right: 20),
                child: FloatingActionButton(
                  onPressed: () {
                    log('button pressed');
                    onMapTypeButtonPressed();
                  },
                  materialTapTargetSize: MaterialTapTargetSize.padded,
                  backgroundColor: primaryColor,
                  elevation: 5,
                  child: const Icon(Icons.map, size: 36),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  void onMapTypeButtonPressed() {
    setState(() {
      currentMapType =
          currentMapType == MapType.normal ? MapType.satellite : MapType.normal;
    });
  }
// ====== Clinic Location layout END ====== //

// ====== Working Hours layout START ====== //
  Widget workHourEditPage() {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          const SizedBox(
            height: 20,
          ),
          ListView.builder(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: 7,
            itemBuilder: (BuildContext context, int position) =>
                buildWorkSlots(position),
          ),
          const SizedBox(
            height: 100,
          ),
        ],
      ),
    );
  }

  Widget buildWorkSlots(int position) {
    return Container(
      padding: const EdgeInsets.fromLTRB(18, 0, 18, 10),
      child: InkWell(
        borderRadius: BorderRadius.circular(8),
        onTap: () {
          log("$position Item Clicked!");
          Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => const AddWorkSlot()));
        },
        child: Container(
          constraints: const BoxConstraints(
            minHeight: 44,
          ),
          decoration: BoxDecoration(
            color: white,
            border: Border.all(
              color: boxBorderColor,
              width: .5,
            ),
            borderRadius: BorderRadius.circular(4),
            shape: BoxShape.rectangle,
          ),
          child: Column(
            children: <Widget>[
              Container(
                padding: const EdgeInsets.only(left: 15, right: 15),
                height: 44,
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: MyText(
                        mTitle: weekDays.elementAt(position).toString(),
                        mFontSize: 15,
                        mFontStyle: FontStyle.normal,
                        mFontWeight: FontWeight.w600,
                        mTextAlign: TextAlign.start,
                        mMaxLine: 1,
                        mOverflow: TextOverflow.ellipsis,
                        mTextColor: textTitleColor,
                      ),
                    ),
                    MySvgAssetsImg(
                      imageName: "view_more.svg",
                      fit: BoxFit.cover,
                      imgHeight: 12,
                      imgWidth: 6,
                      iconColor: otherColor,
                    )
                  ],
                ),
              ),
              Column(
                children: <Widget>[
                  Container(
                    height: 0.5,
                    color: boxBorderColor,
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: 3,
                    itemBuilder: (BuildContext context, int position) =>
                        buildWorkTiming(position),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildWorkTiming(int position) {
    return Container(
      padding: const EdgeInsets.fromLTRB(15, 0, 15, 8),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          MySvgAssetsImg(
            imageName: "watch.svg",
            fit: BoxFit.cover,
            imgHeight: 15,
            imgWidth: 15,
            iconColor: otherColor,
          ),
          const SizedBox(
            width: 9,
          ),
          MyText(
            mTitle: "10:00 am to 01:00 pm",
            mFontSize: 15,
            mFontStyle: FontStyle.normal,
            mFontWeight: FontWeight.normal,
            mTextAlign: TextAlign.start,
            mMaxLine: 1,
            mOverflow: TextOverflow.ellipsis,
            mTextColor: otherColor,
          ),
        ],
      ),
    );
  }
// ====== Working Hours layout END ====== //

}
