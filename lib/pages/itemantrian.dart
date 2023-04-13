import 'dart:developer';

import 'package:doctorapp/pages/detail_antrian.dart';
import 'package:doctorapp/utils/colors.dart';
import 'package:doctorapp/widgets/mynetworkimg.dart';
import 'package:doctorapp/widgets/mysvgassetsimg.dart';
import 'package:doctorapp/widgets/mytext.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../utils/strings.dart';

class UpcomingAppointmentItem extends StatefulWidget {
  final String title, subTitle, imageUrl, mobileNumber, date, status;

  const UpcomingAppointmentItem(this.title, this.subTitle, this.imageUrl,
      this.mobileNumber, this.date, this.status,
      {Key? key})
      : super(key: key);

  @override
  State<UpcomingAppointmentItem> createState() =>
      _UpcomingAppointmentItemState();
}

class _UpcomingAppointmentItemState extends State<UpcomingAppointmentItem> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(18, 12, 18, 12),
      child: InkWell(
        borderRadius: BorderRadius.circular(8),
        onTap: () {
          log("Item Clicked!");
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => const AppointmentDetails()));
        },
        child: Stack(
          children: <Widget>[
            ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: 82,
                minWidth: MediaQuery.of(context).size.width,
              ),
              child: Card(
                clipBehavior: Clip.antiAlias,
                elevation: 3,
                color: white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Container(
                  padding: const EdgeInsets.all(8),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Expanded(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Container(
                              margin: const EdgeInsets.only(left: 62),
                              alignment: Alignment.topLeft,
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  MyText(
                                    mTitle: widget.title,
                                    mFontSize: 14,
                                    mFontWeight: FontWeight.bold,
                                    mTextAlign: TextAlign.start,
                                    mTextColor: textTitleColor,
                                  ),
                                  const SizedBox(
                                    height: 4,
                                  ),
                                  Row(
                                    mainAxisSize: MainAxisSize.min,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: <Widget>[
                                      MyText(
                                        mTitle: "No. MR",
                                        mFontSize: 12,
                                        mFontWeight: FontWeight.normal,
                                        mTextAlign: TextAlign.start,
                                        mTextColor: otherLightColor,
                                      ),
                                      const SizedBox(
                                        width: 4,
                                      ),
                                      MyText(
                                        mTitle: ":",
                                        mFontSize: 12,
                                        mFontWeight: FontWeight.normal,
                                        mTextAlign: TextAlign.start,
                                        mTextColor: otherLightColor,
                                      ),
                                      const SizedBox(
                                        width: 4,
                                      ),
                                      MyText(
                                        mTitle: widget.mobileNumber,
                                        mFontSize: 12,
                                        mFontWeight: FontWeight.normal,
                                        mTextAlign: TextAlign.start,
                                        mTextColor: otherLightColor,
                                      ),
                                      const SizedBox(
                                        width: 4,
                                      ),
                                      Container(
                                        width: 4,
                                        height: 4,
                                        decoration: const BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: otherLightColor,
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 4,
                                      ),
                                      MyText(
                                        mTitle: widget.status,
                                        mFontSize: 12,
                                        mFontWeight: FontWeight.normal,
                                        mTextAlign: TextAlign.start,
                                        mTextColor: pendingStatus,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 13,
                            ),
                            Container(
                              alignment: Alignment.topLeft,
                              child: MyText(
                                mTitle: widget.date,
                                mFontSize: 13,
                                mOverflow: TextOverflow.ellipsis,
                                mMaxLine: 1,
                                mFontWeight: FontWeight.normal,
                                mTextAlign: TextAlign.start,
                                mTextColor: textTitleColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Column(
                        children: <Widget>[
                          const SizedBox(
                            height: 10,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Container(
              transform: Matrix4.translationValues(12, -10, 0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(4.0),
                clipBehavior: Clip.antiAlias,
                // child: MyNetworkImage(
                //   imageUrl: widget.imageUrl,
                //   fit: BoxFit.fill,
                //   imgHeight: 61,
                //   imgWidth: 54,
                // ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
