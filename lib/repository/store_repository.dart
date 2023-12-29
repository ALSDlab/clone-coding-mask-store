import 'dart:convert';
import 'package:clone_coding_mask_search/mask_model/store_model.dart';
import 'package:clone_coding_mask_search/repository/location_repository.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';

import 'package:http/http.dart' as http;

class StoreRepository {
  final Distance _distance = const Distance();
  final _locationRepository = LocationRepository();

  Future<List<Store>> fetch() async {
    final List<Store> stores = [];

    var url = Uri.https('gist.githubusercontent.com',
        '/junsuk5/bb7485d5f70974deee920b8f0cd1e2f0/raw/063f64d9b343120c2cb01a6555cf9b38761b1d94/sample.json');

    try {
      var response = await http.get(url);

      if (response.statusCode == 200) {
        final jsonResult = jsonDecode(utf8.decode(response.bodyBytes));
        final jsonStores = jsonResult['stores'];
        Position position = await _locationRepository.getCurrentLocation();

        jsonStores.forEach((e) {
          final store = Store.fromJson(e);
          final km = _distance.as(
              LengthUnit.Kilometer,
              LatLng(store.lat as double, store.lng as double),
              LatLng(position.latitude, position.longitude));
          store.km = km;
          stores.add(store);
        });

        return stores
            .where((e) =>
                e.remainStat == 'plenty' ||
                e.remainStat == 'some' ||
                e.remainStat == 'few')
            .toList()
          ..sort((a, b) => a.km.compareTo(b.km));
      } else {
        return [];
      }
    } catch (e) {
      return [];
    }
  }
}
