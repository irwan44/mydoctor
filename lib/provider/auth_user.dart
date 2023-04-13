import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:doctorapp/model/usermodel.dart';

class AuthUserData with ChangeNotifier {
  late UserProfile _model;
  UserProfile get DataUser => _model;

  void setDataUser(UserProfile value) {
    _model = value;
    notifyListeners();
  }
}
