import 'dart:developer';

import 'package:doctorapp/pages/detail_antrian.dart';
import 'package:doctorapp/utils/colors.dart';
import 'package:doctorapp/widgets/mynetworkimg.dart';
import 'package:doctorapp/widgets/mysvgassetsimg.dart';
import 'package:doctorapp/widgets/mytext.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:doctorapp/utils/strings.dart';
import 'package:doctorapp/model/pasienmodel.dart';
//import 'package:doctorapp/pages/pasien/component/itemantrian_pasien_detail.dart';

class PasientAntrianItem extends StatefulWidget {
  final AntrianPasienProfile dataantrian;
  const PasientAntrianItem({Key? key, required this.dataantrian})
      : super(key: key);

  @override
  State<PasientAntrianItem> createState() => _PasientAppointmentItemState();
}

class _PasientAppointmentItemState extends State<PasientAntrianItem> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(18, 12, 18, 12),
      child: InkWell(
        borderRadius: BorderRadius.circular(8),
        onTap: () {
          log("Item Clicked!");
          // Navigator.of(context).push(MaterialPageRoute(
          //     builder: (context) => PasientAntrianDetail(
          //           pasienProfile: widget.dataantrian,
          //         )));
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
                                    mTitle: widget.dataantrian.nama_px,
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
                                        mTitle: ":" + widget.dataantrian.no_mr,
                                        mFontSize: 12,
                                        mFontWeight: FontWeight.normal,
                                        mTextAlign: TextAlign.start,
                                        mTextColor: otherLightColor,
                                      ),
                                      const SizedBox(
                                        width: 4,
                                      ),
                                      // MyText(
                                      //   mTitle: widget.dataantrian.no_mr,
                                      //   mFontSize: 12,
                                      //   mFontWeight: FontWeight.normal,
                                      //   mTextAlign: TextAlign.start,
                                      //   mTextColor: otherLightColor,
                                      // ),
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
                                        mTitle: widget.dataantrian.alergi_px,
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
                                mTitle: widget.dataantrian.jam_daftar,
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
                child:
                    // MyNetworkImage(
                    //   imageUrl: widget.dataantrian.url_foto_px,
                    //   fit: BoxFit.fill,
                    //   imgHeight: 61,
                    //   imgWidth: 54,
                    // ),
                    FadeInImage.assetNetwork(
                  placeholder: 'assets/images/avatar.png',
                  image: widget.dataantrian.url_foto_px,
                  fit: BoxFit.fitHeight,
                  width: 61,
                  height: 74,
                  imageErrorBuilder: (context, url, error) =>
                      const Icon(Icons.people_outline_rounded),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
