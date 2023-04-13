import 'package:doctorapp/model/pasienmodel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:doctorapp/model/usermodel.dart';

import '../model/dokterPendapatan.dart';

class UserDataDokter with ChangeNotifier {
  late Pendapatan _penda;
  Pendapatan get DataPendapatan => _penda;

  void setDataUserDoketer(Pendapatan value) {
    _penda = value;
    notifyListeners();
  }
}
