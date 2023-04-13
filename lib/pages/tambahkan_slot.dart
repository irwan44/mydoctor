import 'dart:developer';

import 'package:doctorapp/model/timeschedule.dart';
import 'package:doctorapp/model/workslotmodel.dart';
import 'package:doctorapp/utils/colors.dart';
import 'package:doctorapp/utils/constant.dart';
import 'package:doctorapp/utils/strings.dart';
import 'package:doctorapp/utils/utility.dart';
import 'package:doctorapp/widgets/mysvgassetsimg.dart';
import 'package:doctorapp/widgets/mytext.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';

class AddWorkSlot extends StatefulWidget {
  const AddWorkSlot({Key? key}) : super(key: key);

  @override
  State<AddWorkSlot> createState() => _AddWorkSlotState();
}

class _AddWorkSlotState extends State<AddWorkSlot> {
  String slotGapValue = '15 minutes';
  TimeOfDay currentTime = TimeOfDay.now();
  List<WorkSlotModel> workSlotList = [];
  List<TimeScheduleModel> timeScheduleList = [];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: appBgColor,
      appBar: myAppBar(),
      body: Container(
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: createWorkSlotList(),
                ),
              ],
            ),
            Positioned(
              bottom: 60,
              right: 10,
              child: FloatingActionButton(
                onPressed: () {
                  addEmptySlot();
                },
                backgroundColor: accentColor,
                child: const Icon(
                  Icons.add,
                  color: white,
                ),
              ),
            ),
            Positioned(
              bottom: 10,
              child: InkWell(
                onTap: () {
                  print('Tapped on ' + save);
                },
                child: Container(
                  height: Constant.buttonHeight,
                  width: MediaQuery.of(context).size.width * 0.4,
                  margin: const EdgeInsets.only(left: 5, right: 5),
                  alignment: Alignment.center,
                  decoration: Utility.primaryDarkButton(),
                  child: MyText(
                    mTitle: save.toUpperCase(),
                    mFontSize: 16,
                    mFontStyle: FontStyle.normal,
                    mFontWeight: FontWeight.normal,
                    mTextAlign: TextAlign.center,
                    mTextColor: white,
                  ),
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
        mTitle: stateWorkHours,
        mFontSize: 20,
        mFontStyle: FontStyle.normal,
        mFontWeight: FontWeight.normal,
        mTextAlign: TextAlign.center,
        mTextColor: white,
      ),
    );
  }

  void addEmptySlot() {
    List<TimeScheduleModel> tempTimeScheduleList = [];
    TimeScheduleModel timeScheduleModel = TimeScheduleModel();
    tempTimeScheduleList.add(timeScheduleModel);

    WorkSlotModel workSlotModel = WorkSlotModel();
    workSlotModel.setStartTime = "00:00";
    workSlotModel.setEndTime = "00:00";
    workSlotModel.setDurationGap = "00";
    workSlotModel.setTimeSchedule = tempTimeScheduleList;

    workSlotList.add(workSlotModel);
    setState(() {
      print('${workSlotList.length}');
      createWorkSlotList();
    });
  }

  Widget createWorkSlotList() {
    return workSlotList.isNotEmpty
        ? ListView.builder(
            scrollDirection: Axis.vertical,
            physics: const AlwaysScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: workSlotList.length,
            itemBuilder: (BuildContext context, int position) {
              return buildWorkSlot(position);
            },
          )
        : Container();
  }

  Widget buildWorkSlot(int position) {
    return Container(
      key: ValueKey(position),
      padding: const EdgeInsets.fromLTRB(18, 12, 18, 12),
      child: Container(
        padding: const EdgeInsets.all(15),
        constraints: const BoxConstraints(
          minHeight: 0,
        ),
        decoration: BoxDecoration(
          color: white,
          border: Border.all(
            color: boxBorderColor,
            width: .5,
          ),
          borderRadius: BorderRadius.circular(10),
          shape: BoxShape.rectangle,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                Expanded(
                  child: InkWell(
                    onTap: () {
                      log('position => $position');
                      selectTime(context, position, "Start");
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        MyText(
                          mTitle: startTime,
                          mFontSize: 14,
                          mFontStyle: FontStyle.normal,
                          mFontWeight: FontWeight.normal,
                          mTextAlign: TextAlign.start,
                          mMaxLine: 1,
                          mOverflow: TextOverflow.ellipsis,
                          mTextColor: otherColor,
                        ),
                        const SizedBox(
                          height: 3,
                        ),
                        Container(
                          height: 45,
                          padding: const EdgeInsets.only(left: 8, right: 8),
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: boxBorderColor,
                              width: .5,
                            ),
                            borderRadius: BorderRadius.circular(4),
                            shape: BoxShape.rectangle,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              MyText(
                                mTitle: workSlotList
                                        .elementAt(position)
                                        .startTime
                                        .isNotEmpty
                                    ? workSlotList.elementAt(position).startTime
                                    : '--:--',
                                mFontSize: 15,
                                mFontStyle: FontStyle.normal,
                                mFontWeight: FontWeight.normal,
                                mTextAlign: TextAlign.start,
                                mMaxLine: 1,
                                mOverflow: TextOverflow.ellipsis,
                                mTextColor: textTitleColor,
                              ),
                              MySvgAssetsImg(
                                imageName: "watch.svg",
                                fit: BoxFit.cover,
                                imgHeight: 15,
                                imgWidth: 15,
                                iconColor: otherLightColor,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: InkWell(
                    onTap: () {
                      log('position => $position');
                      selectTime(context, position, "End");
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        MyText(
                          mTitle: endTime,
                          mFontSize: 14,
                          mFontStyle: FontStyle.normal,
                          mFontWeight: FontWeight.normal,
                          mTextAlign: TextAlign.start,
                          mMaxLine: 1,
                          mOverflow: TextOverflow.ellipsis,
                          mTextColor: otherColor,
                        ),
                        const SizedBox(
                          height: 3,
                        ),
                        Container(
                          height: 45,
                          padding: const EdgeInsets.only(left: 8, right: 8),
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: boxBorderColor,
                              width: .5,
                            ),
                            borderRadius: BorderRadius.circular(4),
                            shape: BoxShape.rectangle,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              MyText(
                                mTitle: workSlotList
                                        .elementAt(position)
                                        .endTime
                                        .isNotEmpty
                                    ? workSlotList
                                        .elementAt(position)
                                        .getEndTime
                                    : '--:--',
                                mFontSize: 15,
                                mFontStyle: FontStyle.normal,
                                mFontWeight: FontWeight.normal,
                                mTextAlign: TextAlign.start,
                                mMaxLine: 1,
                                mOverflow: TextOverflow.ellipsis,
                                mTextColor: textTitleColor,
                              ),
                              MySvgAssetsImg(
                                imageName: "watch.svg",
                                fit: BoxFit.cover,
                                imgHeight: 15,
                                imgWidth: 15,
                                iconColor: otherLightColor,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  width: 15,
                ),
                InkWell(
                  onTap: () {
                    print('Tapped on Delete! => $position');
                    removeWorkSlot(position);
                  },
                  child: MySvgAssetsImg(
                    imageName: "delete.svg",
                    fit: BoxFit.cover,
                    imgHeight: 45,
                    imgWidth: 45,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Container(
              height: Constant.textFieldHeight,
              padding: const EdgeInsets.only(left: 15, right: 15),
              decoration: Utility.textFieldBGWithBorder(),
              alignment: Alignment.centerLeft,
              child: DropdownButtonHideUnderline(
                child: DropdownButtonFormField2(
                  key: ValueKey(position),
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
                  value: workSlotList.elementAt(position).getDurationGap == "00"
                      ? slotGapValue
                      : (workSlotList.elementAt(position).getDurationGap +
                          " minutes"),
                  onChanged: (String? newValue) {
                    print('newValue :=> $newValue');
                    print('position :=> $position');
                    setState(() {
                      if (newValue == '15 minutes') {
                        workSlotList.elementAt(position).setDurationGap = '15';
                      } else if (newValue == '30 minutes') {
                        workSlotList.elementAt(position).setDurationGap = '30';
                      } else if (newValue == '45 minutes') {
                        workSlotList.elementAt(position).setDurationGap = '45';
                      } else if (newValue == '60 minutes') {
                        workSlotList.elementAt(position).setDurationGap = '60';
                      } else {
                        workSlotList.elementAt(position).setDurationGap = '00';
                        return;
                      }

                      print(
                          'StartTime :=> ${workSlotList.elementAt(position).getStartTime}');
                      print(
                          'EndTime :=> ${workSlotList.elementAt(position).getEndTime}');
                      if (workSlotList.elementAt(position).getStartTime !=
                              '00:00' &&
                          workSlotList.elementAt(position).getEndTime !=
                              '00:00') {
                        createWorkTiming(position);
                      }
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
                  items: <String>[
                    '15 minutes',
                    '30 minutes',
                    '45 minutes',
                    '60 minutes',
                  ].map<DropdownMenuItem<String>>((String value) {
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
            buildWorkTiming(position),
          ],
        ),
      ),
    );
  }

  Future<void> selectTime(
      BuildContext context, int position, String type) async {
    final TimeOfDay? pickedS = await showTimePicker(
      context: context,
      initialTime: currentTime,
    );

    if (pickedS != null && pickedS != currentTime) {
      setState(() {
        log('picked Time ==> $pickedS');
        if (type == 'Start') {
          workSlotList.elementAt(position).setStartTime =
              "${pickedS.hour}:${pickedS.minute}";
        } else if (type == 'End') {
          workSlotList.elementAt(position).setEndTime =
              "${pickedS.hour}:${pickedS.minute}";
        }
      });
    }
  }

  void removeWorkSlot(int position) {
    print(position);

    workSlotList.removeAt(position);
    setState(() {});
  }

  void createWorkTiming(int position) {
    timeScheduleList = Utility.getTimeFromSlot(
        workSlotList.elementAt(position).getDurationGap,
        workSlotList.elementAt(position).getStartTime,
        workSlotList.elementAt(position).getEndTime);

    setState(() {
      buildWorkTiming(position);
    });
  }

  Widget buildWorkTiming(int timePosition) {
    log('timeScheduleList => ${timeScheduleList.length}');
    return (timeScheduleList.isNotEmpty)
        ? Container(
            constraints: const BoxConstraints(
              minHeight: 0,
              minWidth: 0,
            ),
            child: GridView.builder(
              itemCount: timeScheduleList.length,
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemBuilder: (BuildContext context, int position) =>
                  workTimeItem(position),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4,
                childAspectRatio: 2 / 1,
                crossAxisSpacing: 8,
                mainAxisSpacing: 8,
              ),
            ),
          )
        : Container();
  }

  Widget workTimeItem(int position) {
    return Container(
      alignment: Alignment.center,
      padding: const EdgeInsets.only(left: 8, right: 8),
      decoration: BoxDecoration(
        border: Border.all(
          color: otherLightColor,
          width: .5,
        ),
        borderRadius: BorderRadius.circular(4),
        shape: BoxShape.rectangle,
      ),
      child: MyText(
        mTitle: timeScheduleList.elementAt(position).time,
        mFontSize: 11,
        mFontStyle: FontStyle.normal,
        mFontWeight: FontWeight.normal,
        mTextAlign: TextAlign.start,
        mMaxLine: 1,
        mOverflow: TextOverflow.ellipsis,
        mTextColor: textTitleColor,
      ),
    );
  }
}
