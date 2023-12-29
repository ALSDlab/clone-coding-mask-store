import 'package:clone_coding_mask_search/mask_model/store_model.dart';
import 'package:clone_coding_mask_search/repository/store_repository.dart';
import 'package:flutter/cupertino.dart';

class StoreModel with ChangeNotifier {
  bool isLoading = false;

  List<Store> stores = [];
  final _storeRepository = StoreRepository();


  StoreModel() {
    fetch();
  }

  Future fetch() async {
    isLoading = true;
    notifyListeners();


    stores = await _storeRepository.fetch();
    isLoading = false;
    notifyListeners();
  }
}
