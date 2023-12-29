import 'package:clone_coding_mask_search/ui/widget/remainStatWidget.dart';
import 'package:clone_coding_mask_search/viewmodel/store_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    final storeModel = Provider.of<StoreModel>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('마스크 재고 있는 곳 : ${storeModel.stores.length}곳'),
        actions: [
          IconButton(
            onPressed: () {
              storeModel.fetch();
            },
            icon: const Icon(Icons.refresh),
          ),
        ],
      ),
      body: storeModel.isLoading
          ? loadingWidget()
          : ListView(
              children: storeModel.stores.map((e) {
                return RemainStatWidget(store: e);
              }).toList(),
            ),
    );
  }

  Widget loadingWidget() {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [Text('정보를 가져오는 중'), CircularProgressIndicator()],
      ),
    );
  }
}
