import 'dart:convert';

import 'package:fakestore_api_integration/model/fakestore_api_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class HomeScreenController with ChangeNotifier {
  List<FakeStoreApiModel> productsList = [];
  String baseUrl = "https://fakestoreapi.com/products";

  bool isLoading = false;
  // fetch data from api
  Future fetchData() async {
    isLoading = true;
    notifyListeners();
    Uri url = Uri.parse(baseUrl);
    var response = await http.get(url);

    // checking status code
    if (response.statusCode >= 200 && response.statusCode < 300) {
      // converting json
      var decodedData = jsonDecode(response.body);

      // converting to productslist
      productsList = decodedData
          .map<FakeStoreApiModel>(
              (element) => FakeStoreApiModel.fromJson(element))
          .toList();
    }
    isLoading = false;
    notifyListeners();
  }
}
