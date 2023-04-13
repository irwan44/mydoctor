import 'package:doctorapp/model/hissmodel.dart';
import 'package:flutter/material.dart';
import 'package:doctorapp/model/pasienmodel.dart';
import 'package:doctorapp/model/periksamodel.dart';

class AuthPasienData with ChangeNotifier {
  late List<AntrianPasienProfile> _model;
  late PeriksaPasienProfile _modelPeriksa;
  late AntrianPasienProfile _modelprofile;
  late AntrianPasienProfile _penda;
  List<AntrianPasienProfile> get DataAntrian => _model;
  PeriksaPasienProfile get DataPeriksa => _modelPeriksa;
  AntrianPasienProfile get DataPeriksaProfile => _modelprofile;
  AntrianPasienProfile get DataUserpendatan => _penda;

  void setDataUserDoketer(List<AntrianPasienProfile> value) {
    _penda = value as AntrianPasienProfile;
    notifyListeners();
  }

  void setDataAntrian(List<AntrianPasienProfile> value) {
    _model = value;
    notifyListeners();
  }

  void setDataPeriksa(PeriksaPasienProfile value) {
    _modelPeriksa = value;
    notifyListeners();
  }

  void setDataPeriksaProfile(AntrianPasienProfile value) {
    _modelprofile = value;
    notifyListeners();
  }
}

class TindakanList with ChangeNotifier {
  late List<DataTindakan> _items = [];
  List<DataTindakan> get DataTindakanPasien => _items;

  void addItem(DataTindakan itemData) async {
    _items.add(DataTindakan(
        type: itemData.type,
        keterangan: itemData.keterangan,
        iD: '1',
        qty: '1',
        jumlah: '1'));
    notifyListeners();

    // print('jumrecord .' + _items.length.toString());

    // for (var itemloop in _items) {
    //   print('P .' + itemloop.keterangan);
    // }
  }

  void resetItem() {
    _items = [];
    notifyListeners();
  }
}
