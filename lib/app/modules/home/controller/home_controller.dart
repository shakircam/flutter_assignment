import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_assessment/app/modules/home/model/product_item.dart';
import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;

class HomeController extends ChangeNotifier {
  List<ProductItem> _allProducts = [];
  List<ProductItem> _filteredProducts = [];
  List<ProductItem> get filteredProducts => _filteredProducts;

  Future<void> loadProducts() async {
    final String response = await rootBundle.loadString('assets/product.json');
    final List<dynamic> data = jsonDecode(response);
    _allProducts = data.map((json) => ProductItem.fromJson(json)).toList();
    _filteredProducts = List.from(_allProducts);
    notifyListeners();
  }

  void sortByNewest() {
    _filteredProducts.sort((a, b) => b.dateCreated.compareTo(a.dateCreated));
    notifyListeners();
  }

  void sortByOldest() {
    _filteredProducts.sort((a, b) => a.dateCreated.compareTo(b.dateCreated));
    notifyListeners();
  }

  void sortByPriceLowToHigh() {
    _filteredProducts
        .sort((a, b) => double.parse(a.price).compareTo(double.parse(b.price)));
    notifyListeners();
  }

  void sortByPriceHighToLow() {
    _filteredProducts
        .sort((a, b) => double.parse(b.price).compareTo(double.parse(a.price)));
    notifyListeners();
  }
}
