

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../apiservice/serviceapi.dart';
import '../horizontal_bar.dart';
import '../model/dataHomePageModel.dart';
import '../model/pasienmodel.dart';
import '../model/usermodel.dart';
import '../provider/auth_user.dart';
import '../provider/pasien_prov.dart';
import '../tab_bar_part.dart';
import '../utils/colors.dart';
import '../widgets/mytext.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}



class _HomeScreenState extends State<HomeScreen> {

  bool _slowAnimations = false;
  UserProfile _hUser = new UserProfile();
  List<AntrianPasienProfile> _hAntrian = [];

  @override
  void initState() {
    _getUserProvider();
    super.initState();
  }
  _getUserProvider() async {
    final AuthUserData tablesProvider =
    Provider.of<AuthUserData>(context, listen: false);
    final UserProfile _user = tablesProvider.DataUser;
    _hUser = _user;

    String idDokter = _hUser.userId;
    _hAntrian = await UserApiService.getPasienAntri('', idDokter);
    Provider.of<AuthPasienData>(context, listen: false)
        .setDataAntrian(_hAntrian);
  }

  @override
  Widget build(BuildContext context) {
    final chartData = [
      Data(text: '+\$100',units: 25, color: Color.fromARGB(255, 6, 156, 96)),
      Data(units: 25, color: Color.fromARGB(255, 241, 80, 58), text: '+\$100'),
      Data(text: '+\$100',units: 25, color: Color.fromARGB(255, 209, 153, 12)),
      Data(text: '+\$100',units: 25, color: Color.fromARGB(255, 236, 232, 226)),
    ];
    String urlfoto =  _hUser.url_foto_karyawan;
    urlfoto = urlfoto.replaceAll('..', '');

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color.fromARGB(255, 35, 163, 223),
              Color.fromARGB(255, 35, 163, 223),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.only(top: 50),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8.0),
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children:  [
                        Text.rich(
                          TextSpan(
                            children: [
                              TextSpan(text:'Pendapatan',
                                style: TextStyle(
                                fontWeight: FontWeight.w900,
                                color: Colors.white,
                                fontSize: 23,
                              ),),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        MyText(
                          mTitle: _hUser.userName,
                          mTextAlign: TextAlign.start,
                          mTextColor: white,
                          mFontSize: 22,
                          mFontStyle: FontStyle.normal,
                          mFontWeight: FontWeight.bold,
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        MyText(
                          mTitle: "Klinik . " + _hUser.userTitle,
                          mTextAlign: TextAlign.start,
                          mTextColor: text70OpacColor,
                          mFontSize: 16,
                          mFontStyle: FontStyle.normal,
                          mFontWeight: FontWeight.w400,
                        ),
                      ],
                    ),
                  ),
                  Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 30),
                        child: CircleAvatar(
                          radius: 22,
                          backgroundColor: Colors.blueGrey,
                          child: CircleAvatar(
                            radius: 20,
                            backgroundImage: NetworkImage(
                                urlfoto),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(right: 10.0,top: 5.0),
                        child: Text(
                          "Balance",
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                    FutureBuilder<GetHomePage>(
                    future: UserApiService.getHomePage(bulan: '02', idDokter: '74'),
                    builder: (context, snapshot) {
                    if (snapshot.hasData && snapshot.data != null &&
                    snapshot.connectionState != ConnectionState.waiting) {
                    GetHomePage data = snapshot.data!;
                    return
                      Padding(
                        padding: EdgeInsets.only(right: 10.0),
                        child: Text(
                          data.list![0].pendapatan.toString(),
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w700,
                            fontSize: 15,
                          ),
                        ),
                      );}else {
                      return Center(child: CircularProgressIndicator(),);
                    }
                    }
                    ),
                    ],
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.only(top: 30),
              alignment: Alignment.center,
              child: Column(
                children:  [
                  Padding(
                    padding: const EdgeInsets.only(top: 1.0),
                    child: Center(
                      child: SizedBox(
                        height: 50,
                        child: HorizontalBarChart(
                          data: chartData,
                        ),
                      ),
                    ),)
                ],
              ),
            ),


           Container(
              child: Container(
                margin: const EdgeInsets.only(top: 30),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(
                    Radius.circular(20.0),
                  ),
                ),
                child: const TabBarPart(),
                //child: Text('data'),
              ),
            ),
          ],
        ),
      ),


    );
  }
}


 